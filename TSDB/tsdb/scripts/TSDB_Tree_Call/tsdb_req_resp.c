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
#include "tsdb_tree_query.h"
#include "ns_string.h"

//#include "tsdb_msg_interface.h"
//#include "tsdb_id.h"
//#include "tsdb_data_query.h"
//#include "tsdb_data_call_util.c"
#define NUM_DF 6


int create_req_for_init_call(TSDBDataCall *tsdb_dc_ptr)
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
    
  char client_id[] = "Default";
  char app_id[] = "Default";

  uint8_t client_id_len = strlen(client_id) + 1;
  uint8_t app_id_len = strlen(app_id) + 1;
  int total_sz = sizeof(TSDB_Req_Tree_Init_t) + app_id_len + client_id_len;
  TSDB_Req_Tree_Init_t *req = (TSDB_Req_Tree_Init_t *) tsdb_dc_ptr->buffer;

  req->msg_hdr.msg_size = (total_sz - 4);
  req->msg_hdr.opcode = (TSDB_QUERY_REQ_TREE_INIT);
  req->msg_hdr.version = 0;

  req->tr_num = 1234;
  req->start_time = tsdb_dc_ptr->start_ts;
  req->end_time = tsdb_dc_ptr->end_ts;
  req->app_id_len = app_id_len;
  req->client_id_len = client_id_len;
  req->preset = tsdb_dc_ptr->time_period;
  void *ptr = (void *)req->var_data;

  memcpy(ptr, client_id, client_id_len);
  ptr += client_id_len;

  memcpy(ptr, app_id, app_id_len);
  ptr += app_id_len;
  #ifdef TSDB_QUERY_LOGGING 
  fprintf(query_log_fp,"create request for init . start_time = %ld, end_time = %ld, app_id_len = %d"
         "cilent_id_len = %d, preset = %d, ptr = %u\n",
         tsdb_dc_ptr->start_ts, tsdb_dc_ptr->end_ts, app_id_len, client_id_len, tsdb_dc_ptr->time_period, req->var_data);
  #endif
  return total_sz;   
}

