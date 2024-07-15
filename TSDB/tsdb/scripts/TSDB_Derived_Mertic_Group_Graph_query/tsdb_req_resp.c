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
#include "tsdb_metric_query.h"
//#include "tsdb_msg_interface.h"
//#include "tsdb_id.h"
//#include "tsdb_data_query.h"
//#include "tsdb_data_call_util.c"
#define NUM_DF 6

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


int create_req_for_metric_group_call(TSDBDataCall *tsdb_dc_ptr)
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
  fprintf(query_log_fp, "\n\nCreating request for. freq: %d, time_period = %s, start_ts: %d, end_ts: %d\n", tsdb_dc_ptr->req_freq,
                         time_period[tsdb_dc_ptr->time_period], tsdb_dc_ptr->start_ts, tsdb_dc_ptr->end_ts);
  fprintf(query_log_fp, "start_time: %s, end_time: %s\n", start_tm_buff, end_tm_buff);
  fprintf(query_log_fp, "Number of metrics: %d\n\n", tsdb_dc_ptr->req_num_metrics);
  #endif
  
 /* uint8_t total_type_len = strlen(tsdb_dc_ptr->type) + 1; 
  char *field[10];
  int  num_members = get_tokens_with_multi_delimiter(tsdb_dc_ptr->type, field, ">", 10);
  
   */
  char app_id[] = "Default";
  char client_id[] = "Default";
  uint8_t app_id_len = strlen(app_id) + 1;
  uint8_t client_id_len = strlen(client_id) + 1;
  int  num_members = 0;  
  
  int total_size = sizeof(TSDB_Req_Group_t) + app_id_len + client_id_len + 1 ;

  TSDB_Req_Group_t *req = (TSDB_Req_Group_t *)tsdb_dc_ptr->buffer;

  req->msg_hdr.version = 1;
  req->msg_hdr.opcode = TSDB_QUERY_REQ_DERIVED_GROUP;
  req->msg_hdr.msg_size = total_size - 4;

  req->tr_num = 1234;
  req->app_id_len = app_id_len;
  req->client_id_len = client_id_len;
  req->num_members = num_members;
  req->start_time = tsdb_dc_ptr->start_ts;
  req->end_time = tsdb_dc_ptr->end_ts;
  req->preset = tsdb_dc_ptr->time_period;
  void *var_data = req->var_data;
 
  memcpy(var_data, client_id, client_id_len);
  var_data += client_id_len;
  memcpy(var_data, app_id, app_id_len);
  var_data += app_id_len;
  /*
  for(int j = 0; j < num_members; j++)
  {
    uint8_t type_len = strlen(field[j]) + 1;
    memcpy(var_data, &type_len, 1);
    var_data += 1;
    memcpy(var_data, field[j], type_len);
    var_data += type_len;
  } */

  return total_size; 
}

int create_req_for_graph_call(TSDBDataCall *tsdb_dc_ptr)
{
  char app_id[] = "Default";
  char client_id[] = "Default";
  uint8_t app_id_len = strlen(app_id) + 1;
  uint8_t client_id_len = strlen(client_id) + 1;

  int total_size = sizeof(TSDB_Req_Graph_t) + app_id_len + client_id_len;

  TSDB_Req_Graph_t *req = (TSDB_Req_Graph_t *)tsdb_dc_ptr->buffer;

  req->msg_hdr.version = 1;
  req->msg_hdr.opcode = TSDB_QUERY_REQ_DERIVED_GRAPH;
  req->msg_hdr.msg_size = total_size - 4;
  req->app_id_len = app_id_len;
  req->client_id_len = client_id_len;
    req->start_time = tsdb_dc_ptr->start_ts;
  req->end_time = tsdb_dc_ptr->end_ts;
  req->preset = tsdb_dc_ptr->time_period; 
  req->tr_num = 1234;
  int rn_mg_id = ns_get_random_number_int(0,tsdb_dc_ptr->mg_id->g_mg_idx);
 
  g_metric_grp_id_t g_mg_id;
  g_mg_id.type = tsdb_dc_ptr->mg_id->type;
  g_mg_id.pad1 = 0;
  g_mg_id.g_mg_idx = rn_mg_id;
  
  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"\n tsdb_dc_ptr->mg_id->type %d and rn_mg_id %d\n", tsdb_dc_ptr->mg_id->type, rn_mg_id);
  #endif
  memcpy(&req->id_mg, &g_mg_id, 4);

  void *var_data = req->var_data;  

  memcpy(var_data, client_id, client_id_len);
  var_data += client_id_len;

  memcpy(var_data, app_id, app_id_len);
  var_data += app_id_len;

  return total_size;
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
  fprintf(query_log_fp,"Error Code: %u, Http Code: %d, ErrorMsg: %s, DetailErrMsg = %s\n",
    resp->error_code, resp->http_code, tsdb_dc_ptr->err_msg, tsdb_dc_ptr->detail_err_msg);
  #endif
  return(resp->error_code);
}

