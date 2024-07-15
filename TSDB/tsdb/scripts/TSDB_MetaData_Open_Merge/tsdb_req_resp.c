#include <stdlib.h>
#include <sched.h>
#include <string.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <stdlib.h>
#include <errno.h>
#include <pthread.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdint.h>
#include "tsdb_meta_query.h"
#include "ns_string.h"
#define NUM_DF 6
#define SUBJECT_MODE_ALL 1
#define SUBJECT_MODE_PATTERN 2

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


int fill_metrics_data(void *ptr, TSDBMetaCall *tsdb_dc_ptr)
{
  char metric[] = "Metric";
  int metric_len = strlen(metric) + 1;
  int mt_count = tsdb_dc_ptr->req_num_metrics;
  char metric_value[256];
  int gdf_mt_id = atoi(ns_eval_string("{Graph_ID}"));
  strcpy(metric_value, ns_eval_string("{metric}"));
  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "metric_value is: %s and id is %d \n", metric_value, gdf_mt_id);
  #endif
  int metric_val_len = strlen(metric_value) + 1;
  int total_sz = 0;

  memcpy(ptr, &metric_len, 1);
  ptr += 1;
  total_sz += 1;

  memcpy(ptr, metric, metric_len);
  ptr += metric_len;
  total_sz += metric_len;

  memcpy(ptr, &mt_count, 1);
  ptr += 1;
  total_sz += 1;

  for(int i = 0; i < mt_count; i++)
  {
    memcpy(ptr, &metric_val_len, 1);
    ptr += 1;
    total_sz += 1;
    memcpy(ptr, metric_value, metric_val_len);
    ptr += metric_val_len;
    total_sz += metric_val_len;

    uint32_t id = gdf_mt_id;
    memcpy(ptr, &id, 4);
    ptr += 4;
    total_sz += 4;
  }
  return total_sz;
}

int fill_subject_or_measure(void* ptr, char* path, int gdf_mg_id, int flag, int flag2, TSDBMetaCall *tsdb_dc_ptr)
{
  int n_bytes = (long)ptr;

  char *fields [10];
  uint8_t no_tokens = get_tokens(path, fields, ">",  10);  //sub_mem_count  if flag is SUBJECT
  int id[] = {0, gdf_mg_id};
  uint8_t len;
  char *type;
  char *val;
  uint8_t mode;

/*  if(flag2 == 0)
  {
    memcpy(ptr, &no_tokens, 1);
    ptr += 1;
  }
*/
 if (flag == SUBJECT)
 {
    mode = 0;
    tsdb_dc_ptr->sub_mem_count = no_tokens;
 }

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
    if((flag == SUBJECT) && (i == (no_tokens - 1) || i == (no_tokens - 0)) && (tsdb_dc_ptr->subject_mode == SUBJECT_MODE_ALL))
       val = "All";
     else if((flag == SUBJECT) && (i == (no_tokens - 2) || i == (no_tokens - 0)) && (tsdb_dc_ptr->subject_mode == SUBJECT_MODE_PATTERN))
       val = "*";

     len = strlen(val) + 1;

     memcpy(ptr, &len, 1);
     ptr += 1;
     memcpy(ptr, val, len);
     ptr += len;

    if(flag == SUBJECT)
    {
      mode = 1;
      if(strcasecmp(val, "all") == 0)
        mode = S_MODE_ALL;

      if(val[len - 2] == '*')
        mode = S_MODE_PATTERN;

      memcpy(ptr, &mode, 1);
      ptr += 1;
    }
    else if(flag == MEASURE)
    {
     // id = 100;
     // memcpy(ptr, &id, 4);
      *(int *)ptr = id[i];
       ptr += 4;
    }
  #ifdef TSDB_QUERY_LOGGING
    if(flag == SUBJECT)
      fprintf(query_log_fp, "Subject[%d]>%s:%s>%d\n",i , type, val, mode);
    
    if(flag == MEASURE)
      fprintf(query_log_fp, "Measure[%d]>%s:%s>%d and id is %d\n",i , type, val, mode, id[i]);
   #endif
  }

  return (long)ptr - n_bytes; // to how many bytes it consumed 
}

