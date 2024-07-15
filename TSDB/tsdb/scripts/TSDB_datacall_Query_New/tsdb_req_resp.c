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
#include <float.h>

#include "tsdb_msg_interface.h"
#include "tsdb_id.h"
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


//--------------------------------------------------------------------------------------
int create_req_for_data_call_by_id(char* buffer, int start_ts_hours_from_now, unsigned short data_filter, int *num_metric)
{
  int sample_count = 60;
  int freq = 60;
  int end_ts = time(NULL) - (start_ts_hours_from_now * 60*60) ;
  int start_ts = end_ts - ((sample_count - 1) * freq); 
  
  uint16_t mt_count = 1;
  
  uint32_t total_sz = sizeof(TSDB_Req_Data_By_Id_t) + 64 * mt_count;
  uint16_t offset = sizeof(TSDB_Req_Data_By_Id_t);
  
  char start_tm_buff[128] = "\0";
  char end_tm_buff[128] = "\0";
  struct tm local_tm1, local_tm2;

  memset(&local_tm1, 0, sizeof(struct tm));
  memset(&local_tm2, 0, sizeof(struct tm));

  localtime_r((time_t *)&start_ts, &local_tm1);
  strftime(start_tm_buff, 128, "%T %D", &local_tm1);

  localtime_r((time_t *)&end_ts, &local_tm2);
  strftime(end_tm_buff, 128, "%T %D", &local_tm2);

  // sprintf(start_tm_buff, "start_tm");
  // sprintf(end_tm_buff, "end_tm");

  #ifdef TSDB_QUERY_LOGGING
//  fprintf(query_log_fp, "\n\nCreating request for. freq: %d, sample_count: %d, start_ts: %d, end_ts: %d\n", freq, sample_count,
   // start_ts, end_ts);
//  fprintf(query_log_fp, "start_time: %s, end_time: %s\n", start_tm_buff, end_tm_buff);
//  fprintf(query_log_fp, "Number of metrics: %d\n\n", mt_count);
  #endif
 
  TSDB_Req_Data_By_Id_t *req = (TSDB_Req_Data_By_Id_t *) buffer;

  req->msg_hdr.version = 1;
  req->msg_hdr.opcode = TSDB_QUERY_REQ_DATA_BY_ID;
  req->msg_hdr.msg_size = total_sz - 4;
  
  req->op_spec.start_ts = start_ts;
  req->op_spec.end_ts = end_ts;
  req->op_spec.freq = freq;
  req->op_spec.tr_num = 1234;
  req->op_spec.mt_count = mt_count;
  req->op_spec.preset = ~0;
  req->op_spec.mt_offset = offset;
  req->op_spec.data_filter = data_filter;

  void *ptr = (void *)req + sizeof(TSDB_Req_Data_By_Id_t);

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "Metric ids: ");
  #endif
  for(int i = 0; i < mt_count; i++)
  {
    ns_advance_param("Metric_ID");
    char *metric_id = ns_eval_string("{Metric_ID}");
    sprintf(metric_id, "%s", metric_id);
    memcpy(ptr, metric_id, 64);
    ptr += 64;

  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "%s, ", metric_id);
  #endif
  } 
  
  return total_sz;
}

//---------------------------------
#define SUBJECT 0
#define MEASURE 1

