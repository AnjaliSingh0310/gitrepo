#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ns_string.h"
#include "tsdb_data_query.h"
#include "tsdb_req_resp.c"
#include "tsdb_msg_interface.h"


char *time_period[] = {"C", "L10m", "L30m", "L1h", "L2h", "L4h", "L6h", "L8h", "L12h", "L24h", "today", "yday", "L7d", "L30d", "L90d", "LThisw", "L1w", "L2w", "L3w", "L4w", "Thism", "L1m", "L2m", "L3m", "L6m", "Thisyr", "L1yr"};  

//int frequency[]={1, 10, 60};

FILE *query_log_fp = NULL;

static time_t test_start_ts;

void tsdb_query_by_name_init(TSDBDataCall *tsdb_dc_ptr)
{
  char file_path[512];
  tsdb_dc_ptr->test_id = ns_get_testid();
  tsdb_dc_ptr->user_id = ns_get_userid();
  tsdb_dc_ptr->nvm_id  = ns_get_nvmid();
  tsdb_dc_ptr->ns_wdir = getenv("NS_WDIR");
  sprintf(file_path, "%s/logs/TR%d/query_log_%d_%d.txt", tsdb_dc_ptr->ns_wdir, tsdb_dc_ptr->test_id, tsdb_dc_ptr->nvm_id, tsdb_dc_ptr->user_id);

  if(query_log_fp == NULL)
  {
    test_start_ts = time(NULL);
    query_log_fp = tsdb_dc_ptr->query_log_fp = fopen(file_path, "a");
    if(query_log_fp == NULL)
        fprintf(stderr, "Error in opening query log file = %s, err[%s]", file_path, strerror(errno));
  }
  ns_advance_param("ControllerIP");

  strcpy(tsdb_dc_ptr->nd_ip, ns_eval_string("{ControllerIP}"));
  strcpy(tsdb_dc_ptr->nd_port, ns_eval_string("{ControllerPort}")); // TSDB Query Port

  snprintf(tsdb_dc_ptr->uri, 64, "%s:%s", tsdb_dc_ptr->nd_ip, tsdb_dc_ptr->nd_port);
  ns_save_string(tsdb_dc_ptr->uri, "TSDB_HOST");

  //tsdb_dc_ptr->cor_id = ns_get_unique_number();
}

