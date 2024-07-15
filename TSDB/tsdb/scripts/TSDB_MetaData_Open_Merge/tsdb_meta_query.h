#ifndef TSDB_META_QUERY_H
#define TSDB_META_QUERY_H

#define ID_TYPE_METRIC_GROUP_TYPE  0
#define ID_TYPE_METRIC_GROUP       1
#define ID_TYPE_SUBJECT_VALUE      2
#define ID_TYPE_METRIC             3
#define ID_TYPE_SUBJECT_TYPE       4
#define ID_TYPE_LOCAL_MG           5
#define ID_TYPE_SUBJECT            6
#define ID_TYPE_MSG                7
#define ID_TYPE_ATTRIBUTE          8


#define TSDB_QUERY_REQ_TREE_INIT                                     1
#define TSDB_QUERY_REQ_TREE_EXPAND                                   2
#define TSDB_QUERY_REQ_TREE_SEARCH                                   3
#define TSDB_QUERY_REQ_METADATA_OPEN_MERGE                           6
#define TSDB_QUERY_REQ_METADATA_OPEN_RELATED                         7
#define TSDB_QUERY_REQ_METADATA_PATTERN_MATCH                        8
#define TSDB_QUERY_ERROR                                            999
//#define TSDB_QUERY_LOGGING  1
//#define TSDB_QUERY_LOGGING_L1  1
#define TSDB_MD_OM_TX_NAME "Meta_Data_Open_Merge_Call"
#define TSDB_MD_OR_TX_NAME "Meta_Data_Open_Related_Call"
#define TSDB_MD_PM_TX_NAME "Meta_Data_Pattern_Match_Call"

// mode flags used in request
#define S_MODE_SAME     0x01
#define S_MODE_ALL      0x02
#define S_MODE_PATTERN  0x04

// Metric filter type
#define FLT_TYPE_AVG      0x01
#define FLT_TYPE_MIN      0x02
#define FLT_TYPE_MAX      0x04
#define FLT_TYPE_COUNT    0x08
#define FLT_TYPE_INC      0x80

#define DF_MT_FILTER        0x0800

// used while filling request
#define SUBJECT 0
#define MEASURE 1

//metric id used in response parsing
typedef struct
{
 char type; //For Local Metric - 3
 char pad1; //For alignment
 short local_tree_idx;  //1a(1)
 union{
   int tt_idx; // 1a(2) Table of table index - table index for type node
   int tot_idx; // 1a(2) Table of table index - table index for type node
 };
 int table_idx; //1a(3)
 int subject_idx; //1b
 short g_mg_idx; //2a
 short mg_idx; //2b
 short mt_idx; //3a
 short pad2; //For alignment
} metric_id_t;


typedef struct
{
  char type; // For subject type node - 4, value node - 2
  char pad1; //Alignment
  short local_tree_idx; // 1a(1)
  union{
    int tt_idx; // 1a(2) Table of table index - table index for type node
    int tot_idx; // 1a(2) Table of table index - table index for type node
  };
  int table_idx; // 1a(3) - Index for type node
  int subject_idx; //1b - In case of type node, this will be same as table_idx
  short g_mg_idx; //2a
  short pad2; //Alignment
}subject_id_t;

typedef struct
{
    uint32_t msg_size;      // Size of the message on the wire excluding 4 bytes of msg_size.
    uint16_t opcode;        // Determines the C struct for the rest of the message
    uint8_t  version;       // Version for message format.
    uint8_t  flags;
    uint64_t cor_id;        // correlation id to distinguish between requests
    uint16_t off_fc;        // offline file count
    uint8_t  reserved[10];  // for future use
    uint32_t tx_name_offset; //Offset of tx name in the response, tx name will be at the end as it is generated after complete resp is made
} MsgHdr_t;

//Following is internal to TSDB (Not shared with external components)
//Data structure - for local mg
typedef struct
{
 char type; //For Local Metric Group - 5
 char pad1; //For alignment
 short local_tree_idx;  //1a(1)
 int tt_idx; //1a(2)
 int table_idx; //1a(3)
 int subject_idx; //1b
 short g_mg_idx; //2a
 short mg_idx; //2b
} mg_id_t;

// sz = 8
typedef struct
{
    uint32_t qhead_rt;
    uint8_t  tsdb_nodes;
    uint8_t hole[3];
} RTHdr_t;