int fill_subject_or_measure(void* ptr, char* path, int gdf_mg_id, int gdf_mt_id, int flag, int flag2, TSDBDataCall *tsdb_dc_ptr)
{
  long n_bytes = (long)ptr;
  
  char *fields [10];
  uint8_t no_tokens = get_tokens(path, fields, ">",  10);

  uint8_t len;
  char *type;
  char *val;
  
  int id[] = {0, gdf_mg_id, gdf_mt_id};
 /* 
  memcpy(ptr, &no_tokens, 1);
  ptr += 1;
 */
  if(flag2 == 0)
  {
    if(flag == MEASURE)
    *(uint8_t *)ptr = 3;
    else
      memcpy(ptr, &no_tokens, 1);
      ptr += 1;
  }
 
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
     *(int *)ptr = id[i];
      ptr += 4;
    }
  #ifdef TSDB_QUERY_LOGGING
    if(flag == SUBJECT)
    fprintf(query_log_fp, "Subject[%d]>%s>%d\n",i , val, mode);
    if(flag == MEASURE)
    fprintf(query_log_fp, "Measure[%d]>%s>%d\n",i , val, mode);
   #endif 
  }

  return (long)ptr - n_bytes; // to how many bytes it consumed 
}
/*
// int create_req_for_data_call_by_name(char *buffer, int start_ts_hours_from_now, unsigned short data_filter, int *num_metric, char *txname)
int create_req_for_data_call_by_name(TSDBDataCall *tsdb_dc_ptr)
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
  #endif

  TSDB_Req_Data_By_Name_t *req = (TSDB_Req_Data_By_Name_t *)tsdb_dc_ptr->buffer;
  void *var_data = req->var_data;

  int mt_offset = sizeof(TSDB_Req_Data_By_Name_t);
  int total_size = sizeof(TSDB_Req_Data_By_Name_t);

  if(tsdb_dc_ptr->data_filter & DF_MT_FILTER)
  {
    // Fill metric filter and update var_data, mt_offset, total_sizei
    MetricFilterSpec_t *mt_filter = (MetricFilterSpec_t *)var_data;
    var_data += sizeof(MetricFilterSpec_t);
    mt_offset += sizeof(MetricFilterSpec_t);
    total_size += sizeof(MetricFilterSpec_t);
        
  }

  if(tsdb_dc_ptr->data_filter & DF_SAMPLE_FILTER)
  {
    // Fill sample filter and update var_data, mt_offset, total_size
  }

  // Fill subject and measure

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "Number of metrics: %d\n\n", tsdb_dc_ptr->req_num_metrics);
  #endif

  for(int i = 0; i < tsdb_dc_ptr->req_num_metrics; i++)
  {
    char *sub, *measure;

    
    if(tsdb_dc_ptr->subject_mode == SUBJECT_MODE_EXACT) {
      ns_advance_param("subject");
      sub = ns_eval_string("{subject}");   
    }
    else {
      ns_advance_param("subjectP");
      sub = ns_eval_string("{subjectP}");   
    }

    ns_advance_param("subject");
    sub = ns_eval_string("{subject}");   

  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "mt: %d, subject: %s", i, sub);
  #endif

    int sub_len = fill_subject_or_measure(var_data, sub, SUBJECT, tsdb_dc_ptr);
    var_data += sub_len;
    total_size += sub_len; 

  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "MetridId = %s", ns_eval_string("{Metric_ID}"));
  #endif
    
    if(tsdb_dc_ptr->subject_mode == SUBJECT_MODE_EXACT) 
      measure = ns_eval_string("{measure}");   
    else
      measure = ns_eval_string("{measureP}");

    measure = ns_eval_string("{measure}");

  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "measure: %s\n", measure);
  #endif
    
    int ms_len = fill_subject_or_measure (var_data, measure, MEASURE, tsdb_dc_ptr);
    var_data += ms_len;
    total_size += ms_len;
  }
  
  req->msg_hdr.msg_size = total_size - 4;
  req->msg_hdr.opcode = TSDB_QUERY_REQ_DATA_BY_NAME;
  req->msg_hdr.version = 1;
  req->msg_hdr.cor_id = tsdb_dc_ptr->cor_id;

  req->op_spec.freq = tsdb_dc_ptr->req_freq;
  req->op_spec.start_ts = tsdb_dc_ptr->start_ts;
  req->op_spec.end_ts = tsdb_dc_ptr->end_ts;
  req->op_spec.preset = tsdb_dc_ptr->time_period;
  req->op_spec.tr_num = tsdb_dc_ptr->test_run;
  req->op_spec.mt_count = tsdb_dc_ptr->req_num_metrics;
  req->op_spec.mt_offset =mt_offset;
  req->op_spec.data_filter = tsdb_dc_ptr->data_filter;
 
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "req->msg_hdr.opcode = %d\n\n", req->msg_hdr.opcode);
  fprintf(query_log_fp, "\n\n");
  #endif
  return total_size;

}
*/
char convert_hex2char(char *hexstr)
{ 
  char c = 0; 
  for(int i = 0; i < 2; i++)
  { 
    char tmp = *(hexstr+i); 
    if(tmp >= '0' && tmp <= '9')
      tmp -= '0';
    else if (tmp >= 'a' && tmp <= 'f')
      tmp = tmp - 'a' + 10;
    else if (tmp >= 'A' && tmp <= 'F')
      tmp = tmp - 'A' + 10;
    
    c = c*16 + tmp;
  }
  return c;
}


void tsdb_id_hex_to_bin(char *hex_id_buff, int len, void *bin_id_buff)
{
  char byte = 0;
  int  offset = 0;

  for(int i = 0; i < len; i += 2) {
    byte = convert_hex2char(hex_id_buff + i);
    *(char *)(bin_id_buff + offset) = byte;
    offset++;
  }

}
#define TSDB_ID_BIN_TO_HEX(bin_id_ptr, bin_id_sz, hex_id_buff) \
{ \
  int n = 0; \
  for(int ch = 0; ch < (bin_id_sz); ch++) \
    n += sprintf((hex_id_buff) + n, "%02X", (((unsigned char )(bin_id_ptr)) + ch)); \
}

