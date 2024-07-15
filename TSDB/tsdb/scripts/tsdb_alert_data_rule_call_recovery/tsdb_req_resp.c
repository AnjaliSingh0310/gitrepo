#include <stdlib.h>
#include <sched.h>
#include <string.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <pthread.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdint.h>

#include "tsdb_msg_interface.h"
#include "tsdb_id.h"
//#include "tsdb_data_query.h"
//#include "tsdb_data_call_util.c"
#define NUM_DF 6

uint8_t alert_sever_type = 1;

int get_tokens(char *read_buf, char *fields[], char *token, int max_flds)
{
  int totalFlds = 0;
  char *ptr;
  char *token_ptr = NULL;

  ptr = read_buf;
  while((token_ptr = strtok(ptr, token)) != NULL)
  {
    ptr = NULL;
    totalFlds++;
    if(totalFlds > max_flds)
    {
      //fprintf(stderr, "Total fields are more than max fields (%d), remaining fields are ignored\n", max_flds);
      totalFlds = max_flds;
      break;  /* break from while */
    }
    fields[totalFlds - 1] = token_ptr;
  }
  return(totalFlds);
}

//---------------------------------
#define SUBJECT 0
#define MEASURE 1

int fill_subject_or_measure(void* ptr, char* path, int g_mg_t, int g_mt_t, int flag, int flag2, TSDBDataCall *tsdb_dc_ptr)
{
  long n_bytes = (long)ptr;

  char *fields [10];
  uint8_t no_tokens = get_tokens(path, fields, ">",  10);

  uint8_t len;
  char *type;
  char *val;
  char mode;
  
  int id = {0, g_mg_t, g_mt_t};
 
  // memcount
  if(flag2 == 0)
  {
    if(flag == MEASURE)
      *(uint8_t *)ptr = 3;
    else
      memcpy(ptr, &no_tokens, 1);

    ptr += 1;
  }
 
  //need to remove this part use above section 
  /*if(flag == SUBJECT)
    {
      tsdb_dc_ptr->hierachy_levels = no_tokens;
      tsdb_dc_ptr->sub_mem_count = no_tokens;
    }
  if(flag == MEASURE)
    tsdb_dc_ptr->measure_mem_count = no_tokens;
  memcpy(ptr, &no_tokens, 1);
  ptr++;


  if(flag == SUBJECT)
    tsdb_dc_ptr->hierachy_levels = no_tokens;*/

  for(int i = 0; i < no_tokens; i++)
  {
     type = fields[i]; //customer:default
     val = strchr(fields[i], ':');
     *val = '\0';
  
     len = strlen(type) + 1;
     memcpy(ptr, &len, 1);
     ptr += 1;
     memcpy(ptr, type, len);
     ptr += len;
     
     val++;

     //Added to make last subject value as All and last -1 value as '*' to test Exact/All/Pattern with same data file
     if((flag == SUBJECT) && (i == (no_tokens - 1) || i == (no_tokens - 2) || i == (no_tokens - 3)) && (tsdb_dc_ptr->subject_mode == SUBJECT_MODE_ALL))
       val = "All";  
     else if((flag == SUBJECT) && (i == (no_tokens - 2)) && (tsdb_dc_ptr->subject_mode == SUBJECT_MODE_PATTERN))
       val = "*";

     len = strlen(val) + 1;
  
     memcpy(ptr, &len, 1);
     ptr += 1;
     memcpy(ptr, val, len);
     ptr += len;
     
     uint8_t mode = S_MODE_SAME;

    if(flag == SUBJECT)
    {
      if(strcasecmp(val, "all") == 0)
        mode = S_MODE_ALL;

      if(val[len - 2] == '*')
        mode = S_MODE_PATTERN;

      memcpy(ptr, &mode, 1);
      ptr += 1;
    }
    else if(flag == MEASURE)
    {
      memcpy(ptr, &id, 4);
      ptr += 4;
    }
  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "Subject[%d]>%s>%d\n",i , val, mode);
   #endif 
  }

  return (long)ptr - n_bytes; // to how many bytes it consumed 
}

