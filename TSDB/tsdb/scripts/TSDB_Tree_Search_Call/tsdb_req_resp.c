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
#define NUM_DF 6


int create_req_for_tree_search_call(TSDBDataCall *tsdb_dc_ptr)
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
  ns_advance_param("Search_PatternFP");
  char *ts_kw = ns_eval_string("{Search_PatternFP}");
  fprintf(query_log_fp,"####################ts_kw %s\n", ts_kw);  
  //tsdb_dc_ptr->kw = *ts_kw;
  //fprintf(query_log_fp,"#####ts_kw: %s value: %s\n" , ts_kw, tsdb_dc_ptr->kw);
  int ts_kw_len = strlen(ts_kw) + 1; 
  int total_sz = sizeof(TSDB_Req_Search_Tree_t) + client_id_len + app_id_len + ts_kw_len; 
 
  TSDB_Req_Search_Tree_t *req = (TSDB_Req_Search_Tree_t *)tsdb_dc_ptr->buffer; 
 
  req->msg_hdr.msg_size = total_sz - 4; 
  req->msg_hdr.opcode = TSDB_QUERY_REQ_TREE_SEARCH; 
  req->msg_hdr.version = 0; 
 
  req->tr_num = 1234; 
  req->start_time = tsdb_dc_ptr->start_ts;
  req->end_time = tsdb_dc_ptr->end_ts;
  req->preset = tsdb_dc_ptr->time_period;
  req->app_id_len = app_id_len;
  req->client_id_len = client_id_len;
  req->search_level = tsdb_dc_ptr->req_search_level;
  req->search_mode = tsdb_dc_ptr->req_search_mode;
  req->node_limit = 64000;

  void *var_data = (void *)req->var_data;
  memcpy(var_data, client_id, client_id_len);
  var_data += client_id_len;
  memcpy(var_data, app_id, app_id_len);
  var_data += app_id_len;
  memcpy(var_data, ts_kw, ts_kw_len);
  return total_sz;
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