void copy_dci_req_data(void **var_data, int *total_size)
{
  ns_advance_param("Metric_ID");
  char *metric_id = ns_eval_string("{Metric_ID}");
  metric_id_t mt_id;
  tsdb_id_hex_to_bin(metric_id, strlen(metric_id), &mt_id);
  memcpy(*var_data, &mt_id, sizeof(metric_id_t));
  *var_data += sizeof(metric_id_t);
  *total_size += sizeof(metric_id_t);              //calculate total size for call_by_id

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "%s, ", metric_id);
  #endif
}

void copy_dcn_req_data(int mt, void **var_data, int *total_size, TSDBDataCall *tsdb_dc_ptr)
{
  char *sub;
	  char measure[1024];

  ns_advance_param("subject");
  sub = ns_eval_string("{subject}");

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "mt: %d, subject: %s", mt, sub);
  fflush(query_log_fp);
  #endif

  int sub_len = fill_subject_or_measure(*var_data, sub, 0, 0, SUBJECT, 0, tsdb_dc_ptr);
  *var_data += sub_len;
  *total_size += sub_len;
  strcpy(measure, ns_eval_string("{measure}"));
  //measure = ns_eval_string("{measure}");
  int gdf_mg_id = atoi(ns_eval_string("{GDF_ID}"));
  int gdf_mt_id = atoi(ns_eval_string("{Graph_ID}"));
  
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "measure: %s\n", measure);
  fflush(query_log_fp);
  #endif

  int ms_len = fill_subject_or_measure (*var_data, measure, gdf_mg_id, gdf_mt_id, MEASURE, 0, tsdb_dc_ptr);
  *var_data += ms_len;
  *total_size += ms_len;
}

int create_req_for_data_call(TSDBDataCall *tsdb_dc_ptr)
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
  if(tsdb_dc_ptr->end_ts == 0)
       fprintf(query_log_fp,"end_ts: %ld", time(NULL));
  else
       fprintf(query_log_fp,"end_ts: %ld", tsdb_dc_ptr->end_ts);

  fprintf(query_log_fp, "\n\nCreating request for. freq: %d, time_period = %s, start_ts: %d, end_ts: %d\n", tsdb_dc_ptr->req_freq,
                         time_period[tsdb_dc_ptr->time_period], tsdb_dc_ptr->start_ts, tsdb_dc_ptr->end_ts);