int create_req_for_meta_data_open_merge_call(TSDBMetaCall *tsdb_dc_ptr)
{
  char start_tm_buff[128] = "\0";
  char end_tm_buff[128] = "\0";
  struct tm local_tm1, local_tm2;

  memset(&local_tm1, 0, sizeof(struct tm));
  memset(&local_tm2, 0, sizeof(struct tm));

  localtime_r((time_t *)&tsdb_dc_ptr->start_ts, &local_tm1);
  strftime(start_tm_buff, 128, "%T %D", &local_tm1);

  localtime_r((time_t *)&tsdb_dc_ptr->end_ts, &local_tm2);
  strftime(end_tm_buff, 128, "%T %D", &local_tm2);

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "\n\nCreating request for. time_period = %s, start_ts: %ld, end_ts: %ld\n",
                         time_period[tsdb_dc_ptr->time_period], tsdb_dc_ptr->start_ts, tsdb_dc_ptr->end_ts);
  fprintf(query_log_fp, "start_time: %s, end_time: %s\n", start_tm_buff, end_tm_buff);
  #endif
  
  char app_id[] = "Default";
  char client_id[] = "Default";
  uint8_t app_id_len = strlen(app_id) + 1;
  uint8_t client_id_len = strlen(client_id) + 1;

  int total_sz = sizeof(TSDB_Req_Metadata_Open_Merge_t);
 
  //fprintf(stderr, "\n\n total_sz1- %d\n\n", total_sz);
  uint8_t show_together = 0;
  //uint8_t count = 3; 
 
  TSDB_Req_Metadata_Open_Merge_t *req = (TSDB_Req_Metadata_Open_Merge_t *) tsdb_dc_ptr->buffer;
  req->msg_hdr.opcode = TSDB_QUERY_REQ_METADATA_OPEN_MERGE;
  req->msg_hdr.version = 0;
  
  req->tr_num = 1234;
  req->start_time = tsdb_dc_ptr->start_ts;
  req->end_time = tsdb_dc_ptr->end_ts;
  req->app_id_len = app_id_len;
  req->client_id_len = client_id_len;
  req->freq = tsdb_dc_ptr->req_freq;
  req->preset = tsdb_dc_ptr->time_period;
  req->filter = tsdb_dc_ptr->mt_filter_option;
  req->exclude_overall = 0; 
  
  void *ptr = req->var_data;
  memcpy(ptr, client_id, client_id_len);
  ptr += client_id_len;

  memcpy(ptr, app_id, app_id_len);
  ptr += app_id_len;
  total_sz += client_id_len + app_id_len;
  //fprintf(stderr, "\n\n total_sz2- %d\n\n", total_sz);
  if(tsdb_dc_ptr->data_filter & DF_MT_FILTER)
  {
    // Fill metric filter and update var_data, mt_offset, total_size
    MetricFilterSpec_t *mt_filter = (MetricFilterSpec_t *)ptr;
    ptr += sizeof(MetricFilterSpec_t);
    total_sz += sizeof(MetricFilterSpec_t);
  
    //tsdb_dc_ptr->metric_filter_type will random form 0 to 3 . 0 = min , 1 = max , 2 = Avg , 3 = Count 
    #ifdef TSDB_QUERY_LOGGING
    fprintf(stderr, "\n\n FILTER_TYPE(%d)  - %s\n\n", atoi(ns_eval_string("{FILTER_TYPE}")), ns_eval_string("{FILTER_TYPE}"));
    #endif
    int filter_type = atoi(ns_eval_string("{FILTER_TYPE}"));
    tsdb_dc_ptr->metric_filter_type = filter_type;
    //fprintf(stderr, "\n\n  tsdb_dc_ptr->metric_filter_type - %d\n\n", tsdb_dc_ptr->metric_filter_type);
    if(tsdb_dc_ptr->metric_filter_type == 0)
    { 
      mt_filter->mt_filter_type |= (FLT_TYPE_MIN | FLT_TYPE_INC);
    }
    else if (tsdb_dc_ptr->metric_filter_type == 1)
    { 
      mt_filter->mt_filter_type |= (FLT_TYPE_MAX | FLT_TYPE_INC);
    }
    else if (tsdb_dc_ptr->metric_filter_type == 2)
    {
      mt_filter->mt_filter_type |= (FLT_TYPE_AVG | FLT_TYPE_INC);
    }
    else
    {
      mt_filter->mt_filter_type |= (FLT_TYPE_COUNT | FLT_TYPE_INC);
    }

    int min_op_num = atoi(ns_eval_string("{MIN_OP_NUMBER}"));
    int max_op_num = atoi(ns_eval_string("{MAX_OP_NUMBER}"));
    tsdb_dc_ptr->mt_op = mt_filter->mt_op = ns_get_random_number_int(min_op_num, max_op_num);
    //fprintf(stderr, "\n\n  tsdb_dc_ptr->mt_op - %d\n", tsdb_dc_ptr->mt_op);
    if (tsdb_dc_ptr->mt_op == 1 )
    {
       mt_filter->value1= 1.1;
       mt_filter->value2= 1.1;
    }
    else if (tsdb_dc_ptr->mt_op == 2 || tsdb_dc_ptr->mt_op == 3)
    {
       mt_filter->value1= 1;
       mt_filter->value2= 5;
    }
    else if (tsdb_dc_ptr->mt_op == 4 || tsdb_dc_ptr->mt_op == 5)
    {
       mt_filter->value1= 70;
       mt_filter->value2= 70;
    }
     else if (tsdb_dc_ptr->mt_op == 6)
    {
       mt_filter->value1= 60;
       mt_filter->value2= 90;
    }
     else if (tsdb_dc_ptr->mt_op == 7 || tsdb_dc_ptr->mt_op == 8)
    {
       mt_filter->value1= 40;
       mt_filter->value2= 10;
    }
  }
  char subject_string[256];
  char measure_string[256];
  
  strcpy(subject_string, ns_eval_string("{subject}"));
  strcpy(measure_string, ns_eval_string("{measure}"));

  int gdf_mg_id = atoi(ns_eval_string("{GDF_ID}"));
  int gdf_mt_id = atoi(ns_eval_string("{Graph_ID}"));
  //filling subject.
  int size = fill_subject_or_measure(ptr, subject_string, 0, SUBJECT, 1, tsdb_dc_ptr);
  total_sz += size;
  ptr += size;
  //filling measure.
  size = fill_subject_or_measure(ptr, measure_string, gdf_mg_id, MEASURE, 1, tsdb_dc_ptr);
  total_sz += size;
  ptr += size;
  
  req->sub_member_count = tsdb_dc_ptr->sub_mem_count;
  req->measure_member_count = 3; // tsdb_dc_ptr->measure_mem_count;
  
  //filling data of Metric.(As there can be multiple metric names and metric IDs.)
  size = fill_metrics_data(ptr, tsdb_dc_ptr);
  total_sz += size;
  //fprintf(stderr, "\n\n total_sz6- %d, metric size %d\n\n", total_sz, size);
  ptr += size;
  
  req->msg_hdr.msg_size = (total_sz - 4);
  //fprintf(stderr, "\n\n total size  -- %d\n\n", req->msg_hdr.msg_size);

  return total_sz; 
}
/*
void copy_dcn_req_data(int mt, void **var_data, int *total_size, TSDBMetaCall *tsdb_dc_ptr)
{
  char *sub, *measure;

  ns_advance_param("subject");
  sub = ns_eval_string("{subject}");

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "mt: %d, subject: %s", mt, sub);
  #endif

  int sub_len = fill_subject_or_measure(*var_data, sub, SUBJECT, tsdb_dc_ptr);
  *var_data += sub_len;
  *total_size += sub_len;

  measure = ns_eval_string("{measure}");

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "measure: %s\n", measure);
  #endif

  int ms_len = fill_subject_or_measure (*var_data, measure, MEASURE, tsdb_dc_ptr);
  *var_data += ms_len;
  *total_size += ms_len;
}

*/

