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

uint8_t alert_operation = 0; //0 - For add & 1 - For update
int alert_num_of_rules = 1;
int alert_mt_attr = 0; // Metric attribute -: 0 -> AVG, 1 -> MAX, 2 -> MIN, 3 -> COUNT
uint8_t alert_cond_type = 0; //Condition Type -: 0 -> Threshold, 1 -> Change, 2 -> Anomaly, 3 -> Outlier, 4 -> Forecast
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

int fill_subject_or_measure(void* ptr, char* path, int flag, TSDBDataCall *tsdb_dc_ptr)
{
  long n_bytes = (long)ptr;

  char *fields [10];
  uint8_t no_tokens = get_tokens(path, fields, ">",  10);

  uint8_t len;
  char *type;
  char *val;
  
  int id = 0;
  
  memcpy(ptr, &no_tokens, 1);
  ptr += 1;

  if(flag == SUBJECT)
    tsdb_dc_ptr->hierachy_levels = no_tokens;

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

int create_req_for_alert_global_config(char *buffer, TSDBDataCall *tsdb_dc_ptr)
{

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
  #endif
  
  int total_size = sizeof(TSDB_Req_Alert_Global_Config_t);
  TSDB_Req_Alert_Global_Config_t *req = (TSDB_Req_Alert_Global_Config_t *) buffer;
  req->msg_hdr.msg_size = total_size - 4;
  req->msg_hdr.opcode = TSDB_QUERY_REQ_ALERT_GLOBAL_CONFIG;
  
  req->operation = 0;
  req->global_flags = 1;
  req->minimum_baseline_values = 0.01; 
  req->skip_samples_on_session_restart = 5;
  req->autoscale_skip_samples_duration = 300;

  return total_size;
}
  
void script_parse_alert_config_resp(void *buffer, int opcode)
{
  TSDB_Resp_Alert_Config_t *resp = (TSDB_Resp_Alert_Config_t*)(buffer);
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "Msg hdr opcode: %d, partition_info = %d\n", resp->msg_hdr.opcode, resp->msg_hdr.flags);
  fprintf(query_log_fp, "RT Hdr. qhead_rt: %d, tsdb_nodes: %d\n", resp->rt_hdr.qhead_rt, resp->rt_hdr.tsdb_nodes);
  fprintf(query_log_fp, "Message Length: %d, Detailed Message Length: %d\n", resp->msg_len, resp->detail_msg_len);
  #endif
  
  void *var_data = resp->var_data;

  for(int i = 0; i < resp->rt_hdr.tsdb_nodes; i++)
  {
    short *tsdb_id = (short *)var_data;
    var_data += 2;

    int *tsdb_rt = (int *)var_data;
    var_data += 4;
    printf("TSDB id: %d, TSDB rt: %d \n", *tsdb_id, *tsdb_rt);
  }

  char msg[128];
  char detail_msg[128];

  memcpy(msg, var_data, resp->msg_len);
  msg[resp->msg_len] = '\0';
  var_data += resp->msg_len;

  memcpy(detail_msg, var_data, resp->detail_msg_len);
  detail_msg[resp->detail_msg_len] = '\0';
  var_data += resp->detail_msg_len;

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
 
  RTHdr_t *rt_hdr = (RTHdr_t *)(resp_buffer + sizeof(MsgHdr_t));
  switch(hdr->opcode)
  {
    case TSDB_QUERY_REQ_ALERT_GLOBAL_CONFIG:
      script_parse_alert_config_resp(resp_buffer, hdr->opcode);
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