//  fprintf(query_log_fp, "start_time: %s, end_time: %s\n", start_tm_buff, end_tm_buff);
  fprintf(query_log_fp, "Number of metrics: %d\n\n", tsdb_dc_ptr->req_num_metrics);
  #endif

  TSDB_Req_Data_By_Name_t *req = (TSDB_Req_Data_By_Name_t *)tsdb_dc_ptr->buffer;

  void *var_data = req->var_data;

  int mt_offset = sizeof(TSDB_Req_Data_By_Name_t);
  int total_size = sizeof(TSDB_Req_Data_By_Name_t);
  
  tsdb_dc_ptr->metric_filter_type = 0;
  tsdb_dc_ptr->mt_op = 0; 
  if(tsdb_dc_ptr->data_filter & DF_MT_FILTER)
  {
    // Fill metric filter and update var_data, mt_offset, total_sizei
    MetricFilterSpec_t *mt_filter = (MetricFilterSpec_t *)var_data;
    var_data += sizeof(MetricFilterSpec_t);
    mt_offset += sizeof(MetricFilterSpec_t);
    total_size += sizeof(MetricFilterSpec_t);

    //tsdb_dc_ptr->metric_filter_type will random form 0 to 3 . 0 = min , 1 = max , 2 Avg , 3 Count 
    int filter_type = atoi(ns_eval_string("{FILTER_TYPE}"));
    tsdb_dc_ptr->metric_filter_type = ns_get_random_number_int(0, filter_type);
    if(tsdb_dc_ptr->metric_filter_type == 0)
    { 
      mt_filter->mt_filter_type |= FLT_TYPE_MIN | FLT_TYPE_INC;
    }
    else if (tsdb_dc_ptr->metric_filter_type == 1)
    { 
      mt_filter->mt_filter_type |= FLT_TYPE_MAX | FLT_TYPE_INC;
    }
    else if (tsdb_dc_ptr->metric_filter_type == 2)
    {
      mt_filter->mt_filter_type |= FLT_TYPE_AVG | FLT_TYPE_INC;
    }
    else
    {
      mt_filter->mt_filter_type |= FLT_TYPE_COUNT | FLT_TYPE_INC;
    }
    
    int min_op_num = atoi(ns_eval_string("{MIN_OP_NUMBER}"));
    int max_op_num = atoi(ns_eval_string("{MAX_OP_NUMBER}"));
    tsdb_dc_ptr->mt_op = mt_filter->mt_op = ns_get_random_number_int(min_op_num, max_op_num);

    if (tsdb_dc_ptr->mt_op == 1 )
    {
       mt_filter->value1= 1.1;
       mt_filter->value2= 1.1;
    }
    else if (tsdb_dc_ptr->mt_op == 2 || tsdb_dc_ptr->mt_op == 3)
    {
       mt_filter->value1= 69.00;
       mt_filter->value2= 69.00;
    }
    else if (tsdb_dc_ptr->mt_op == 4 || tsdb_dc_ptr->mt_op == 5)
    {
       mt_filter->value1= 100.00;
       mt_filter->value2= 100.00;
    }
     else if (tsdb_dc_ptr->mt_op == 6)
    {  
       mt_filter->value1= 0;
       mt_filter->value2= 7.0;
    }
     else if (tsdb_dc_ptr->mt_op == 7 || tsdb_dc_ptr->mt_op == 8)
    {
       mt_filter->value1= 10;
       mt_filter->value2= 10;
    }
  }
  if(tsdb_dc_ptr->data_filter & DF_SAMPLE_FILTER)
  {
    // Fill sample filter and update var_data, mt_offset, total_size
  }

  // Fill subject and measure

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "Number of metrics: %d\n\n", tsdb_dc_ptr->req_num_metrics);
  #endif

  for(int i = 0; i < tsdb_dc_ptr->req_num_metrics; i++)
  {
    if(tsdb_dc_ptr->call_mode == 0)  //for call by id)
    {
      copy_dci_req_data(&var_data, &total_size);

      #if 0
      ns_advance_param("Metric_ID");
      char *metric_id = ns_eval_string("{Metric_ID}");
      sprintf(metric_id, "%s", metric_id);
      memcpy(var_data, metric_id, 64);
      var_data += 64;
      total_size += 64;              //calculate total size for call_by_id

      #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "%s, ", metric_id);
      #endif
      #endif
    }
    else                             //for call by name)
    {
      copy_dcn_req_data(i, &var_data, &total_size, tsdb_dc_ptr);

      #if 0
      char *sub, *measure;

      ns_advance_param("subject");
      sub = ns_eval_string("{subject}");

      #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "mt: %d, subject: %s", i, sub);
      #endif

      int sub_len = fill_subject_or_measure(var_data, sub, SUBJECT, tsdb_dc_ptr);
      var_data += sub_len;
      total_size += sub_len;

      measure = ns_eval_string("{measure}");

      #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "measure: %s\n", measure);
      #endif

      int ms_len = fill_subject_or_measure (var_data, measure, MEASURE, tsdb_dc_ptr);
      var_data += ms_len;
      total_size += ms_len;
      #endif
    }
  }
  req->msg_hdr.msg_size = total_size - 4;
  req->msg_hdr.opcode = (tsdb_dc_ptr->call_mode == 0)?TSDB_QUERY_REQ_DATA_BY_ID:TSDB_QUERY_REQ_DATA_BY_NAME;
  req->msg_hdr.version = 1;
  req->msg_hdr.cor_id = tsdb_dc_ptr->cor_id;

  req->op_spec.freq = tsdb_dc_ptr->req_freq;
  req->op_spec.start_ts = tsdb_dc_ptr->start_ts;
  req->op_spec.end_ts = tsdb_dc_ptr->end_ts;
  req->op_spec.preset = tsdb_dc_ptr->time_period;
  req->op_spec.tr_num = tsdb_dc_ptr->test_run;
  req->op_spec.mt_count = tsdb_dc_ptr->req_num_metrics;
  req->op_spec.mt_offset = mt_offset;
  req->op_spec.data_filter = tsdb_dc_ptr->data_filter;

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "\n\n");
  #endif
 // fprintf(query_log_fp, "start_time: %d, end_time: %d", req->op_spec.start_ts, req->op_spec.end_ts);
  return total_size;
}

short df_mask[NUM_DF] ={DF_AVG, DF_MIN, DF_MAX, DF_COUNT, DF_SUM_COUNT, DF_SUM_SQUARE};

int datatype_map[] = {1, 1, 1, 4, 5, 1, 1, 4, 1, 1, 2, 1, 5, 1, 1, 4, 1};