void tsdb_query_by_name_set_req_fields(TSDBDataCall *tsdb_dc_ptr)
{  
   char *field[10];

  char *read_buf = ns_eval_string("{SubjectMode}"); 
  get_tokens_with_multi_delimiter(read_buf, field, ":,", 10);

  int value1 = atoi(field[1]);
  int value2 = atoi(field[3]) + value1;
  int value3 = atoi(field[5]) + value2;

  int sub_num = ns_get_random_number_int(0, 100);

  if ( sub_num > 0 && sub_num < value1)
    tsdb_dc_ptr->subject_mode = atoi(field[0]);
  else if (sub_num > value1 && sub_num < value2)
    tsdb_dc_ptr->subject_mode = atoi(field[2]);
  else if (sub_num > value2 && sub_num < value3)
    tsdb_dc_ptr->subject_mode = atoi(field[4]);

 /*
  char *read_call_buf = ns_eval_string("{CallMode}");
  get_tokens_with_multi_delimiter(read_call_buf, field, ":,", 10);

  int var1 = atoi(field[1]);
  int var2 = atoi(field[3]) + var1;
  
  int call_num = ns_get_random_number_int(0, 100);

  if ( call_num > 0 && call_num < var1)
    tsdb_dc_ptr->call_mode = atoi(field[0]);
  else if (call_num > var1 && call_num < var2)
    tsdb_dc_ptr->call_mode = atoi(field[2]);    
*/
  
  tsdb_dc_ptr->req_freq = atoi(ns_eval_string("{REQ_FREQ}"));  // 0 means request frequency will be ignored by TSDB
  //tsdb_dc_ptr->subject_mode = 0;
  tsdb_dc_ptr->call_mode = atoi(ns_eval_string("{CallMode}")); //ns_get_random_number_int(0, 1);  //0->for call by id  &  1->for call by name
  tsdb_dc_ptr->rep_num_metrics = 0;
  tsdb_dc_ptr->rep_num_sample = 0;
  tsdb_dc_ptr->rep_error_code = 0;
  tsdb_dc_ptr->rep_freq_count = 0;
  tsdb_dc_ptr->offline_file_count = 0;
  set_req_tp(tsdb_dc_ptr);

  memset(tsdb_dc_ptr->count_SF, 0, 8 * sizeof(int));
  memset(tsdb_dc_ptr->count_NF, 0, 8 * sizeof(int));

  tsdb_dc_ptr->hierachy_levels = 4;

  char *read_metric_buf = ns_eval_string("{MetricDataMode}");
  get_tokens_with_multi_delimiter(read_metric_buf, field, ":,", 10);

  
  int var1 = atoi(field[1]);
  int var2 = atoi(field[3]) + var1;
  int var3 = atoi(field[5]) + var2;
  
  int metric_num = ns_get_random_number_int(0, 100);

  if ( metric_num > 0 && metric_num < var1)
    tsdb_dc_ptr->metrics_data_mode = atoi(field[0]);
  else if (metric_num > var1 && metric_num < var2)
    tsdb_dc_ptr->metrics_data_mode = atoi(field[2]);
  else if (metric_num > var2 && metric_num < var3)
    tsdb_dc_ptr->metrics_data_mode = atoi(field[4]);
  
  
  char *read_mt_filter_buf = ns_eval_string("{METRIC_FILTER_OPTION}");
  get_tokens_with_multi_delimiter(read_mt_filter_buf, field, ":,", 10);
  
  var1 = atoi(field[1]);
  var2 = atoi(field[3]) + var1;
   
   if ( metric_num > 0 && metric_num < var1)
    tsdb_dc_ptr->mt_filter_option = atoi(field[0]);
  else if (metric_num > var1 && metric_num < var2)
    tsdb_dc_ptr->mt_filter_option = atoi(field[2]);
  

  //tsdb_dc_ptr->metrics_data_mode = 0; //ns_get_random_number_int(0, 2);  //0-> normal mode, 1-> percentile mode, 2-> slab mode
  if(tsdb_dc_ptr->metrics_data_mode == 0)
  {
   //tsdb_dc_ptr->mt_filter_option 0 -> Nofilter ,1 -> top N , 2 -> Buttom N 
    if (tsdb_dc_ptr->mt_filter_option == 0)
     tsdb_dc_ptr->data_filter = DF_MIN | DF_MAX | DF_AVG | DF_COUNT | DF_DATA_SUMMARY;
    else if (tsdb_dc_ptr->mt_filter_option == 1)
     tsdb_dc_ptr->data_filter = DF_MIN | DF_MAX | DF_AVG | DF_COUNT | DF_DATA_SUMMARY | DF_MT_FILTER ; // Data filters
  }
  else if(tsdb_dc_ptr->metrics_data_mode == 1)
  {
    tsdb_dc_ptr->data_filter = DF_PERCENTILE;
  }
  else
  {
    tsdb_dc_ptr->data_filter = DF_SLAB_COUNT;
  }
  
  if(tsdb_dc_ptr->subject_mode == 0)
   tsdb_dc_ptr->req_num_metrics = atoi(ns_eval_string("{MetricCount}"));
   //tsdb_dc_ptr->req_num_metrics = ns_get_random_number_int(30, 500);
  else
    tsdb_dc_ptr->req_num_metrics = atoi(ns_eval_string("{MetricCount}")); // TODO

  tsdb_dc_ptr->cor_id = ns_get_unique_number();
}
void set_req_tp(TSDBDataCall *tsdb_dc_ptr)
{
  int tp_rn =  ns_get_random_number_int(1,100);
  int incremental_mode = atoi(ns_eval_string("{INCREMENTAL_MODE}"));
  if (tp_rn <= incremental_mode )
  {
   tsdb_dc_ptr->incremental_freq = atoi(ns_eval_string("{INCREMENTAL_Freq}"));
   tsdb_dc_ptr->time_period = 0;
   tsdb_dc_ptr->start_ts = time(NULL) - tsdb_dc_ptr->incremental_freq;
   tsdb_dc_ptr->end_ts = 0;
   //tsdb_dc_ptr->end_ts = time(NULL);
  //printf("++++++++++++++++%ld++++++++++++++\n",tsdb_dc_ptr->start_ts);
  //printf("++++++++++++++++%ld++++++++++++++\n",tsdb_dc_ptr->end_ts);
  }
  else
  { 
   int max_time_period = atoi(ns_eval_string("{MAX_TIME_PERIOD}"));
   int min_time_period = atoi(ns_eval_string("{MIN_TIME_PERIOD}"));
   int tp_rn = ns_get_random_number_int(min_time_period,max_time_period);
   tsdb_dc_ptr->time_period = tp_rn;
   if(tsdb_dc_ptr->time_period == 0) /// Custom
    {
    // TODO - fill start and end ts - make it better

    int min_custom_hrs_back = atoi(ns_eval_string("{MIN_CUSTOM_HRS_BACK}"));  // Take from Scen (1, 2, ....)
    int max_custom_hrs_back = atoi(ns_eval_string("{MAX_CUSTOM_HRS_BACK}"));  // Take from Scen (1, 2, ....)
    tsdb_dc_ptr->start_cts =  ns_get_random_number_int(min_custom_hrs_back, max_custom_hrs_back);

    float custom_duration[] = {0.05,0.1,0.2,0.5,1,1.5,2,3,4,5,6,24};
    int max_custom_duration = atoi(ns_eval_string("{MAX_CUSTOM_DURATION}"));
    int min_custom_duration = atoi(ns_eval_string("{MIN_CUSTOM_DURATION}"));
    tsdb_dc_ptr->custom_duration = custom_duration[ns_get_random_number_int(min_custom_duration, max_custom_duration)]; // Take  from scen (values can  be .1, .2, ....1, 2, ...)

    tsdb_dc_ptr->start_ts = time(NULL) - (tsdb_dc_ptr->start_cts * 60 * 60) ;
    tsdb_dc_ptr->end_ts = tsdb_dc_ptr->start_ts + (tsdb_dc_ptr->custom_duration * 60 * 60);
    }
  }
}
char *get_mc_sc_range(int input)
{
  if(input == 0)
    return "0";
  else if(input == 1)
    return "1";
  else if(input < 11)
    return "2-10";
  else if(input < 101)
    return "11-100";
  else if(input < 201)
    return "101-200";
  else if(input < 301)
    return "201-300";
  else if(input < 401)
    return "301-400";
  else if(input < 501)
    return "401-500";
  else if(input < 601)
    return "501-600";
  else if(input < 701)
    return "601-700";
  else if(input < 801)
    return "701-800";
  else if(input < 901)
    return "801-900";
  else if(input < 1001)
    return "901-1K";
  else if(input < 2001)
    return "1001-2K";
  else if(input < 3001)
    return "2001-3K";
  else if(input < 4001)
    return "3001-4K";
  else if(input < 5001)
    return "4001-5K";
  else if(input < 6001)
    return "5001-6K";
  else if(input < 7001)
    return "6001-7K";
  else if(input < 8001)
    return "7001-8K";
  else if(input < 9001)
    return "8001-9K";
  else if(input < 10001)
    return "9001-10K";
  else if(input < 20001)
    return "10001-20K";
  else if(input < 30001)
    return "20001-30K";
  else if(input < 40001)
    return "30001-40K";
  else if(input < 50001)
    return "40001-50K";
  else if(input < 60001)
    return "50001-60K";
  else if(input < 64001)
    return "60001-64K";
  else
    return "64K+";
}