void parse_group_resp(void *resp_buffer, TSDBDataCall *tsdb_dc_ptr)
{
  char tx_name[1024];
  int tx_name_offset = 0;

  TSDB_Resp_Group_t *resp = (TSDB_Resp_Group_t *)(resp_buffer);
  tsdb_dc_ptr->rep_tsdb_rt = resp->rt_hdr.qhead_rt;
  
  tx_name_offset = resp->msg_hdr.tx_name_offset;
  void *tx_ptr = (TSDB_Resp_Group_t *)(resp_buffer);
  tx_ptr += tx_name_offset;
  uint8_t *tx_len = (uint8_t *)tx_ptr;
  tx_ptr++;

  memcpy(tx_name, tx_ptr, *tx_len);
  tx_name[*tx_len] = '\0';


  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp," TX_name(%d): %s, tx_name_offset = %d\n", *tx_len, tx_name, tx_name_offset);
  fprintf(query_log_fp,"Msg hdr. size: %d, opcode: %d\n", resp->msg_hdr.msg_size, resp->msg_hdr.opcode);
  fprintf(query_log_fp,"RT Hdr. qhead_rt: %d, tsdb_nodes: %d\n", tsdb_dc_ptr->rep_tsdb_rt, resp->rt_hdr.tsdb_nodes);
  #endif
  
  tsdb_dc_ptr->rep_num_mg = resp->count;
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"\ngroup count: %d\n", tsdb_dc_ptr->rep_num_mg);
  #endif
  void *var_data = resp->var_data;

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
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"\n");
  #endif

  uint8_t *len;
  int *group_id;
  char group_name[256];
  char group_type[128];
  uint8_t *is_type_group_vector;

  for(int j = 0; j < resp->count; ++j)
  {
    group_id = (int *)var_data;
    var_data += 4;

    tsdb_dc_ptr->mg_id = (g_metric_grp_id_t *)var_data;
    var_data += sizeof(g_metric_grp_id_t);

    is_type_group_vector = (uint8_t *)var_data;
    var_data += sizeof(uint8_t);

    len = (uint8_t *)var_data;
    var_data += 1;
    memcpy(group_name, var_data, *len);
    group_name[*len] = '\0';
    var_data += *len;

    uint16_t *length  = (uint16_t *)var_data;
    var_data += 2;

    memcpy(group_type, var_data, *length);
    group_type[*length] = '\0';
    var_data += *length;
    #ifdef TSDB_QUERY_LOGGING 
    fprintf(query_log_fp,"mg_id: %d, id_type: %d, group_id: %d, Derived group name: %s, Derived group Desc: %s, is_group_vector: %d\n",
      tsdb_dc_ptr->mg_id->g_mg_idx, tsdb_dc_ptr->mg_id->type, *group_id, group_name, group_type, *is_type_group_vector);
    #endif
    uint8_t *no_of_components = (uint8_t *)var_data;
    tsdb_dc_ptr->rep_hierachy_levels = *no_of_components;
    var_data += 1;
    #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"no_of_components = %d\n",tsdb_dc_ptr->rep_hierachy_levels);
    #endif
    for(int i = 0; i < *no_of_components; i++)
    {
      len = (uint8_t *)var_data;
      var_data += 1;

      memcpy(group_type, var_data, *len);
      group_type[*len] = '\0';
      var_data += *len;
      #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp," hierachy value[%d] =  %s \t\t\t", i+1, group_type);
      #endif
    }
   #ifdef TSDB_QUERY_LOGGING
   fprintf(query_log_fp,"\n");
   #endif
  }

  #ifdef TSDB_QUERY_LOGGING
  fflush(query_log_fp);
  #endif
}
void parse_graph_resp(void *resp_buffer, TSDBDataCall *tsdb_dc_ptr)
{ 
   char tx_name[1024];
  int tx_name_offset = 0;

  TSDB_Resp_Graph_t *resp = (TSDB_Resp_Graph_t *)(resp_buffer);
  tsdb_dc_ptr->rep_tsdb_rt = resp->rt_hdr.qhead_rt;
  tx_name_offset = resp->msg_hdr.tx_name_offset;
  void *tx_ptr = (TSDB_Resp_Graph_t *)(resp_buffer);
  tx_ptr += tx_name_offset;

  uint8_t *tx_len = (uint8_t *)tx_ptr;
  tx_ptr++;

  memcpy(tx_name, tx_ptr, *tx_len);
  tx_name[*tx_len] = '\0';

  #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp,"TX_name(%d): %s, tx_name_offset = %d\n", *tx_len, tx_name, tx_name_offset);
      fprintf(query_log_fp,"\nMessage hdr. size: %d, opcode: %d\n", resp->msg_hdr.msg_size, resp->msg_hdr.opcode);
      fprintf(query_log_fp,"Query Head: %d, TSDB_Count: %d \n", tsdb_dc_ptr->rep_tsdb_rt, resp->rt_hdr.tsdb_nodes);
  #endif
  tsdb_dc_ptr->rep_num_graph = resp->count;
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp," graph count: %d\n\n",tsdb_dc_ptr->rep_num_graph);
  #endif
  void *var_data = resp->var_data;

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

  uint8_t *len;

  int *group_id = (int *)var_data;
  var_data += 4;

  g_metric_grp_id_t *mg_id = (g_metric_grp_id_t *)var_data;
  var_data += sizeof(g_metric_grp_id_t);
  
  #ifdef TSDB_QUERY_LOGGING
     fprintf(query_log_fp,"mg_id: %d, id_type: %d, group_id: %d\n", mg_id->g_mg_idx, mg_id->type, *group_id);
  #endif

  len = (uint16_t *)var_data;
  var_data += 1;
  char *graph_name = (char *)var_data;
  var_data += *len;
  
  #ifdef TSDB_QUERY_LOGGING
     fprintf(query_log_fp,"Graph name: %*.*s\n", *len, *len, graph_name);
  #endif 
  uint16_t *length = (uint8_t *)var_data;
  var_data += 2;
  char *graph_desc = (char *)var_data;
  var_data += *length;

  #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp,"Graph desc %*.*s\n\n", *length, *length, graph_desc);
  #endif


  char mt_desc[128];
  char mt_name[128];
  for(int j = 0; j < resp->count; ++j)
  {
    len = (uint8_t *)var_data;
    var_data += 1;
    char *mt_name = (char *)var_data;
    var_data += *len;
    #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp," graph name: %*.*s\n", *len, *len, mt_name);
    #endif
    len = (uint8_t *)var_data;
    var_data += 1;
    char *mt_desc = (char *)var_data;
    var_data += *len;

    uint16_t *num = (uint16_t *)var_data;
    var_data += 2;
    #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp," Graph desc: %*.*s, id: %d\n", *len, *len, mt_desc, *num);
    #endif
  }
}

void tsdb_parse_response(void  *resp_buffer, int msg_size, TSDBDataCall *tsdb_dc_ptr)
{
  MsgHdr_t *hdr = (MsgHdr_t *)(resp_buffer);
  RTHdr_t *rt_hdr = (RTHdr_t *)(resp_buffer + sizeof(MsgHdr_t));

  switch(hdr->opcode)
  {
    case TSDB_QUERY_REQ_DERIVED_GROUP:
      parse_group_resp(resp_buffer, tsdb_dc_ptr);  
      break; 
    case TSDB_QUERY_REQ_DERIVED_GRAPH:
      parse_graph_resp(resp_buffer, tsdb_dc_ptr);
      break;
    case TSDB_QUERY_ERROR: //todo check this
      tsdb_dc_ptr->rep_error_code = parse_resp_for_err(resp_buffer, tsdb_dc_ptr);
      fprintf(query_log_fp, "Got TSDB ERRROR Opcode: %d\n", hdr->opcode);
      break;
    default:
      tsdb_dc_ptr->rep_error_code = 9999; //  TODO - get from eror message
      fprintf(query_log_fp, "Invalid msg type in RESPONSE: %d\n", hdr->opcode);
  }
}