int copy_data(void *ptr, char *dest_buffer, int dest_buff_len, char *name)
{ 
   long sz = (long)ptr;
   uint8_t len = *((uint8_t *)ptr);
   ptr += 1; 

   if(len > dest_buff_len)
   {
     //fprintf(stderr, "Length(%d) of the string(%s) is greater than buffer length(%d). Data = %*.*s\n", 
     //           len, name, dest_buff_len, len, len, *ptr);
     len = dest_buff_len;
   }
   memcpy(dest_buffer, ptr, len);              
   ptr += len;
   dest_buffer[len] = '\0';
   
   return (int)((long)ptr - sz); 
}
       
static int  count_nf_sf(int freq, int *count, int add_count)
{
  switch(freq)
  {
    case 1:
      count[0] += add_count;
      break;
    case 10:
      count[1] += add_count;
      break;
    case 60:
      count[2] += add_count;
      break;
    case 600:
      count[3] += add_count;
      break;
    case 3600:
      count[4] += add_count;
      break;
    case 14400:
      count[5] += add_count;
      break;
    case 86400:
      count[6] += add_count;
      break;
    default :
      count[7] += add_count;
      return -1;
  }
  return 0;
}

int script_parse_header(TSDB_Resp_Data_t *resp, TSDBDataCall *tsdb_dc_ptr)
{
  tsdb_dc_ptr->rep_tsdb_rt = resp->rt_hdr.qhead_rt;
  
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "Msg hdr opcode: %d, partition_info = %d\n", resp->msg_hdr.opcode, resp->msg_hdr.flags);
  fprintf(query_log_fp, "RT Hdr. qhead_rt: %d, tsdb_nodes: %d\n", tsdb_dc_ptr->rep_tsdb_rt, resp->rt_hdr.tsdb_nodes);
  #endif

  //int partition_info = (resp->msg_hdr.partition_info);
  
  tsdb_dc_ptr->offline_file_count = resp->msg_hdr.off_fc; //(partition_info & 0xfc) >> 2;
  tsdb_dc_ptr->online_mode = resp->msg_hdr.flags & ONLINE_PRESENT ? 1:0; //(partition_info & 0x01);
  tsdb_dc_ptr->uproll_mode = resp->msg_hdr.flags & UNROLL_PRESENT ? 1:0; //(partition_info & 0x02) >> 1;

  //#ifdef TSDB_QUERY_LOGGING_L1
  //if(tsdb_dc_ptr->cor_id != resp->msg_hdr.cor_id) //Checking req cor_id sameas resp cor_id
    //fprintf(query_log_fp, "tsdb_id: %d, tsdb_rt: %d\n\n", );
  //#endif

   #ifdef TSDB_QUERY_LOGGING_L1
    fprintf(query_log_fp, "msg_hdr.off_fc %d\n", resp->msg_hdr.off_fc);
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
  return (int)((long)ptr - sz);
}

int script_parse_data_freq_spec(void *ptr, TSDBDataCall *tsdb_dc_ptr)
{ 
  DataFreqSpec_t *freq_spec = (DataFreqSpec_t *)ptr;
  #if 1
  tsdb_dc_ptr->rep_freq_spec.freq = freq_spec->freq;
  tsdb_dc_ptr->rep_freq_spec.mt_count = freq_spec->mt_count;
  tsdb_dc_ptr->rep_freq_spec.sample_count = freq_spec->sample_count;
  tsdb_dc_ptr->rep_freq_spec.start_ts = freq_spec->start_ts;
  tsdb_dc_ptr->rep_freq_spec.flags = freq_spec->flags;
  if(count_nf_sf(tsdb_dc_ptr->rep_freq_spec.freq, tsdb_dc_ptr->count_SF, tsdb_dc_ptr->rep_freq_spec.mt_count) < 0) {
    fprintf(query_log_fp, "Invalid selected frequency = %d\n", tsdb_dc_ptr->rep_freq_spec.freq);
    return -1;
  }

  #endif

 
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "\n\nstart_ts: %d, freq: %u, mt_count: %d, sample_count: %d Incremantal flag: %d \n\n", 
                        tsdb_dc_ptr->rep_freq_spec.start_ts, tsdb_dc_ptr->rep_freq_spec.freq, 
                        tsdb_dc_ptr->rep_freq_spec.mt_count, tsdb_dc_ptr->rep_freq_spec.sample_count, (tsdb_dc_ptr->rep_freq_spec.flags & MT_FLAG_PARTIAL_SAMPLE));
  #endif

  //tsdb_dc_ptr->rep_num_metrics += freq_spec->mt_count;
  //tsdb_dc_ptr->rep_num_sample += freq_spec->sample_count;
  tsdb_dc_ptr->rep_num_metrics += freq_spec->mt_count;
  tsdb_dc_ptr->rep_num_sample += freq_spec->sample_count;

  return ((int)sizeof(DataFreqSpec_t));
}