int create_req_for_expand_call(TSDBDataCall *tsdb_dc_ptr, int counter)
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
  fprintf(query_log_fp, "\n\nCreating request for. time_period = %s, start_ts: %ld, end_ts: %ld, counter = %d\n",
                         time_period[tsdb_dc_ptr->time_period], tsdb_dc_ptr->start_ts, tsdb_dc_ptr->end_ts, counter);
  fprintf(query_log_fp, "start_time: %s, end_time: %s\n", start_tm_buff, end_tm_buff);
  #endif

  char client_id[] = "Default";
  char app_id[] = "Default";

  uint8_t client_id_len = strlen(client_id) + 1;
  uint8_t app_id_len = strlen(app_id) + 1;
  int total_sz = sizeof(TSDB_Req_Expand_Tree_t);
  TSDB_Req_Expand_Tree_t *req = (TSDB_Req_Expand_Tree_t *) tsdb_dc_ptr->buffer;
  req->msg_hdr.opcode = (TSDB_QUERY_REQ_TREE_EXPAND);
  req->msg_hdr.version = 0;

  req->tr_num = 1234;
  req->start_time = tsdb_dc_ptr->start_ts;
  req->end_time = tsdb_dc_ptr->end_ts;
  req->app_id_len = app_id_len;
  req->client_id_len = client_id_len;
  req->preset = tsdb_dc_ptr->time_period;
  req->expand_level = 2;
  void *ptr = (void *)req + sizeof(TSDB_Req_Expand_Tree_t);

  memcpy(ptr, client_id, client_id_len);
  ptr += client_id_len;

  memcpy(ptr, app_id, app_id_len);
  ptr += app_id_len;

  total_sz += app_id_len + client_id_len; 
  //subject_id_t *sub_id;
  
  if(tsdb_dc_ptr->resp_subject_id)
  {
     memcpy(ptr, tsdb_dc_ptr->resp_subject_id, sizeof(subject_id_t));
     //tsdb_dc_ptr->req_sub_id_type = sub_id->type;
     #ifdef TSDB_QUERY_LOGGING
     fprintf(query_log_fp,"sub_value->table_idx = %d, sub_value->local_tree_idx = %d, sub_value->subject_idx = %d,"
      "sub_value->g_mg_idx = %d, sub_value->type = %d, sub_value->tt_idx = %d\n",
       tsdb_dc_ptr->resp_subject_id->table_idx, tsdb_dc_ptr->resp_subject_id->local_tree_idx, tsdb_dc_ptr->resp_subject_id->subject_idx,
       tsdb_dc_ptr->resp_subject_id->g_mg_idx, tsdb_dc_ptr->resp_subject_id->type, tsdb_dc_ptr->resp_subject_id->tt_idx);
     #endif
     total_sz += sizeof(subject_id_t);
     return total_sz;
  }
  else if(tsdb_dc_ptr->resp_subject_type_id)
  {
     memcpy(ptr, tsdb_dc_ptr->resp_subject_type_id, sizeof(subject_id_t));
     //tsdb_dc_ptr->req_sub_id_type = sub_id->type;
     #ifdef TSDB_QUERY_LOGGING
     fprintf(query_log_fp,"sub_value->table_idx = %d, sub_value->local_tree_idx = %d, sub_value->subject_idx = %d,"
      "sub_value->g_mg_idx = %d, sub_value->type = %d, sub_value->tt_idx = %d\n",
       tsdb_dc_ptr->resp_subject_type_id->table_idx, tsdb_dc_ptr->resp_subject_type_id->local_tree_idx, 
       tsdb_dc_ptr->resp_subject_type_id->subject_idx, tsdb_dc_ptr->resp_subject_type_id->g_mg_idx, 
       tsdb_dc_ptr->resp_subject_type_id->type, tsdb_dc_ptr->resp_subject_type_id->tt_idx);
     #endif
     total_sz += sizeof(subject_id_t);
     return total_sz;
  }
  else if(tsdb_dc_ptr->resp_subject_value_id)  
  {
     memcpy(ptr, tsdb_dc_ptr->resp_subject_value_id, sizeof(subject_id_t));
     //tsdb_dc_ptr->req_sub_id_type = sub_id->type;
     #ifdef TSDB_QUERY_LOGGING
     fprintf(query_log_fp,"sub_value->table_idx = %d, sub_value->local_tree_idx = %d, sub_value->subject_idx = %d,"
      "sub_value->g_mg_idx = %d, sub_value->type = %d, sub_value->tt_idx = %d\n",
       tsdb_dc_ptr->resp_subject_value_id->table_idx, tsdb_dc_ptr->resp_subject_value_id->local_tree_idx,
       tsdb_dc_ptr->resp_subject_value_id->subject_idx, tsdb_dc_ptr->resp_subject_value_id->g_mg_idx,
       tsdb_dc_ptr->resp_subject_value_id->type, tsdb_dc_ptr->resp_subject_value_id->tt_idx);
     #endif
     total_sz += sizeof(subject_id_t);
     return total_sz;
  }
  else if(tsdb_dc_ptr->resp_msg_subject_id)  
  {
     memcpy(ptr, tsdb_dc_ptr->resp_msg_subject_id, sizeof(subject_id_t ));
     tsdb_dc_ptr->req_sub_id_type = tsdb_dc_ptr->resp_msg_subject_id->type;
     #ifdef TSDB_QUERY_LOGGING
     fprintf(query_log_fp,"mg_id_t->local_tree_idx = %d, mg_id_t->tt_idx = %d, mg_id_t->table_idx = %d, mg_id_t->subject_idx = %d,"
     "mg_id_t->g_mg_idx = %d, mg_id_t->type = %d\n",
     tsdb_dc_ptr->resp_msg_subject_id->local_tree_idx, tsdb_dc_ptr->resp_msg_subject_id->tt_idx,
     tsdb_dc_ptr->resp_msg_subject_id->table_idx, tsdb_dc_ptr->resp_msg_subject_id->subject_idx,
     tsdb_dc_ptr->resp_msg_subject_id->g_mg_idx, tsdb_dc_ptr->resp_msg_subject_id->type);
     #endif
     total_sz += sizeof(subject_id_t);
     return total_sz; 
  }
  else if(tsdb_dc_ptr->resp_mg_id->type) //when we got the value of 5 , it will send the response for metric_value ,whose value is 3
  {
    memcpy(ptr, tsdb_dc_ptr->resp_mg_id, sizeof(mg_id_t ));
    tsdb_dc_ptr->req_mg_id_type = tsdb_dc_ptr->resp_mg_id->type;
    #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"metric->type = %d, metric->local_tree_index = %d, metric->tt_idx = %d, metric->table_idx = %d,"
    "metric->subject_idx = %d,metric->g_mg_idx = %d\n",
    tsdb_dc_ptr->resp_mg_id->type, tsdb_dc_ptr->resp_mg_id->local_tree_idx, tsdb_dc_ptr->resp_mg_id->tt_idx,
    tsdb_dc_ptr->resp_mg_id->table_idx, tsdb_dc_ptr->resp_mg_id->subject_idx, tsdb_dc_ptr->resp_mg_id->g_mg_idx);
    #endif
    total_sz += sizeof(mg_id_t);
    return total_sz;
  }
 return 0;
}

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