int parse_resp_for_err(void *resp_buffer)
{
  TSDB_ErrorMessage_t *resp = (TSDB_ErrorMessage_t *)(resp_buffer);

  int error_code = resp->error_code;
  short http_code = resp->http_code;
  void *var_data = resp->var_data;

  for(int i = 0; i < resp->rt_hdr.tsdb_nodes; i++)
  {
    short *tsdb_id = (short *)var_data;
    var_data += 2;

    int *tsdb_rt = (int *)var_data;
    var_data += 4;

  }
 
  char err_msg[256];
  char detail_err_msg[128];

  uint16_t *err_msg_len = (uint16_t *)var_data;
  var_data += 2;

  memcpy(err_msg, var_data, *err_msg_len);
  err_msg[*err_msg_len] = '\0';
  var_data += *err_msg_len;

  uint16_t *detail_err_msg_len = (uint16_t *)var_data;
  var_data += 2;
  memcpy(detail_err_msg, var_data, *detail_err_msg_len);
  err_msg[*detail_err_msg_len] = '\0';
  var_data += *detail_err_msg_len;
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"Error Code: %d, Http Code: %d, ErrorMsg: %s, DetailErrMsg = %s\n",
    error_code, http_code, err_msg, detail_err_msg);
  #endif
  return(error_code);
}