int create_req_for_alert_data_call(TSDBDataCall *tsdb_dc_ptr)
{
  int mins_back = 10;
  int mins_duration = 10;

  char start_tm_buff[128] = "\0";
  char end_tm_buff[128] = "\0";
  struct tm local_tm1, local_tm2;

  memset(&local_tm1, 0, sizeof(struct tm));
  memset(&local_tm2, 0, sizeof(struct tm));

  localtime_r((time_t *)&tsdb_dc_ptr->start_ts, &local_tm1);
  strftime(start_tm_buff, 128, "%T %D", &local_tm1);

  int end_ts = tsdb_dc_ptr->end_ts;
  if(end_ts == 0)
    end_ts=time(NULL);
  localtime_r((time_t *)&end_ts, &local_tm2);
  strftime(end_tm_buff, 128, "%T %D", &local_tm2);

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "\n\nCreating request for. freq: %d, time_period = %s, start_ts: %d, end_ts: %d\n", tsdb_dc_ptr->req_freq,
                         time_period[tsdb_dc_ptr->time_period], tsdb_dc_ptr->start_ts, tsdb_dc_ptr->end_ts);
  fprintf(query_log_fp, "start_time: %s, end_time: %s\n", start_tm_buff, end_tm_buff);
  fprintf(query_log_fp, "Number of metrics: %d\n\n", tsdb_dc_ptr->req_num_metrics);
  #endif

  time_t s_time = time(NULL) - (mins_back * 60);
  time_t e_time;
  if(mins_duration == 0)
  e_time = 0;
  else
  e_time = s_time + mins_duration * 60;

  int total_size = sizeof(TSDB_Req_Alert_Rule_config_t);  
  TSDB_Init_Event_Req_Alert_Data_t *req = (TSDB_Init_Event_Req_Alert_Data_t *) tsdb_dc_ptr->buffer;
  req->msg_hdr.opcode = TSDB_ALERT_RECOVERY;
  req->number_of_rules = 0;

  int rule_id = 0;
  uint64_t max_alert_id = 0;
  int num_alerts = 0;
  int alert_id = 1;
  uint8_t reason = 1;
  uint8_t severity = 1;
  uint8_t prev_severity = 1;
  uint8_t curr_val_len = 6;
  char curr_val[] = "C1:0.2";
  int mt_cnt = 1;
  uint8_t mt_name_len = 2;
  char mt_name[] = "A"; 
  uint8_t num_tags = 2;
  uint16_t num_sub = 1;
  //char subject[] = "tier:T_0>host:host_0>instance:inst_0";
  //char subject[] = "tier:A>host:host_0>instance:inst_0";
  double mt_curr_val = 0.1;
  uint8_t t_cond = 1;
  uint8_t cond_len = 3;
  char cond_name[] = "C0";
  uint8_t rule_info_len = 4;
  char rule_info[] = "A&B";

  void *var_data = req->var_data;
 
  for(int r = 0; r < req->number_of_rules; r++)
   {
     REQ_PARSE(var_data, &rule_id, 4, total_size)
     REQ_PARSE(var_data, &max_alert_id, 8, total_size)
     REQ_PARSE(var_data, &num_alerts, 4, total_size)

  for(int i = 0; i < num_alerts; i++)
  {
    REQ_PARSE(var_data, &alert_id, 4, total_size)
    REQ_PARSE(var_data, &s_time, 8, total_size)
    REQ_PARSE(var_data, &e_time, 8, total_size)
    REQ_PARSE(var_data, &reason, 1, total_size)
    REQ_PARSE(var_data, &severity, 1, total_size)
    REQ_PARSE(var_data, &prev_severity, 1, total_size)
    REQ_PARSE(var_data, &curr_val_len, 1, total_size)
    REQ_PARSE(var_data, curr_val, curr_val_len, total_size)
    REQ_PARSE(var_data, &mt_cnt, 4, total_size)
    for(int j = 0; j < mt_cnt; j++)
    {
      REQ_PARSE(var_data, &mt_name_len, 1, total_size)
      REQ_PARSE(var_data, mt_name, mt_name_len, total_size)
      REQ_PARSE(var_data, &num_tags, 1, total_size)
      REQ_PARSE(var_data, &num_sub, 2, total_size)
      for(int k = 0; k < num_sub; k++)
      {
        ns_advance_param("subject");
        char subject_string[256] ;//= Tier:cprod-*; 
        strcpy(subject_string, ns_eval_string("{subject}"));
        #ifdef TSDB_QUERY_LOGGING
        fprintf(query_log_fp,"Subject: %s\n", subject_string);
        #endif

        //Flag2 value change to 1 for no need to calculate subject mem count
        int size = fill_subject_or_measure(var_data, subject_string, 0, 0, SUBJECT, 1, tsdb_dc_ptr);
        var_data += size;
        total_size += size;
  
      }
      REQ_PARSE(var_data, &mt_curr_val, 8, total_size)
    }
    REQ_PARSE(var_data, &t_cond, 1, total_size)
    for(int m = 0; m < t_cond; m++)
    {
      REQ_PARSE(var_data, &cond_len, 1, total_size)
      REQ_PARSE(var_data, cond_name, cond_len, total_size)
    }
    REQ_PARSE(var_data, &rule_info_len, 1, total_size)
    REQ_PARSE(var_data, rule_info, rule_info_len, total_size)
  }
}
 req->msg_hdr.msg_size = total_size - 4;
 return total_size;
}