int script_parse_metric_id(void *ptr)
{
 // char metric_id[64 + 1];

  //memcpy(metric_id, ptr, 64);
  //metric_id[64] = '\0';

  //#ifdef TSDB_QUERY_LOGGING
    //fprintf(query_log_fp, "metric id: %s\n", metric_id);
  //#endif

  return 24;
}

int script_parse_data_type(void *ptr)
{
  uint8_t *data_type = (uint8_t *)ptr;
  #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "data_type: %d, ", *data_type);
  #endif
  return 1;
}
int script_parse_derived_flag (void *ptr, uint8_t *flag)
{
   *flag = *(uint8_t *)ptr;
   ptr++;
    #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "flag: %d\n", *flag);
  #endif
  return 1;

}

int script_parse_native_freq(void *ptr, uint32_t *native_freq)
{
    *native_freq = *(uint32_t *)ptr;

  #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "native frequency: %u\n", *native_freq);
  #endif
  return 4;
}

int script_parse_subject(void *ptr)
{
  char app_name[128 + 1];
  char s_meta[128 + 1];
  char s_name[128 + 1];
  long sz = (long)ptr;
  int len = 0;

  len = copy_data(ptr, app_name, sizeof(app_name) - 1, "Appname");
  ptr += len;

  len = copy_data(ptr, s_meta, sizeof(s_meta) - 1, "SubjectMeta");
  ptr += len;

  len = copy_data(ptr, s_name, sizeof(s_name) - 1, "SubjectName");
  ptr += len;

  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "app_name: %s, s_meta: %s, s_name: %s\n", app_name, s_meta, s_name);
  #endif

  return (int)((long)ptr - sz);
}

int script_parse_measure(void *ptr, TSDBDataCall *tsdb_dc_ptr)
{
  char tag[128 + 1];
  char value[128 + 1];
  int len = 0;

  long sz = (long)ptr;

  uint8_t *mem_count = (uint8_t *)ptr;
  ptr += 1;

  #ifdef TSDB_QUERY_LOGGING
    
      fprintf(query_log_fp, "mem_count=%d ,Measure:", *mem_count);      
  #endif
  for(int j = 0; j < *mem_count; ++j)
  {
    len = copy_data(ptr, tag, sizeof(tag) - 1, "MeasureTag");
    ptr += len;

    len = copy_data(ptr, value, sizeof(value) - 1, "MeasureValue");
    if(j == 1)
    {
    ns_save_string(value,"MonitorGroup");
    tsdb_dc_ptr->monitor_group = value;
    }
    
    ptr += len;
   
    // ID- TODO:into stucture or not               
    int *id;
    id = (int *)ptr;
    ptr += 4;
    //*id = ntohl(*id);

    #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "%s:%s>", tag, value);
    #endif
  }

  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp,"\n");
    fprintf(query_log_fp, "MonitorGroup= %s tsdb_dc_ptr->monitor_group =%s\n",ns_eval_string("{MonitorGroup}"),tsdb_dc_ptr->monitor_group); 
 #endif
  

  return (int)((long)ptr - sz);
}