void parse_open_metric_response(void *resp_buffer, TSDBMetaCall *tsdb_dc_ptr)
{
  
  TSDB_Resp_Metadata_t *resp = (TSDB_Resp_Metadata_t *)(resp_buffer);

  char rep_tx_name[1024];
  int tx_name_offset = 0;

  tx_name_offset = resp->msg_hdr.tx_name_offset;

  void *tx_ptr = (TSDB_Resp_Metadata_t *)resp_buffer;
  tx_ptr +=tx_name_offset; 

  uint8_t *tx_len = (uint8_t *)tx_ptr;
  tx_ptr++;

  memcpy(rep_tx_name, tx_ptr, *tx_len);
  rep_tx_name[*tx_len] = '\0';
  
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"TX_name(%d): %s, tx_name_offset = %d\n", *tx_len, rep_tx_name, tx_name_offset);
  fprintf(query_log_fp,"Msg hdr. size: %d, opcode: %d\n", resp->msg_hdr.msg_size, resp->msg_hdr.opcode);
  fprintf(query_log_fp,"RT Hdr. qhead_rt: %d, tsdb_nodes: %d\n", resp->rt_hdr.qhead_rt, resp->rt_hdr.tsdb_nodes);
  #endif

  void *var_data = resp->var_data;

  for(int i = 0; i < resp->rt_hdr.tsdb_nodes; i++)
  {
    short *tsdb_id = (short *)var_data;
    var_data += 2;

    int *tsdb_rt = (int *)var_data;
    var_data += 4;
    #ifdef TSDB_QUERY_LOGGING
//    fprintf(query_log_fp,"TSDB id: %d, TSDB rt: %d \n", *tsdb_id, *tsdb_rt);
    #endif
  }

  uint8_t *len;
  uint8_t *sub_count;
  char buff[1024];
  char measure[1024];
  char tag[256];
  char value[256];
  tsdb_dc_ptr->rep_num_metrics = resp->mt_count;
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"rep_num_metrics = %d\n", tsdb_dc_ptr->rep_num_metrics);
  #endif
  for(int i = 0; i < resp->mt_count; i++)
  {
    int n = 0;
    int z = 0;
//    memcpy(metric_id, var_data, 64);
    metric_id_t *id = (metric_id_t *) var_data;
    var_data += sizeof(metric_id_t);
   #ifdef TSDB_QUERY_LOGGING 
   fprintf(query_log_fp,"\nmetric_id: type = %d, local tree index = %d, tt_idx = %d, table_idx = %d, subject_idx = %d,"
     " g_mg_idx = %d mg_idx = %d, mt_idx = %d\n",
      id->type, id->local_tree_idx, id->tt_idx, id->table_idx, id->subject_idx, id->g_mg_idx, id->mg_idx, id->mt_idx);
   #endif
    sub_count = (uint8_t *)var_data;
    var_data += 1;

    for(int i = 0; i < *sub_count; i++)
    {
      len = (uint8_t *)var_data;
      var_data += 1;
      memcpy(tag, var_data, *len);
      tag[*len] = '\0';
      var_data += *len;

      len = (uint8_t *)var_data;
      var_data += 1;
      memcpy(value, var_data, *len);
      value[*len] = '\0';
      var_data += *len;

      n += sprintf(buff + n,"%s:%s>", tag, value);
    }
    #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"subject: %s\n", buff);
    #endif

    sub_count = (uint8_t *)var_data;
    var_data += 1;

    for(int i = 0; i < *sub_count; i++)
    {
      // Tag
      uint8_t *tag_len = (uint8_t *)var_data;
      var_data += 1;
      memcpy(tag, var_data, *tag_len);
      var_data += *tag_len;
      tag[*tag_len] = '\0';

      // Val
      uint8_t *value_len = (uint8_t *)var_data;
      var_data += 1;
      memcpy(value, var_data, *value_len);
      var_data += *value_len;
      value[*value_len] = '\0';

      // ID
      int *id;
      id = (int *)var_data;
      var_data += 4;
      #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp,"type = %s, value = %s, id = %d\n", tag, value, *id);
      #endif
      z += sprintf(measure + z,"%s:%s>", tag, value);
    }
    #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"measure: %s\n",measure);
    #endif

    //if(resp->msg_hdr.opcode == TSDB_QUERY_REQ_METADATA_PATTERN_MATCH)
    //{
      uint8_t *p_match;
      p_match = (uint8_t *)var_data;
      var_data += 1;
      #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp,"p_match: %d\n", *p_match);
      #endif
    //}
  }

  uint8_t *etag_len = (uint8_t *)var_data;
  var_data += 1;
  memcpy(value, var_data, *etag_len);
  value[*etag_len] = '\0';
  var_data += *etag_len;
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"etag: %s len: %d\n", value, *etag_len);
  #endif

}