typedef struct 
{
  // Request fields
  char subject_mode;  // 0 - Exact, 1 - All, 2 - Pattern
  int req_search_mode; // 1 = exact , 2 = contains , 3 = regexi
  int req_search_level; //0,1,2,3
  int time_period;  // Time period array index
  long start_ts;
  long end_ts;
  int level;  //0= subject and 1 = metric 
  int sub_mem_count;
  int measure_mem_count;
  char hierachy_levels;
  int req_freq;
  char mt_filter_option;
  uint8_t metric_filter_type;
  unsigned short data_filter; // Data filters
  char mt_op;
  int count_SF[8];
  int count_NF[8];
  unsigned short req_num_metrics; // Number of metrics in the request
  char call_mode;
  int metrics_data_mode;
  //char rep_hierachy_levels; // Number of components in the subject hierarchy (1, 2, 3, ...)
  //unsigned short rep_num_mg; // inumber of metric group
  //unsigned short rep_num_graph;  // number of graphs 
  int test_run;

  // Response fields
  unsigned int rep_error_code; // 0 - for Suceces else set from error response
  unsigned char rep_freq_count; // Numnber of frequency returned (1, 2, ...,7) (Can be also 0?)
  int rep_num_members; // Number of members returned from TSDB
  int rep_match_count;   // flag = 0 (match not found ) flag =1 (match found)
  int rep_num_sample; // Number of sample returned (sum of all freq)
  int rep_tsdb_rt;    // Response Time in ms from tsdb
  unsigned short rep_num_metrics; 
  char online_mode;
  char uproll_mode;
  char partition_mode;
  int offline_file_count;
  int msg_len;
  char buffer[1024 * 64];
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
  double custom_duration;
  int type_rn;
  uint16_t num_children;
  char type_value [128];
  uint8_t *id_type;
  uint8_t req_sub_id_type;
  uint8_t req_mg_id_type;
  subject_id_t *resp_attribute_subject_id;
  subject_id_t *resp_msg_subject_id;
  subject_id_t *resp_subject_id;
  subject_id_t *resp_subject_value_id;
  mg_id_t      *resp_mg_id;
  metric_id_t *resp_metric_id;
} TSDBMetaCall;

typedef struct
{
  MsgHdr_t msg_hdr;
  RTHdr_t rt_hdr;
  uint32_t error_code;
  uint16_t http_code;
  uint8_t  reserved[2];
  uint8_t  var_data[];
} TSDB_ErrorMessage_t;
typedef struct
{   
    MsgHdr_t msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  freq;
    uint32_t  tr_num;
    uint8_t   app_id_len;
    uint8_t   client_id_len;
    uint8_t   preset;
    uint8_t   sub_member_count;
    uint8_t   measure_member_count;
    uint8_t   filter;
    uint8_t   exclude_overall;
    uint8_t   reserved[1];
    uint8_t   var_data[];
} TSDB_Req_Metadata_Open_Merge_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  freq;
    uint32_t  tr_num;
    uint8_t   app_id_len;
    uint8_t   client_id_len;
    uint8_t   preset;
    uint8_t   sub_member_count;
    uint8_t   measure_member_count;
    uint8_t   filter;
    uint8_t   exclude_overall;
    uint8_t   num_metric_set;
    uint8_t   var_data[];
} TSDB_Req_Metadata_Open_Related_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  freq;
    uint32_t  tr_num;
    uint8_t   app_id_len;
    uint8_t   client_id_len;
    uint8_t   preset;
    uint8_t   sub_member_count;
    uint8_t   measure_member_count;
    uint8_t   filter;
    uint8_t   exclude_overall;
    uint8_t   num_metric_set;
    uint8_t   p_threshold;
    uint8_t   inverse_match;
    uint8_t   reserved[2];
    uint8_t   var_data[];
} TSDB_Req_Metadata_Pattern_Match_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    RTHdr_t  rt_hdr;
    uint16_t mt_count;    
    uint8_t  reserved[6];
    uint8_t  var_data[];
} TSDB_Resp_Metadata_t;

typedef struct
{
    uint8_t mt_filter_type;
    uint8_t mt_op;
    uint8_t hole[6];
    double  value1;
    double  value2;
} MetricFilterSpec_t, FilterSpec_t;

typedef struct
{
    uint32_t start_ts;
    uint32_t freq;
    uint16_t mt_count;
    uint16_t sample_count;
} DataFreqSpec_t;

FILE *query_log_fp;

extern char metric_value;
extern char *time_period[];
/*extern int get_tokens_with_multi_delimiter(char *read_buf, char *fields[], char *token, int max_flds);
extern int create_req_for_init_call(TSDBDataCall *tsdb_dc_ptr);
extern void tsdb_query_by_tree_init(TSDBDataCall *tsdb_dc_ptr);
extern void tsdb_query_by_tree_set_req_fields(TSDBDataCall *tsdb_dc_ptr);
extern void tsdb_tree_expand_query_set_tx_name(TSDBDataCall *tsdb_dc_ptr ,int *tx_time);
extern int create_req_for_expand_call(TSDBDataCall *tsdb_dc_ptr, int i);
extern void tsdb_tree_init_query_set_tx_name(TSDBDataCall *tsdb_dc_ptr ,int *tx_time);
extern void tsdb_parse_response(void  *resp_buffer, int msg_size, TSDBDataCall *tsdb_dc_ptr);*/
#endif