int parse_id(void *var_data, TSDBDataCall **tsdb_dc_ptr, int counter)
{
 uint8_t *id_type = (uint8_t *)var_data;
 #ifdef TSDB_QUERY_LOGGING
 fprintf(query_log_fp,"ID_TYPE = %d\n", *id_type );
 #endif

 switch(*id_type)
 { 
   case ID_TYPE_ATTRIBUTE:
   {
    (*tsdb_dc_ptr)->resp_attribute_subject_id = (subject_id_t *)var_data;
    #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "ag_id_t->local_tree_idx = %d, ag_id_t->tt_idx = %d, ag_id_t->table_idx = %d, ag_id_t->subject_idx = %d,"
    "ag_id_t->type = %d, ag_id_t->g_mg_idx = %d\n",
    (*tsdb_dc_ptr)->resp_attribute_subject_id->local_tree_idx, (*tsdb_dc_ptr)->resp_attribute_subject_id->tt_idx,
    (*tsdb_dc_ptr)->resp_attribute_subject_id->table_idx, (*tsdb_dc_ptr)->resp_attribute_subject_id->subject_idx, 
    (*tsdb_dc_ptr)->resp_attribute_subject_id->type, (*tsdb_dc_ptr)->resp_attribute_subject_id->g_mg_idx);
    #endif
    return sizeof(subject_id_t);
  }
   case ID_TYPE_MSG:
   {
     (*tsdb_dc_ptr)->resp_msg_subject_id = (subject_id_t *)var_data; 
     #ifdef TSDB_QUERY_LOGGING
     fprintf(query_log_fp,"mg_id_t->local_tree_idx = %d, mg_id_t->tt_idx = %d, mg_id_t->table_idx = %d, mg_id_t->subject_idx = %d,"
     "mg_id_t->g_mg_idx = %d, mg_id_t->type = %d\n\n",
     (*tsdb_dc_ptr)->resp_msg_subject_id->local_tree_idx,(*tsdb_dc_ptr)->resp_msg_subject_id->tt_idx,
     (*tsdb_dc_ptr)->resp_msg_subject_id->table_idx,(*tsdb_dc_ptr)->resp_msg_subject_id->subject_idx,
     (*tsdb_dc_ptr)->resp_msg_subject_id->g_mg_idx,(*tsdb_dc_ptr)->resp_msg_subject_id->type);
     #endif
     return sizeof(subject_id_t);
     break;
   }
   case ID_TYPE_SUBJECT:
   {
     (*tsdb_dc_ptr)->resp_subject_id = (subject_id_t *)(var_data);
     #ifdef TSDB_QUERY_LOGGING
     fprintf(query_log_fp,"sub->table_idx = %d, sub->local_tree_idx = %d, sub->subject_idx = %d,"
     "sub->g_mg_idx = %d, sub->type = %d, sub->tt_idx = %d\n",
     (*tsdb_dc_ptr)->resp_subject_id->table_idx, (*tsdb_dc_ptr)->resp_subject_id->local_tree_idx,(*tsdb_dc_ptr)->resp_subject_id->subject_idx,
     (*tsdb_dc_ptr)->resp_subject_id->g_mg_idx, (*tsdb_dc_ptr)->resp_subject_id->type, (*tsdb_dc_ptr)->resp_subject_id->tt_idx);
     #endif
     return sizeof(subject_id_t);
     break;
   }
   case ID_TYPE_SUBJECT_TYPE:
   {
    (*tsdb_dc_ptr)->resp_subject_id = (subject_id_t *)var_data;
    #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"sub_type->table_idx = %d, sub_type->local_tree_idx = %d, sub_type->subject_idx = %d,"
   "sub_type->g_mg_idx = %d, sub_type->type = %d, sub_type->tt_idx = %d\n",
    (*tsdb_dc_ptr)->resp_subject_id->table_idx, (*tsdb_dc_ptr)->resp_subject_id->local_tree_idx,
    (*tsdb_dc_ptr)->resp_subject_id->subject_idx, (*tsdb_dc_ptr)->resp_subject_id->g_mg_idx, (*tsdb_dc_ptr)->resp_subject_id->type,
    (*tsdb_dc_ptr)->resp_subject_id->tt_idx);
    #endif
    return sizeof(subject_id_t);
   }
   case ID_TYPE_SUBJECT_VALUE:
   {
   (*tsdb_dc_ptr)->resp_subject_value_id = (subject_id_t *)var_data;
    #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"sub_value->table_idx = %d, sub_value->local_tree_idx = %d, sub_value->subject_idx = %d,"
   "sub_value->g_mg_idx = %d, sub_value->type = %d, sub_value->tt_idx = %d\n",
    (*tsdb_dc_ptr)->resp_subject_value_id->table_idx, (*tsdb_dc_ptr)->resp_subject_value_id->local_tree_idx, 
    (*tsdb_dc_ptr)->resp_subject_value_id->subject_idx, (*tsdb_dc_ptr)->resp_subject_value_id->g_mg_idx,
    (*tsdb_dc_ptr)->resp_subject_value_id->type, (*tsdb_dc_ptr)->resp_subject_value_id->tt_idx);
    #endif
    return sizeof(subject_id_t);
    break;
   }
   case ID_TYPE_LOCAL_MG:
   {
    (*tsdb_dc_ptr)->resp_mg_id  = (mg_id_t *)var_data;
    #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"metric->type = %d, metric->local_tree_index = %d, metric->tt_idx = %d, metric->table_idx = %d," 
    "metric->subject_idx = %d,metric->g_mg_idx = %d\n",
    (*tsdb_dc_ptr)->resp_mg_id->type,(*tsdb_dc_ptr)->resp_mg_id->local_tree_idx, (*tsdb_dc_ptr)->resp_mg_id->tt_idx,   
    (*tsdb_dc_ptr)->resp_mg_id->table_idx, (*tsdb_dc_ptr)->resp_mg_id->subject_idx, (*tsdb_dc_ptr)->resp_mg_id->g_mg_idx);
    #endif
    return sizeof(mg_id_t);
    break;
   }
   case ID_TYPE_METRIC:
   {
    //Send error as we reached the leaf node
    (*tsdb_dc_ptr)->resp_metric_id = (metric_id_t *)var_data;
    #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"metric_value->type = %d, metric_value->local_tree_index = %d, metric_value->tt_idx = %d,"
    "metric_value->table_idx = %d, metric_value->subject_idx = %d, metric_value->g_mg_idx = %d\n",
    (*tsdb_dc_ptr)->resp_metric_id->type, (*tsdb_dc_ptr)->resp_metric_id->local_tree_idx, (*tsdb_dc_ptr)->resp_metric_id->tt_idx,
    (*tsdb_dc_ptr)->resp_metric_id->table_idx, (*tsdb_dc_ptr)->resp_metric_id->subject_idx, (*tsdb_dc_ptr)->resp_metric_id->g_mg_idx);
    #endif
    return sizeof(metric_id_t);
    break;
   }
  default:
  {
   #ifdef TSDB_QUERY_LOGGING
   fprintf(query_log_fp,"ID type not valid");
   #endif
   return 0;
  }
 }
}


