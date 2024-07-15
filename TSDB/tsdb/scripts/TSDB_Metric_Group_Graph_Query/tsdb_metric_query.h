
//#define SUBJECT_MODE_EXACT    0
//#define SUBJECT_MODE_ALL      1
//#define SUBJECT_MODE_PATTERN  2
#define TSDB_QUERY_REQ_GROUP                                         4
#define TSDB_QUERY_REQ_GRAPH                                         5
#define TSDB_QUERY_REQ_GRAPH_V2                                      23
#define TSDB_QUERY_ERROR                                            999
#define TSDB_QUERY_LOGGING  1
#define TSDB_QUERY_LOGGING_L1  1
#define TSDB_MGC_TX_NAME "Metric_Group_Call"
#define TSDB_MC_TX_NAME "Metric_Graph_Call"
//#include "tsdb_msg_interface.h" 

typedef struct
{
  char type;  // For global metric Group - 1
  char pad1; //Alignment
  short g_mg_idx; //2a
} g_metric_grp_id_t;

typedef struct
{
  uint32_t msg_size; // Size of the message on the wire excluding 4 bytes of msg_size.
  uint16_t opcode; // Determines the C struct for the rest of the message
  uint8_t version; // Version for message format.
  uint8_t flags;
  uint64_t cor_id; // correlation id to distinguish between requests
  uint16_t off_fc; // offline file count
  uint8_t reserved[10]; // for future use
  uint32_t tx_name_offset; //Offset of tx name in the response, tx name will be at the end as it is generated after complete resp is made
} MsgHdr_t;

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
  int time_period;  // Time period array index
  long start_ts;
  long end_ts;
  unsigned short req_num_metrics; // Number of metrics in the request
  char rep_hierachy_levels; // Number of components in the subject hierarchy (1, 2, 3, ...)
  unsigned short rep_num_mg; // inumber of metric group
  unsigned short rep_num_graph;  // number of graphs 
  int req_freq;
  int test_run;

  // Response fields
  int rep_error_code; // 0 - for Suceces else set from error response
  unsigned char rep_freq_count; // Numnber of frequency returned (1, 2, ...,7) (Can be also 0?)
  int rep_num_metrics; // Number of metric returned (sum of all freq)

  int rep_num_sample; // Number of sample returned (sum of all freq)
  int rep_tsdb_rt;    // Response Time in ms from tsdb

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
  char tx_name[1024];
  int tx_len;

  FILE *query_log_fp;
  long cor_id;

  char start_cts;
  double custom_duration;  // Duration in  hours (.1 to 1/10 of hour)
  int mt_filter_option; //0 -> Nofilter ,1 -> top N , 2 -> Buttom N 
  int metric_filter_type;
  int filter_num;   
  int count_SF[8];    //counter for select freq
  int count_NF[8];    //counter for select freq
  char call_mode;     //Flag for DCN/DCI, 0 - DCI, 1 - DCN
  char *monitor_group;
  char type[64]; 
  int type_rn;
  char detail_err_msg[128+1];
  char err_msg[64+1];
  //DataFreqSpec_t rep_freq_spec;
  //DataSummary_t rep_data_summary;
  g_metric_grp_id_t *mg_id;
  int metrics_data_mode;  //Flag for persentile or slab
} TSDBDataCall;
 
typedef struct
{
	MsgHdr_t msg_hdr;
	uint32_t start_time;
	uint32_t end_time;
	uint32_t tr_num;
	uint8_t app_id_len;
	uint8_t client_id_len;
	uint8_t preset;
	uint8_t reserved[7];
	uint16_t num_groups;
	uint8_t var_data[];
} TSDB_Req_Graph_V2_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t tr_num;
    uint8_t  app_id_len;
    uint8_t  client_id_len;
    uint8_t  num_members;
    uint8_t  preset;
    uint8_t  var_data[];
} TSDB_Req_Group_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    RTHdr_t rt_hdr;
    uint16_t count;
    uint8_t  reserved[6];
    uint8_t  var_data[];
} TSDB_Resp_Group_t, TSDB_Resp_Graph_V2_t;

typedef struct
{
  MsgHdr_t msg_hdr;
  RTHdr_t rt_hdr;
  uint32_t error_code;
  uint16_t http_code;
  uint8_t  reserved[2];
  uint8_t  var_data[];
} TSDB_ErrorMessage_t;

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
extern int get_tokens_with_multi_delimiter(char *read_buf, char *fields[], char *token, int max_flds);