#define INDENT_FPRINT(fp,level, ...) \
{ \
  fprintf(fp,"%*c", (level) * 4, ' '); \
  fprintf(fp, __VA_ARGS__); \
}

#define TSDB_ID_BIN_TO_HEX(bin_id_ptr, bin_id_sz, hex_id_buff) \
{ \
 int n = 0; \
 for(int ch = 0; ch < (bin_id_sz); ch++) \
  n += sprintf((hex_id_buff) + n, "%02X", *(((unsigned char *)(bin_id_ptr)) + ch)); \
}

int parse_id(void *var_data, TSDBDataCall **tsdb_dc_ptr, int counter, int level)
{
 uint8_t *id_type = (uint8_t *)var_data;
 char hex_id[64];
 switch(*id_type)
 { 
    case ID_TYPE_ATTRIBUTE:
    {
     (*tsdb_dc_ptr)->resp_attribute_subject_id = (subject_id_t *)var_data;
     TSDB_ID_BIN_TO_HEX(var_data, sizeof(subject_id_t), hex_id);
     fprintf(query_log_fp,"value of sub: %s\n",(*tsdb_dc_ptr)->resp_attribute_subject_id);
     #ifdef TSDB_QUERY_LOGGING
     INDENT_FPRINT(query_log_fp,level, "ag_id_t->type = %d,ag_id_t->hex_id = %s, ag_id_t->local_tree_idx = %d, ag_id_t->tt_idx = %d," 
       "ag_id_t->table_idx = %d, ag_id_t->subject_idx = %d, ag_id_t->g_mg_idx = %d\n",
       (*tsdb_dc_ptr)->resp_attribute_subject_id->type, hex_id, (*tsdb_dc_ptr)->resp_attribute_subject_id->local_tree_idx,
       (*tsdb_dc_ptr)->resp_attribute_subject_id->tt_idx, (*tsdb_dc_ptr)->resp_attribute_subject_id->table_idx,
       (*tsdb_dc_ptr)->resp_attribute_subject_id->subject_idx, (*tsdb_dc_ptr)->resp_attribute_subject_id->g_mg_idx);
     #endif
     return sizeof(subject_id_t);
    }
   case ID_TYPE_MSG:
    {
     (*tsdb_dc_ptr)->resp_msg_subject_id = (subject_id_t *)var_data; 
     TSDB_ID_BIN_TO_HEX(var_data, sizeof(subject_id_t), hex_id);
     #ifdef TSDB_QUERY_LOGGING
     INDENT_FPRINT(query_log_fp,level, "mg_id_t->type = %d,  mg_id_t->hex_id = %s, mg_id_t->local_tree_idx = %d,"
       "mg_id_t->tt_idx = %d, mg_id_t->table_idx = %d,mg_id_t->subject_idx = %d,mg_id_t->g_mg_idx = %d\n\n",
       (*tsdb_dc_ptr)->resp_msg_subject_id->type, hex_id, (*tsdb_dc_ptr)->resp_msg_subject_id->local_tree_idx,
       (*tsdb_dc_ptr)->resp_msg_subject_id->tt_idx,(*tsdb_dc_ptr)->resp_msg_subject_id->table_idx,
       (*tsdb_dc_ptr)->resp_msg_subject_id->subject_idx, (*tsdb_dc_ptr)->resp_msg_subject_id->g_mg_idx);
     #endif
     return sizeof(subject_id_t);
     break;
   }
  case ID_TYPE_SUBJECT:
  {
    (*tsdb_dc_ptr)->resp_subject_id = (subject_id_t *)(var_data);
    TSDB_ID_BIN_TO_HEX(var_data, sizeof(subject_id_t), hex_id);
    #ifdef TSDB_QUERY_LOGGING
    INDENT_FPRINT(query_log_fp,level, "sub->type = %d, sub->hex_id = %s,sub->table_idx = %d, sub->local_tree_idx = %d,"
        " sub->subject_idx = %d,sub->g_mg_idx = %d, sub->tt_idx = %d\n",
        (*tsdb_dc_ptr)->resp_subject_id->type,hex_id, (*tsdb_dc_ptr)->resp_subject_id->table_idx,
        (*tsdb_dc_ptr)->resp_subject_id->local_tree_idx,(*tsdb_dc_ptr)->resp_subject_id->subject_idx, 
        (*tsdb_dc_ptr)->resp_subject_id->g_mg_idx, (*tsdb_dc_ptr)->resp_subject_id->tt_idx);
     #endif
     return sizeof(subject_id_t);
     break;
   }
   case ID_TYPE_SUBJECT_TYPE:
   {
    (*tsdb_dc_ptr)->resp_subject_type_id = (subject_id_t *)var_data;
    TSDB_ID_BIN_TO_HEX(var_data, sizeof(subject_id_t), hex_id);
    #ifdef TSDB_QUERY_LOGGING
   INDENT_FPRINT(query_log_fp,level,"sub_type->type = %d,sub_type->hex_id = %s, sub_type->table_idx = %d, sub_type->local_tree_idx = %d,"
     "sub_type->subject_idx = %d,sub_type->g_mg_idx = %d, sub_type->tt_idx = %d\n",
     (*tsdb_dc_ptr)->resp_subject_type_id->type, hex_id, (*tsdb_dc_ptr)->resp_subject_type_id->table_idx,
     (*tsdb_dc_ptr)->resp_subject_type_id->local_tree_idx, (*tsdb_dc_ptr)->resp_subject_type_id->subject_idx,
     (*tsdb_dc_ptr)->resp_subject_type_id->g_mg_idx, (*tsdb_dc_ptr)->resp_subject_type_id->tt_idx);
    #endif
    return sizeof(subject_id_t);
   }
   case ID_TYPE_SUBJECT_VALUE:
   {
   (*tsdb_dc_ptr)->resp_subject_value_id = (subject_id_t *)var_data;
   TSDB_ID_BIN_TO_HEX(var_data, sizeof(subject_id_t), hex_id);
    #ifdef TSDB_QUERY_LOGGING
    INDENT_FPRINT(query_log_fp,level,"sub_value->type = %d, sub_value->hex_id = %s,sub_value->table_idx = %d, sub_value->local_tree_idx = %d,"
      "sub_value->subject_idx = %d,sub_value->g_mg_idx = %d, sub_value->tt_idx = %d\n",
      (*tsdb_dc_ptr)->resp_subject_value_id->type, hex_id, (*tsdb_dc_ptr)->resp_subject_value_id->table_idx, 
      (*tsdb_dc_ptr)->resp_subject_value_id->local_tree_idx, (*tsdb_dc_ptr)->resp_subject_value_id->subject_idx, 
      (*tsdb_dc_ptr)->resp_subject_value_id->g_mg_idx, (*tsdb_dc_ptr)->resp_subject_value_id->tt_idx);
    #endif
    return sizeof(subject_id_t);
    break;
   }
   case ID_TYPE_LOCAL_MG:
   {
    (*tsdb_dc_ptr)->resp_mg_id  = (mg_id_t *)var_data;
    TSDB_ID_BIN_TO_HEX(var_data, sizeof(mg_id_t), hex_id);
    #ifdef TSDB_QUERY_LOGGING
   INDENT_FPRINT(query_log_fp,level, "metric->type = %d, metric->hex_id = %s,metric->local_tree_index = %d, metric->tt_idx = %d,"
    "metric->table_idx = %d,metric->subject_idx = %d,metric->g_mg_idx = %d\n",
    (*tsdb_dc_ptr)->resp_mg_id->type, hex_id, (*tsdb_dc_ptr)->resp_mg_id->local_tree_idx, (*tsdb_dc_ptr)->resp_mg_id->tt_idx,   
    (*tsdb_dc_ptr)->resp_mg_id->table_idx, (*tsdb_dc_ptr)->resp_mg_id->subject_idx, (*tsdb_dc_ptr)->resp_mg_id->g_mg_idx);
    #endif
    return sizeof(mg_id_t);
    break;
   }
   case ID_TYPE_METRIC:
   {
    //Send error as we reached the leaf node
    (*tsdb_dc_ptr)->resp_metric_id = (metric_id_t *)var_data;
    TSDB_ID_BIN_TO_HEX(var_data, sizeof(metric_id_t), hex_id);
    ns_save_data_var("/home/cavisson/TSDB_NS/scripts/default/default/TSDB_Tree_Call_IP/hex_id.txt", NS_TRUNC_FILE, hex_id);
    #ifdef TSDB_QUERY_LOGGING
    INDENT_FPRINT(query_log_fp,level, "metric_value->type = %d, metric_value->hex_id = %s, metric_value->local_tree_index = %d,"
    "metric_value->tt_idx = %d, metric_value->table_idx = %d, metric_value->subject_idx = %d, metric_value->g_mg_idx = %d\n",
    (*tsdb_dc_ptr)->resp_metric_id->type, hex_id, (*tsdb_dc_ptr)->resp_metric_id->local_tree_idx, (*tsdb_dc_ptr)->resp_metric_id->tt_idx,
    (*tsdb_dc_ptr)->resp_metric_id->table_idx, (*tsdb_dc_ptr)->resp_metric_id->subject_idx, (*tsdb_dc_ptr)->resp_metric_id->g_mg_idx);
    #endif
    return sizeof(metric_id_t);
    break;
   }
  default:
  {
   #ifdef TSDB_QUERY_LOGGING
   INDENT_FPRINT(query_log_fp,level,"ID type not valid");
   #endif
   return 0;
  }
 }
}