void tsdb_parse_response(void  *resp_buffer, int msg_size, TSDBMetaCall *tsdb_dc_ptr)
{
TSDB_Resp_Metadata_t *resp = (TSDB_Resp_Metadata_t *)(resp_buffer);
 
 #ifdef TSDB_QUERY_LOGGING
fprintf(query_log_fp,"Msg hdr. size: %d, opcode: %d\n", resp->msg_hdr.msg_size, resp->msg_hdr.opcode);
fprintf(query_log_fp,"RT Hdr. qhead_rt: %d, tsdb_nodes: %d\n", resp->rt_hdr.qhead_rt, resp->rt_hdr.tsdb_nodes);
fprintf(query_log_fp,"num_groups: %d\n", resp->mt_count);
  #endif

  MsgHdr_t *hdr = (MsgHdr_t *)(resp_buffer);
  //RTHdr_t *rt_hdr = (RTHdr_t *)(resp_buffer + sizeof(MsgHdr_t));
switch(hdr->opcode)
  {
    case TSDB_QUERY_REQ_METADATA_OPEN_MERGE:
    case TSDB_QUERY_REQ_METADATA_OPEN_RELATED:
    case TSDB_QUERY_REQ_METADATA_PATTERN_MATCH: 
      parse_open_metric_response(resp_buffer, tsdb_dc_ptr);
      return hdr->opcode;
      break;
      case TSDB_QUERY_ERROR: 
      (tsdb_dc_ptr)->rep_error_code = parse_resp_for_err(resp_buffer);
      fprintf(query_log_fp, "Got TSDB ERRROR Opcode: %d\n", hdr->opcode);
      return hdr->opcode;
      break;
      default:
      (tsdb_dc_ptr)->rep_error_code = 999; //  TODO - get from eror message
      fprintf(query_log_fp, "Invalid msg type in RESPONSE: %d\n", hdr->opcode);
  }
}