int parse_parent_or_child(void *var_data, TSDBDataCall **tsdb_dc_ptr, int counter)
{
 uint64_t *gdf_id;
 uint8_t *id_type;
 uint8_t *len;
 char type[128];
 uint8_t flag;
 int offset = 0; //to assign the postion 
 
 id_type = (uint8_t *)var_data;
 offset += parse_id(var_data, tsdb_dc_ptr, counter);
 var_data += offset;
 
 gdf_id = (uint64_t *)var_data; //need to know about gdf_id 
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
 (*tsdb_dc_ptr)->num_children = num_children;
 #ifdef TSDB_QUERY_LOGGING
 fprintf(query_log_fp,"type: %s\n", type);
 fprintf(query_log_fp,"gdf_id: %ld\n", *gdf_id);
 fprintf(query_log_fp,"id_type: %ld\n", *id_type);
 fprintf(query_log_fp,"num_children %d flag %d\n\n", num_children, flag);
 #endif
 if (flag == 1)
 {
   (*tsdb_dc_ptr)->rep_match_count++;
 }
 for(int j = 0; j < num_children; j++)
 {
  int n = parse_parent_or_child(var_data, tsdb_dc_ptr, counter);
  var_data += n;
  offset += n;
 }
return offset;
}

void parse_tree_search_response(void *resp_buffer, TSDBDataCall **tsdb_dc_ptr, int counter)
{
  TSDB_Resp_Tree_t *resp = (TSDB_Resp_Tree_t *)(resp_buffer);
  (*tsdb_dc_ptr)->rep_num_members = resp->num_members;
  (*tsdb_dc_ptr)->rt_hdr_node = resp->rt_hdr.tsdb_nodes;
 (*tsdb_dc_ptr)->rep_tsdb_rt = resp->rt_hdr.qhead_rt;
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"Msg hdr. size: %d, opcode: %d\n", resp->msg_hdr.msg_size, resp->msg_hdr.opcode);
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
   int offset = parse_parent_or_child(var_data, tsdb_dc_ptr, counter);
   var_data += offset;
  }
  fflush(query_log_fp);
}

int tsdb_parse_response(void  *resp_buffer, int msg_size, TSDBDataCall **tsdb_dc_ptr, int counter)
{
  MsgHdr_t *hdr = (MsgHdr_t *)(resp_buffer);
  int tx_name_offset = 0;

//  printf("opcode = %d\n", hdr->opcode);

  tx_name_offset = hdr->tx_name_offset;
  void *tx_ptr = resp_buffer;
  tx_ptr += tx_name_offset;

  (*tsdb_dc_ptr)->tx_len = *(uint8_t *)tx_ptr;
  tx_ptr++;

  //char tx_name[1024 + 1];
  memcpy((*tsdb_dc_ptr)->tx_name, tx_ptr, (*tsdb_dc_ptr)->tx_len);
  (*tsdb_dc_ptr)->tx_name[(*tsdb_dc_ptr)->tx_len] = '\0';
  #ifdef TSDB_QUERY_LOGGING
  fprintf(stderr, "TXName = %s, TXLen = %d\n\n", (*tsdb_dc_ptr)->tx_name, (*tsdb_dc_ptr)->tx_len);
  #endif
  switch(hdr->opcode)
  {
    case TSDB_QUERY_REQ_TREE_SEARCH:
      parse_tree_search_response(resp_buffer, tsdb_dc_ptr, counter);
      return hdr->opcode;
      break;
    case TSDB_QUERY_ERROR: //todo check this
      (*tsdb_dc_ptr)->rep_error_code = parse_resp_for_err(resp_buffer);
      fprintf(query_log_fp, "Got TSDB ERROR Opcode: %d\n", hdr->opcode);
      return hdr->opcode;
      break;
    default:
      (*tsdb_dc_ptr)->rep_error_code = 9999; //  TODO - get from error message
      fprintf(query_log_fp, "Invalid msg type in RESPONSE: %d\n", hdr->opcode);
  }
  return 0;
}