void script_parse_alert_resp(void *buffer, int opcode)
{
  TSDB_Resp_Alert_Config_t *resp = (TSDB_Resp_Alert_Config_t*)(buffer);
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "Msg hdr opcode: %d, partition_info = %d\n", resp->msg_hdr.opcode, resp->msg_hdr.flags);
  fprintf(query_log_fp, "RT Hdr. qhead_rt: %d, tsdb_nodes: %d\n", resp->rt_hdr.qhead_rt, resp->rt_hdr.tsdb_nodes);
  fprintf(query_log_fp, "Message Length: %d, Detailed Message Length: %d\n", resp->msg_len, resp->detail_msg_len);
  #endif

  void *ptr = resp->var_data;
  long sz = (long)ptr;
  for(int i = 0; i < resp->rt_hdr.tsdb_nodes; ++i)
  {
    short *tsdb_id = (short *)ptr;
    ptr += 2;
    int *tsdb_rt = (int *)ptr;
    ptr += 4;

    #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "tsdb_id: %d, tsdb_rt: %d\n\n", *tsdb_id, *tsdb_rt);
    #endif
  }
  char msg[128];
  char detail_msg[128];
 
  memcpy(msg, ptr, resp->msg_len);
  msg[resp->msg_len] = '\0';
  ptr += resp->msg_len;

  memcpy(detail_msg, ptr, resp->detail_msg_len);
  detail_msg[resp->detail_msg_len] = '\0';
  ptr += resp->detail_msg_len;

  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"Message: %s, Detail_Message: %s\n", msg, detail_msg);
  #endif

} 
int parse_resp_for_err(void *resp_buffer, TSDBDataCall *tsdb_dc_ptr)
{
  TSDB_ErrorMessage_t *resp = (TSDB_ErrorMessage_t *)(resp_buffer);

  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"\nMessage hdr. size: %d, opcode: %d\n", resp->msg_hdr.msg_size, resp->msg_hdr.opcode);
    fprintf(query_log_fp,"Query Head: %d, TSDB_Count: %d \n", resp->rt_hdr.qhead_rt, resp->rt_hdr.tsdb_nodes);
  #endif
  //int error_code = resp->error_code;
  //short http_code = resp->http_code;
  void *var_data = resp->var_data;
  
  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"TSDB rt:\n");
  #endif
  for(int i = 0; i < resp->rt_hdr.tsdb_nodes; i++)
  {
    short *tsdb_id = (short *)var_data;
    var_data += 2;

    int *tsdb_rt = (int *)var_data;
    var_data += 4;
    #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp,"TSDB id: %d, TSDB rt: %d \n", *tsdb_id, *tsdb_rt);
    #endif
  }
  
  //char err_msg[256];
  //char detail_err_msg[128];
  uint16_t len;  

  uint16_t *err_msg_len = (uint16_t *)var_data;
  var_data += 2;
  len = *err_msg_len;

 if(*err_msg_len > 64)
  len = 64;
  memcpy(tsdb_dc_ptr->err_msg, var_data, len);
  tsdb_dc_ptr->err_msg[len] = '\0';
  var_data += *err_msg_len;

  uint16_t *detail_err_msg_len = (uint16_t *)var_data;
  var_data += 2;
  len = *detail_err_msg_len;
  if(*detail_err_msg_len > 128)
  len = 128;
  memcpy(tsdb_dc_ptr->detail_err_msg, var_data, len);
  tsdb_dc_ptr->detail_err_msg[len] = '\0';
  var_data += *detail_err_msg_len;
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"Error Code: %d, Http Code: %d, ErrorMsg: %s, DetailErrMsg = %s\n",
    resp->error_code, resp->http_code, tsdb_dc_ptr->err_msg, tsdb_dc_ptr->detail_err_msg);
  #endif
  return(resp->error_code);
}
void tsdb_parse_response(void  *resp_buffer, int msg_size, TSDBDataCall *tsdb_dc_ptr)
{
  MsgHdr_t *hdr = (MsgHdr_t *)(resp_buffer);
  int tx_name_offset = 0;

  tx_name_offset = hdr->tx_name_offset;
  void *tx_ptr = resp_buffer;
  tx_ptr += tx_name_offset;

  uint8_t *tx_len = (uint8_t *)tx_ptr;
  tx_ptr++;
  
  char tx_name[1024 + 1];
  memcpy(tx_name, tx_ptr, *tx_len);
  tx_name[*tx_len] = '\0';

  fprintf(stderr, "TXName = %s, TXLen = %d\n\n", tx_name, tx_len);


  switch(hdr->opcode)
  {
    case TSDB_ALERT_RECOVERY:
      script_parse_alert_resp(resp_buffer, hdr->opcode);
      break;
    case TSDB_QUERY_ERROR: //todo check this
      tsdb_dc_ptr->rep_error_code = parse_resp_for_err(resp_buffer, tsdb_dc_ptr);
      //fprintf(query_log_fp, "Got TSDB ERRROR Opcode: %d\n", hdr->opcode);
      break;
    default:
      tsdb_dc_ptr->rep_error_code = 9999; //  TODO - get from eror message
      fprintf(query_log_fp, "Invalid msg type in RESPONSE: %d\n", hdr->opcode);
  }
}

