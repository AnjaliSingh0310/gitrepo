#define TSDB_QUERY_REQ_ALERT_RULE_CONFIG        32

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
  s_time = time(NULL); \
  e_time = s_time + 5 * 60; \
}

typedef struct
{
	int mon;
	int week;
	int day;
	time_t s_time;
        time_t e_time;
	int utc_offset;
        int dayst;
}Schedule_type_t;

Schedule_type_t schedule_type_arr[9] =
{
/* Mon, Week, Day, -, Time window, UTC/CDT/IST[19800,-18000,0], ("5:30" ex:5*3600+30*60) */
{8, 5, 28, 27600, 300, 19800, 23400},              // For EVERY_DAY CDT 9:00 AM to 9:10 AM (day)
{8, 5, 2, 20200, 300, 19800, 68400},            // For WEEKDAY_OF_EVERY_WEEK  - WED of every week (day)
{8, 5, 29, 20600, 300, 19800, 43200},              // DAY_OF_MONTH  - 02 (date)
{8, 1, 1, 21100, 300, -18000, 18600},              // WEEKDAY_OF_MONTH  -  WED of 1st week (day)
{8, 5, 30, 21500, 600, 19800, 45000},              // LAST_DAY_OF_EVERY_MONTH  - (it will take the last date)  09:20 - 09:25
{8, 5, 29, 21900, 300, 19800, 45900},              // DAY_OF_A_YEAR  -  02/05 (2nd june) date
{8, 5, 3, 31700, 300, 19800, 49500},              // WEEKDAY_OF_YEAR  - (Day) WED of 1st week of june month
{6, 5, 30, 31700, 300, 1900, 24000},              // WEEKDAY_OF_YEAR  -  WED of 1st week of june month
{8, 5, 29, 1632865926, 1632866106, 0, 50400},     // Custom Event day  - (CDT Timestamp)
{6, 5, 30, 31700, 300, -18600, 30600}              // WEEKDAY_OF_YEAR  -  WED of 1st week of june month
};

typedef struct
{
uint8_t metric_data;
uint8_t operators;
double fthreshold;
double sthreshold;
double r_fthreshold;
double r_sthreshold;
uint8_t window_type;
uint8_t pct_type;
double sample_pct;
uint16_t window;
uint8_t window_unit;
}Condition_type_th_t;

typedef struct
{
uint8_t metric_data;
uint8_t operators;
uint8_t change;
double fthreshold;
double sthreshold;
double r_fthreshold;
double r_sthreshold;
uint8_t window_type;
uint8_t pct_type;
double sample_pct;
uint16_t window;
uint8_t window_unit;
uint16_t past_window;
uint8_t past_window_unit;
}Condition_type_change_t;

typedef struct
{
uint8_t metric_data;
uint8_t operators;
uint16_t window;
uint8_t window_unit;
uint8_t window_type;
uint8_t pct_type;
double sample_pct;
uint8_t anomaly_algo_type;
double deviations;
}Condition_type_anomaly_t;


typedef struct
{
  uint8_t  metric_data;
  uint8_t pct_type;
  double sample_pct;
  uint16_t  window;
  uint8_t window_unit;
  uint8_t window_type;
  uint8_t  algo_type;
  double  tolerance;
}Condition_type_outlier_t;


typedef struct
{
uint8_t metric_data;
uint8_t operators;
uint16_t window;
uint8_t window_unit;
uint8_t window_type;
uint16_t trend_window;
uint8_t trend_window_unit;
uint8_t pct_type;
double sample_pct;
uint8_t model;
uint8_t forecast_type;
double fthreshold;
double sthreshold;
double r_fthreshold;
double r_sthreshold;
}Condition_type_forec_t;

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
  char tx_name[256];

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