int script_parse_data(void *ptr, TSDBDataCall *tsdb_dc_ptr)
{
  long sz = (long)ptr;
  int nv = 0;
  for(int i = 0; i < NUM_DF; i++)
  {
    if(tsdb_dc_ptr->data_filter & df_mask[i])
      nv++;
  }
  //fprintf(query_log_fp,"value of data_filter : %x\n",tsdb_dc_ptr->data_filter);
  //fprintf(query_log_fp,"value of nv : %d\n",nv);
  
  //SlabCount
  //for slab_count
  uint8_t num_slab;
  double start, end;
  
  if(tsdb_dc_ptr->data_filter & DF_PERCENTILE)
  {
    //for percentile
    nv = 1;
  }
  else if(tsdb_dc_ptr->data_filter & DF_SLAB_COUNT)
  {
    //for slab count
    num_slab = *(uint8_t *)ptr;
    ptr += 1;

    //slab name array
     #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "slab_name: ");
     #endif
    double *slab_name_array = (double *)ptr;
    for(int i = 0; i < num_slab; i++)
    {
      //ntohd(start, slab_name_array[i * 2]);
      //ntohd(end, slab_name_array[i * 2 + 1]);
       #ifdef TSDB_QUERY_LOGGING
       fprintf(query_log_fp, "%lf-%lf, ", slab_name_array[i * 2], slab_name_array[i * 2 + 1]);
       #endif
    }

    ptr += num_slab * 2 * 8;

    //updating nv and num_sample
    nv = 1;
    tsdb_dc_ptr->rep_freq_spec.sample_count = num_slab;
  }


  //fprintf(query_log_fp,"value of nv : %d\n",nv);
  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "\nMetric data: ");
  #endif
  
      //double  min_value = atof(ns_eval_string("{Min_Value}"));
      //double  max_value = atof(ns_eval_string("{Max_Value}"));
  double *data_arr = (double *) ptr;
  for(int a = 0; a < tsdb_dc_ptr->rep_freq_spec.sample_count; a++)
  {
    for(int b = 0; b < nv; b++) // request for 3 datatypes in datafilter
    {
      double d;
      d = data_arr[b];

      if((a == tsdb_dc_ptr->rep_freq_spec.sample_count - 1) && (d == TSDB_NULL_DATA_SAMPLE))
       {
	  #ifdef TSDB_QUERY_LOGGING
	  fprintf(query_log_fp, "NULL");
          #endif
       }
      else
      {
         //ntohd(d, data_arr[b]); 
         //doubt??  
         #ifdef TSDB_QUERY_LOGGING
         fprintf(query_log_fp, "%0.2lf ", data_arr[b]);
         #endif
      }
    }

 //  if (strcmp(tsdb_dc_ptr->monitor_group, ns_eval_string("{MonitorGroup}")) == 0)
 //  {
 //    #ifdef TSDB_QUERY_LOGGING
 //     fprintf(query_log_fp, "Monitor Group matched \n");
 //    #endif
     #if 0 
      if (data_arr[0] >= min_value && data_arr[1] <= max_value)
        {
            #ifdef TSDB_QUERY_LOGGING
             fprintf(query_log_fp, "ted \n");
             #endif
        }
     #endif
 //  }
 //  else
 //  {
 //    #ifdef TSDB_QUERY_LOGGING
 //       fprintf(query_log_fp, "Monitor Group not matched form index file param\n ");
 //    #endif  
  // }
  #ifdef TSDB_QUERY_LOGGING
    fprintf(query_log_fp, "| ");
  #endif
    data_arr += nv;
  }
  ptr += (nv * tsdb_dc_ptr->rep_freq_spec.sample_count * 8);

  return (int)((long)ptr - sz);
}

int script_parse_summary(void *ptr, TSDBDataCall *tsdb_dc_ptr)
{
  DataSummary_t *summary = (DataSummary_t *)ptr;
 
  #if 1
    tsdb_dc_ptr->rep_data_summary.min = summary->min;
    tsdb_dc_ptr->rep_data_summary.max = summary->max;
    tsdb_dc_ptr->rep_data_summary.avg = summary->avg;
    tsdb_dc_ptr->rep_data_summary.count = summary->count;
    tsdb_dc_ptr->rep_data_summary.std_dev = summary->std_dev;
    tsdb_dc_ptr->rep_data_summary.last_sample = summary->last_sample;
    tsdb_dc_ptr->rep_data_summary.diff = summary->diff;
    tsdb_dc_ptr->rep_data_summary.sum = summary->sum;
  #endif
  #ifdef TSDB_QUERY_LOGGING
        fprintf(query_log_fp, "\nSummary: min: %0.2f, max: %0.2f, avg: %0.2f, count: %0.2f, std_dev: %0.2f, last_sample: %0.2f, diff: %0.2f, sum: %0.2f\n", tsdb_dc_ptr->rep_data_summary.min, tsdb_dc_ptr->rep_data_summary.max, tsdb_dc_ptr->rep_data_summary.avg, tsdb_dc_ptr->rep_data_summary.count, tsdb_dc_ptr->rep_data_summary.std_dev, tsdb_dc_ptr->rep_data_summary.last_sample, tsdb_dc_ptr->rep_data_summary.diff, tsdb_dc_ptr->rep_data_summary.sum);
  #endif

  return ((int)sizeof(DataSummary_t));
}

#define	SCRIPT_UPDATE_PTR(ptr, len, msg_size) { \
  if(len < 0) { \
    fprintf(query_log_fp, "len is -ve due to method returning error"); \
    return; \
  } \
  ptr += len; \
  msg_size -= len; \
  if(msg_size < 0) { \
    fprintf(query_log_fp, "msg_size left (%d) to process is -ve\n", msg_size); \
    return; \
  }\
}