void tsdb_script_reset_id_ptr(TSDBDataCall **tsdb_dc_ptr, int id_type)
{
  switch(id_type)
  {
    case ID_TYPE_ATTRIBUTE:
      (*tsdb_dc_ptr)->resp_msg_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_type_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_value_id = NULL;
      (*tsdb_dc_ptr)->resp_mg_id = NULL;
      (*tsdb_dc_ptr)->resp_metric_id = NULL;
    break;
    case ID_TYPE_SUBJECT:
      (*tsdb_dc_ptr)->resp_attribute_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_msg_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_type_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_value_id = NULL;
      (*tsdb_dc_ptr)->resp_mg_id = NULL;
      (*tsdb_dc_ptr)->resp_metric_id = NULL;
    break;
    case ID_TYPE_SUBJECT_TYPE:
      (*tsdb_dc_ptr)->resp_attribute_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_msg_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_value_id = NULL;
      (*tsdb_dc_ptr)->resp_mg_id = NULL;
      (*tsdb_dc_ptr)->resp_metric_id = NULL;
    break;
    case ID_TYPE_SUBJECT_VALUE:
      (*tsdb_dc_ptr)->resp_attribute_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_msg_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_type_id = NULL;
      (*tsdb_dc_ptr)->resp_mg_id = NULL;
      (*tsdb_dc_ptr)->resp_metric_id = NULL;
    break;
    case ID_TYPE_MSG:
      (*tsdb_dc_ptr)->resp_attribute_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_value_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_type_id = NULL;
      (*tsdb_dc_ptr)->resp_mg_id = NULL;
      (*tsdb_dc_ptr)->resp_metric_id = NULL;
    break;
    case ID_TYPE_LOCAL_MG:
      (*tsdb_dc_ptr)->resp_attribute_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_value_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_type_id = NULL;
      (*tsdb_dc_ptr)->resp_metric_id = NULL;
      (*tsdb_dc_ptr)->resp_msg_subject_id = NULL;    
    break;
    case ID_TYPE_METRIC:
      (*tsdb_dc_ptr)->resp_attribute_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_value_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_id = NULL;
      (*tsdb_dc_ptr)->resp_subject_type_id = NULL;
      (*tsdb_dc_ptr)->resp_mg_id = NULL;
      (*tsdb_dc_ptr)->resp_msg_subject_id = NULL;
    break;
  }
}