void get_set_of_nf_sf(int *count, char *buffer_freq)
{
  int write_freq = 0;
  char *freqVal[] = {"1s", "10s", "1m", "10m", "1hr", "4hr", "1day", "other"};

  for(int j=0; j<8; j++)
  {
    if(count[j] > 0)
    {
      if(write_freq !=0)
      {
        buffer_freq[write_freq]='-';
        write_freq++;
      }
      write_freq += sprintf(buffer_freq + write_freq,"%s%d",freqVal[j],count[j]);
    }
  }
}

char get_df_mode(int df)
{
  if(df == 0)
  {
    return 'N';
  }
  else if(df == 1)
  {
    return 'P';
  }
  else
  {
    return 'S';
  } 
}

#define TSDB_DC_TX_NAME "DataCall"
void tsdb_data_query_set_tx_name(TSDBDataCall *tsdb_dc_ptr ,int *tx_time)
{
  char ctp[8]; //Make custom TP
  int tsdb_tx_time;
  char nf_buffer[128] = "";
  char sf_buffer[128] = "";

  get_set_of_nf_sf(tsdb_dc_ptr->count_NF, nf_buffer);
  get_set_of_nf_sf(tsdb_dc_ptr->count_SF, sf_buffer);

  //Making custom TimePeriod in Format [TPC8h-1h]
  if(tsdb_dc_ptr->time_period == 0)
  {
    if( tsdb_dc_ptr->end_ts == 0)
    {
      if ( tsdb_dc_ptr->incremental_freq == 10) 
      sprintf(ctp, "TPI10s"); // currently we are  using only 1 min incremental call in custom time  
      else if ( tsdb_dc_ptr->incremental_freq == 60)
      sprintf(ctp, "TPI1m");
      else if ( tsdb_dc_ptr->incremental_freq == 600)
      sprintf(ctp, "TPI10m");
    }
    else
    { 
      sprintf(ctp, "TP%s%dh-%.2f", time_period[tsdb_dc_ptr->time_period],tsdb_dc_ptr->start_cts, tsdb_dc_ptr->custom_duration);
    }
  } 
 else
 { 
  sprintf(ctp, "TP%s", time_period[tsdb_dc_ptr->time_period]);
 }
  tsdb_dc_ptr->hierachy_levels = 0; // Change to 0 to minmize tx names

  char *tx_name_ptr = tsdb_dc_ptr->tx_name;
  tx_name_ptr += sprintf(tx_name_ptr, "DC%c_M%d-%s_%s_H%d_DF%c_MF%d-%d-%d", 
                                (tsdb_dc_ptr->call_mode == 0)? 'I': 'N',
                                tsdb_dc_ptr->subject_mode, get_mc_sc_range(tsdb_dc_ptr->req_num_metrics),ctp,
                                tsdb_dc_ptr->hierachy_levels, get_df_mode(tsdb_dc_ptr->metrics_data_mode), tsdb_dc_ptr->mt_filter_option, tsdb_dc_ptr->metric_filter_type, tsdb_dc_ptr->mt_op);

  if(tsdb_dc_ptr->rep_error_code == 0) // Success
  {
    if(tsdb_dc_ptr->rep_freq_count != 0) // Success
      tx_name_ptr += sprintf(tx_name_ptr, "_NF%s_SF%s_MC%s_SC%s_P%d-%d-%d", 
        nf_buffer, sf_buffer,
        get_mc_sc_range(tsdb_dc_ptr->rep_num_metrics), get_mc_sc_range(tsdb_dc_ptr->rep_num_sample),
        tsdb_dc_ptr->online_mode, tsdb_dc_ptr->uproll_mode, tsdb_dc_ptr->offline_file_count);
    else
      tx_name_ptr += sprintf(tx_name_ptr, "_NoMetricFound");

  } else {
    sprintf(tx_name_ptr, "_Error_%d", tsdb_dc_ptr->rep_error_code);

  }


  tsdb_tx_time = ns_get_transaction_time(TSDB_DC_TX_NAME);
  *tx_time = tsdb_tx_time;
  
  // fprintf(stderr, "tx_name = %s\n", tsdb_dc_ptr->tx_name);

  #ifdef TSDB_QUERY_LOGGING_L1
  fprintf(query_log_fp, "TX_Summary: tx_name = %s, tx_time = %d, tsdb_rt = %d, tx_time_diff = %d, cor_id = %lld\n",
                        tsdb_dc_ptr->tx_name, tsdb_tx_time, tsdb_dc_ptr->rep_tsdb_rt, (tsdb_tx_time - tsdb_dc_ptr->rep_tsdb_rt),
                        tsdb_dc_ptr->cor_id);
  #endif
}
/** This method tokanises the read_buf with token given & fill the tokens in fields,
 *  * if fields array size is less then numbet of tokens, then
 *  * remaining fields are skipped.
 *  * This function is also handle multiple delimiter
 *  eg
 *  read_buf = "Hello World, Let me live."
 *  token = " ," 
 *  Output:
 *      Hello
 *      World
 *      Let
 *      me
 *      live.
 *   */
int get_tokens_with_multi_delimiter(char *read_buf, char *fields[], char *token, int max_flds)
{
  int totalFlds = 0;
  char *ptr;
  char *token_ptr;
  char *rest;

  ptr = read_buf;
  while((token_ptr = strtok_r(ptr, token, &rest)) != NULL)
  {
    ptr = NULL;
    totalFlds++;
    if(totalFlds > max_flds)
    {
      //fprintf(stderr, "Total fields are more than max fields (%d), remaining fields are ignored\n", max_flds);
      totalFlds = max_flds;
      break;  /* break from while */
    }
    ptr = rest;
    fields[totalFlds - 1] = token_ptr;
  }
  return(totalFlds);
}   
