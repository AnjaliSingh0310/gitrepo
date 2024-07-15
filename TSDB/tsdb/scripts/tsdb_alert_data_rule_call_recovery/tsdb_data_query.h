#define TSDB_ALERT_RECOVERY     35

#define SUBJECT_MODE_EXACT    0
#define SUBJECT_MODE_ALL      1
#define SUBJECT_MODE_PATTERN  2

#define TSDB_QUERY_LOGGING  1
#define TSDB_QUERY_LOGGING_L1  1
#include "tsdb_msg_interface.h" 

/* Header flags */
#define ONLINE_PRESENT 0X01
#define UNROLL_PRESENT 0X02
#define OFFLINE_PRESENT 0X04
#define TSDB_RESPONSE_COMPRESSED 0X08

#define REQ_PARSE(dest, src, len, total_sz) \
{ \
memcpy(dest, src, len); \
(dest) += len; \
total_sz += len; \
}

static time_t s_time;
static time_t e_time;

#define TIME_STAMP(s_time, e_time) {\
s_time = time(NULL) - (mins_back * 60); \
if(mins_duration == 0) \
e_time = 0; \
else \
e_time = s_time + mins_duration * 60; \
}

typedef struct
{
  MsgHdr_t  msg_hdr;
  uint32_t  number_of_rules;
  uint8_t   flags;
  uint8_t   reserved[3];
  uint8_t  var_data[];
}TSDB_Init_Event_Req_Alert_Data_t;

typedef struct
{
MsgHdr_t msg_hdr;
uint8_t operation;
uint8_t   flags;
uint8_t reserved[2];
uint32_t number_of_rules;
uint8_t var_data[];
}TSDB_Req_Alert_Rule_config_t;

typedef struct
{
MsgHdr_t msg_hdr;
RTHdr_t rt_hdr;
uint32_t msg_len;
uint32_t detail_msg_len;
uint8_t var_data[];
}TSDB_Resp_Alert_Config_t;

typedef struct 
{
  // Request fields
  char subject_mode;  // 0 - Exact, 1 - All, 2 - Pattern
  int time_period;  // Time period array index
  long start_ts;
  long end_ts;
  unsigned short req_num_metrics; // Number of metrics in the request
  char hierachy_levels; // Number of components in the subject hierarchy (1, 2, 3, ...)
  unsigned short data_filter; // Data filters
  int req_freq;
  int var_data;
  int test_run;
  int incremental_freq;
  // Response fields
  unsigned int rep_error_code; // 0 - for Suceces else set from error response
  unsigned char rep_freq_count; // Numnber of frequency returned (1, 2, ...,7) (Can be also 0?)
  int rep_num_metrics; // Number of metric returned (sum of all freq)

  int rep_num_sample; // Number of sample returned (sum of all freq)
  int rep_tsdb_rt;    // Response Time in ms from tsdb
  int rep_tsdb_rt_ms;

  char online_mode;
  char uproll_mode;
  char partition_mode;
  int offline_file_count;
  int  sub_mem_count;
  int  measure_mem_count;
  int msg_len;
  char buffer[1024 * 64];
  
  int alert_schedule_type;
  int s_time;  
  int e_time;
  int mins_duration;

  char uri[64 + 1];
  char nd_ip[64 + 1];
  char nd_port[8 + 1];
  int test_id;
  int user_id;
  int nvm_id;
  char *ns_wdir;
  char tx_name[128];

  FILE *query_log_fp;
  long cor_id;

  char start_cts;
  double custom_duration;  // Duration in  hours (.1 to 1/10 of hour)
  int mt_filter_option; //0 -> Nofilter ,1 -> top N , 2 -> Buttom N 
  int metric_filter_type;
  int filter_num;   
  int mt_op;
  int count_SF[8];    //counter for select freq
  int count_NF[8];    //counter for select freq
  char call_mode;     //Flag for DCN/DCI, 0 - DCI, 1 - DCN
  char *monitor_group;
  
  DataFreqSpec_t rep_freq_spec;
  DataSummary_t rep_data_summary;
  char err_msg[64+1]; // Buffer for error message in response 
  char detail_err_msg[128+1];  // Buffer for detail error message in response

  int metrics_data_mode;  //Flag for persentile or slab
} TSDBDataCall;

#define htond(dest, val) \
{ \
  double d_val_ = (val); /* to handle constants */  \
  long *ll_ = (long *)&(d_val_); \
  long ll2_ = htobe64(*ll_); \
  double *d_ = (double *)&ll2_; \
  (dest) = *d_; \
}


#define ntohd(dest, val) \
{ \
  double d_val_ = (val); /* to handle constants */  \
  long *ll_ = (long *)&(d_val_); \
  long ll2_ = be64toh(*ll_); \
  double *d_ = (double *)&ll2_; \
  (dest) = *d_; \
}

extern FILE *query_log_fp;
extern char *time_period[];