int parse_parent_or_child(void *var_data, TSDBDataCall **tsdb_dc_ptr, int counter,int level, int *id_value)
{
 uint64_t *gdf_id;
 uint8_t *id_type;
 uint8_t *len;
 char type[128];
 uint8_t flag;
 int offset = 0; //to assign the postion 
 
 id_type = (uint8_t *)var_data;
 *id_value = *id_type;
 offset += parse_id(var_data, tsdb_dc_ptr, counter, 0);
 var_data += offset;
 
 gdf_id = (uint64_t *)var_data;  
 var_data += 8;
 offset += 8;

 len = (uint8_t *)var_data;
 var_data += 1;
 offset += 1;
 memcpy(type, var_data, *len);
 type[*len] = '\0';
 var_data += *len;
 offset += *len;

 flag = *(uint8_t *)var_data;
 var_data += 1;
 offset += 1;

 uint16_t num_children = *(uint16_t *)var_data;
 var_data += 2;
 offset += 2;
 //(*tsdb_dc_ptr)->num_children = num_children;
 //(*tsdb_dc_ptr)->type_value = type;
 #ifdef TSDB_QUERY_LOGGING
 INDENT_FPRINT(query_log_fp,level,"type: %s\n", type);
 INDENT_FPRINT(query_log_fp,level,"gdf_id: %ld\n", *gdf_id);
 INDENT_FPRINT(query_log_fp,level,"id_type: %ld\n", *id_type);
 INDENT_FPRINT(query_log_fp,level,"num_children %d flag %d\n\n", num_children, flag);
 #endif
 for(int j = 0; j < num_children; j++)
 {
   (*tsdb_dc_ptr)->num_children = num_children;
   int n = parse_parent_or_child(var_data, tsdb_dc_ptr, counter, level+1, id_value);
   var_data += n;
   offset += n;
 }

 if(num_children == 0)
 {
   (*tsdb_dc_ptr)->resp_sub_id_type = *id_value;
   tsdb_script_reset_id_ptr(tsdb_dc_ptr, *id_value);
 }
return offset;
}