void script_parse_data_resp(void *buffer, int msg_size, TSDBDataCall *tsdb_dc_ptr)
{ 
  char tx_name[1024];
  int tx_name_offset = 0;
   
  DataFreqSpec_t resp_freq_spec;
  TSDB_Resp_Data_t *resp = (TSDB_Resp_Data_t *)buffer;
  
  tx_name_offset = resp->msg_hdr.tx_name_offset;
  void *tx_ptr = (TSDB_Resp_Data_t *)buffer;
  tx_ptr += tx_name_offset;

  uint8_t *tx_len = (uint8_t *)tx_ptr;
  tx_ptr++;

  memcpy(tx_name, tx_ptr, *tx_len);
  tx_name[*tx_len] = '\0';
 
  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp,"TX_name(%d): %s, tx_name_offset = %d\n", *tx_len, tx_name, tx_name_offset);
  #endif
  
  void *ptr = resp->var_data;
  
  // parsing header
  int len = script_parse_header(resp, tsdb_dc_ptr);
  SCRIPT_UPDATE_PTR(ptr, len, msg_size);

  //Make function parse_freq_count
  tsdb_dc_ptr->rep_freq_count = *(uint8_t *)ptr;
  SCRIPT_UPDATE_PTR(ptr, 1, msg_size);

  #ifdef TSDB_QUERY_LOGGING
  fprintf(query_log_fp, "tsdb_dc_ptr->rep_freq_count: %d\n", tsdb_dc_ptr->rep_freq_count);
  #endif
  if(tsdb_dc_ptr->rep_freq_count > 7)  
  {
    fprintf(query_log_fp, "Error: req_freq_count > 7, tsdb_dc_ptr->rep_freq_count: %d\n", tsdb_dc_ptr->rep_freq_count);
    tsdb_dc_ptr->rep_error_code = 9998;
    return;
  }

  for(int k = 0; k < tsdb_dc_ptr->rep_freq_count; k++)
  {
    len = script_parse_data_freq_spec(ptr, tsdb_dc_ptr);
    SCRIPT_UPDATE_PTR(ptr, len, msg_size);

    if(tsdb_dc_ptr->rep_freq_spec.freq == TSDB_ERR)
    {
       fprintf(query_log_fp, "\nInvalid freq spec\n"); 
    }
   
    #if 1
    else
    {
      for(int i = 0; i < tsdb_dc_ptr->rep_freq_spec.mt_count; i++)
      {
        len = script_parse_metric_id(ptr);
        SCRIPT_UPDATE_PTR(ptr, len, msg_size);

        len = script_parse_data_type(ptr);
        SCRIPT_UPDATE_PTR(ptr, len, msg_size);
        
        uint8_t flag;
        len = script_parse_derived_flag(ptr, &flag);
        SCRIPT_UPDATE_PTR(ptr, len, msg_size);

        uint32_t native_freq;
        len = script_parse_native_freq(ptr, &native_freq);
        SCRIPT_UPDATE_PTR(ptr, len, msg_size);
        //uint32_t *native_freq = (uint32_t *)ptr;

        if(count_nf_sf(native_freq, tsdb_dc_ptr->count_NF, 1) < 0) {
          fprintf(query_log_fp, "Invalid native frequency = %d\n", native_freq);
          return -1;
        }

        len = script_parse_subject(ptr);
        SCRIPT_UPDATE_PTR(ptr, len, msg_size);
           
        int n = 0;
      
        len = script_parse_measure(ptr, tsdb_dc_ptr);
        SCRIPT_UPDATE_PTR(ptr, len, msg_size);
      
        //measure[n - 1] = '\0';
        //fprintf(query_log_fp, "Measure: %s\n", measure);
      
        if(tsdb_dc_ptr->rep_freq_spec.freq != TSDB_ERR)        
        {
          len = script_parse_data(ptr, tsdb_dc_ptr);
          SCRIPT_UPDATE_PTR(ptr, len, msg_size);

          if((tsdb_dc_ptr->data_filter & DF_DATA_SUMMARY) && (tsdb_dc_ptr->rep_freq_spec.sample_count))
          { 
            len = script_parse_summary(ptr, tsdb_dc_ptr);
            SCRIPT_UPDATE_PTR(ptr, len, msg_size);
          }
        }
        #ifdef TSDB_QUERY_LOGGING
          fprintf(query_log_fp, "\n\n");
        #endif
      }
      #endif
    }
  }

  fflush(query_log_fp);
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
  RTHdr_t *rt_hdr = (RTHdr_t *)(resp_buffer + sizeof(MsgHdr_t));

  //hdr->opcode = ntohs(hdr->opcode);


  switch(hdr->opcode)
  {
    case TSDB_QUERY_REQ_DATA_BY_NAME :
    case TSDB_QUERY_REQ_DATA_BY_ID: //todo check this
      script_parse_data_resp(resp_buffer, msg_size, tsdb_dc_ptr);
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

