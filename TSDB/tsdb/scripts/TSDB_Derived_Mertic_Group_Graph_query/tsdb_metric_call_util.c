#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ns_string.h"
//#include "tsdb_metric_query.h"

#include "tsdb_req_resp.c"
//#include "tsdb_msg_interface.h"


char *time_period[] = {"C", "L10m", "L30m", "L1h", "L2h", "L4h", "L6h", "L8h", "L12h", "L24h", "today", "yday", "L7d", "L30d", "L90d", "LThisw", "L1w", "L2w", "L3w", "L4w", "Thism", "L1m", "L2m", "L3m", "L6m", "Thisyr", "L1yr"};  

//int frequency[]={1, 10, 60};

FILE *query_log_fp = NULL;

static time_t test_start_ts;

void tsdb_query_by_metric_init(TSDBDataCall *tsdb_dc_ptr)
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

void tsdb_query_by_metric_set_req_fields(TSDBDataCall *tsdb_dc_ptr)
{  
  
  tsdb_dc_ptr->req_freq = 10;  // 0 means request frequency will be ignored by TSDB
  tsdb_dc_ptr->rep_num_metrics = 0;
  tsdb_dc_ptr->rep_num_sample = 0;
  tsdb_dc_ptr->rep_error_code = 0;
  tsdb_dc_ptr->rep_freq_count = 0;
  int max_time_period = atoi(ns_eval_string("{MAX_TIME_PERIOD}"));
  int tp_rn = 0; // ns_get_random_number_int(1, max_time_period);
  tsdb_dc_ptr->time_period = tp_rn;

  if(tsdb_dc_ptr->time_period == 0) /// Custom
  {
    // TODO - fill start and end ts - make it better

    int min_custom_hrs_back = atoi(ns_eval_string("{MIN_CUSTOM_HRS_BACK}"));  // Take from Scen (1, 2, ....)
    int max_custom_hrs_back = atoi(ns_eval_string("{MAX_CUSTOM_HRS_BACK}"));  // Take from Scen (1, 2, ....)
    tsdb_dc_ptr->start_cts = ns_get_random_number_int(min_custom_hrs_back, max_custom_hrs_back);

    float custom_duration[] = {0.08,0.1,0.2,0.5,1,2,3,4,5,6};
    int max_custom_duration = atoi(ns_eval_string("{CUSTOM_DURATION}"));
    tsdb_dc_ptr->custom_duration = custom_duration[ns_get_random_number_int(1, max_custom_duration)]; // Take  from scen (values can  be .1, .2, ....1, 2, ...)

    tsdb_dc_ptr->start_ts = time(NULL) - (tsdb_dc_ptr->start_cts * 60 * 60) ;
    tsdb_dc_ptr->end_ts = tsdb_dc_ptr->start_ts + (tsdb_dc_ptr->custom_duration * 60 * 60);
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

void tsdb_metric_group_query_set_tx_name(TSDBDataCall *tsdb_dc_ptr ,int *tx_time)
{
  char ctp[8]; //Make custom TP
  int tsdb_tx_time;

  //Making custom TimePeriod in Format [TPC8h-1h]
  if(tsdb_dc_ptr->time_period == 0)
    sprintf(ctp, "%s%dh-%.2f", time_period[tsdb_dc_ptr->time_period],
                 tsdb_dc_ptr->start_cts, tsdb_dc_ptr->custom_duration);

  char *tx_name_ptr = tsdb_dc_ptr->tx_name;
  tx_name_ptr += sprintf(tx_name_ptr, "Derived_Metric_Group_Call_TP%s_T%d",                          
                                (tsdb_dc_ptr->time_period == 0)? ctp: time_period[tsdb_dc_ptr->time_period],
                                tsdb_dc_ptr->type_rn);

  if(tsdb_dc_ptr->rep_error_code == 0) // Success
  {
      tx_name_ptr += sprintf(tx_name_ptr, "_H%d_MG%d", tsdb_dc_ptr->rep_hierachy_levels, tsdb_dc_ptr->rep_num_mg);
  } else {
    sprintf(tx_name_ptr, "_Error_%d", tsdb_dc_ptr->rep_error_code);

  }
  tsdb_tx_time = ns_get_transaction_time(TSDB_MGC_TX_NAME);
  *tx_time = tsdb_tx_time;
  
  #ifdef TSDB_QUERY_LOGGING_L1
  fprintf(query_log_fp, "TX_Summary: tx_name = %s, tx_time = %d, tsdb_rt = %d, tx_time_diff = %d\n",
                        tsdb_dc_ptr->tx_name, tsdb_tx_time, tsdb_dc_ptr->rep_tsdb_rt, (tsdb_tx_time - tsdb_dc_ptr->rep_tsdb_rt));
  #endif
}
void tsdb_metric_query_set_tx_name(TSDBDataCall *tsdb_dc_ptr ,int *tx_time)
{
  char ctp[8]; //Make custom TP
  int tsdb_tx_time;
  
  //Making custom TimePeriod in Format [TPC8h-1h]
  if(tsdb_dc_ptr->time_period == 0)
    sprintf(ctp, "%s%dh-%.2f", time_period[tsdb_dc_ptr->time_period],
                 tsdb_dc_ptr->start_cts, tsdb_dc_ptr->custom_duration);
  
  char *tx_name_ptr = tsdb_dc_ptr->tx_name;
  tx_name_ptr += sprintf(tx_name_ptr, "Derived_Metric_Graph_Call_TP%s_T%d",                          
                                (tsdb_dc_ptr->time_period == 0)? ctp: time_period[tsdb_dc_ptr->time_period],
                                tsdb_dc_ptr->type_rn);
  
  if(tsdb_dc_ptr->rep_error_code == 0) // Success
  {   
      tx_name_ptr += sprintf(tx_name_ptr, "_H%d_MGrp%d", tsdb_dc_ptr->rep_hierachy_levels, tsdb_dc_ptr->rep_num_graph);
  } else {
    sprintf(tx_name_ptr, "_Error_%d", tsdb_dc_ptr->rep_error_code);
  
  }
  tsdb_tx_time = ns_get_transaction_time(TSDB_MC_TX_NAME);
  *tx_time = tsdb_tx_time;
  
  #ifdef TSDB_QUERY_LOGGING_L1
  fprintf(query_log_fp, "TX_Summary: tx_name = %s, tx_time = %d, tsdb_rt = %d, tx_time_diff = %d\n",
                        tsdb_dc_ptr->tx_name, tsdb_tx_time, tsdb_dc_ptr->rep_tsdb_rt, (tsdb_tx_time - tsdb_dc_ptr->rep_tsdb_rt));
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