void parse_init_expand_response(void *resp_buffer, TSDBDataCall **tsdb_dc_ptr, int counter, int *id_value)
{
  TSDB_Resp_Tree_t *resp = (TSDB_Resp_Tree_t *)(resp_buffer);
  (*tsdb_dc_ptr)->rep_num_members = resp->num_members;
  (*tsdb_dc_ptr)->rt_hdr_node =  resp->rt_hdr.tsdb_nodes;
  (*tsdb_dc_ptr)->rep_tsdb_rt = resp->rt_hdr.qhead_rt;
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"Msg hdr. size: %d, opcode: %d, flag(hex) %x\n", resp->msg_hdr.msg_size, resp->msg_hdr.opcode, resp->msg_hdr.flags);
  fprintf(query_log_fp,"RT Hdr. qhead_rt: %d, tsdb_nodes: %d\n", resp->rt_hdr.qhead_rt, resp->rt_hdr.tsdb_nodes);
  fprintf(query_log_fp,"num_members: %d , rep_num_members = %d\n", resp->num_members, (*tsdb_dc_ptr)->rep_num_members);
  #endif
  void *var_data = resp->var_data;

  for(int i = 0; i < resp->rt_hdr.tsdb_nodes; i++)
  {
   short *tsdb_id = (short *)var_data;
   var_data += 2;

   int *tsdb_rt = (int *)var_data;
   var_data += 4;
   #ifdef TSDB_QUERY_LOGGING
   fprintf(query_log_fp,"TSDB id: %d, TSDB rt: %d \n", (*tsdb_id), (*tsdb_rt));
   #endif
  }
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"\n");
  #endif

  for(int i = 0; i < resp->num_members; i++)
  {
   int offset = parse_parent_or_child(var_data, tsdb_dc_ptr, counter, 0, id_value);
   var_data += offset;
  }
  fflush(query_log_fp);
}

int tsdb_parse_response(void  *resp_buffer, int msg_size, TSDBDataCall **tsdb_dc_ptr, int counter, int *id_type)
{
  MsgHdr_t *hdr = (MsgHdr_t *)(resp_buffer);
  int tx_name_offset = 0;
 
//  printf("opcode = %d\n", hdr->opcode);
 
  tx_name_offset = hdr->tx_name_offset;
  void *tx_ptr = resp_buffer;
  tx_ptr += tx_name_offset;

  (*tsdb_dc_ptr)->tx_len = *(uint8_t * )tx_ptr;
  tx_ptr++;

  //char tx_name[1024 + 1];
  memcpy((*tsdb_dc_ptr)->tx_name, tx_ptr, (*tsdb_dc_ptr)->tx_len);
  (*tsdb_dc_ptr)->tx_name[(*tsdb_dc_ptr)->tx_len]  = '\0';
  
  //fprintf(stderr, "TXName = %s, TXLen = %d\n\n", (*tsdb_dc_ptr)->tx_name, (*tsdb_dc_ptr)->tx_len);

  //RTHdr_t *rt_hdr = (RTHdr_t *)(resp_buffer + sizeof(MsgHdr_t));
  switch(hdr->opcode)
  {
    case TSDB_QUERY_REQ_TREE_INIT:
    case TSDB_QUERY_REQ_TREE_EXPAND:
      parse_init_expand_response(resp_buffer, tsdb_dc_ptr, counter, id_type);
      return hdr->opcode;
      break;
    case TSDB_QUERY_ERROR: //todo check this
      (*tsdb_dc_ptr)->rep_error_code = parse_resp_for_err(resp_buffer);
      fprintf(query_log_fp, "Got TSDB ERROR Opcode: %d\n", hdr->opcode);
      return hdr->opcode;
      break;
    default:
      (*tsdb_dc_ptr)->rep_error_code = 9999; //  TODO - get from eror message
      fprintf(query_log_fp, "Invalid msg type in RESPONSE: %d\n", hdr->opcode);
  }
  return 0;
}

