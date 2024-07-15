/*
 * TSDB messaging interface DS
 */
#ifndef TSDB_MSG_INTERFACE_H
#define TSDB_MSG_INTERFACE_H

#include <sys/types.h>
#include <stdint.h>
#include "tsdb_id.h"

// Opcodes
enum tsdb_opcode{
  TSDB_QUERY_REQ_TREE_INIT = 1,
  TSDB_QUERY_REQ_TREE_EXPAND,
  TSDB_QUERY_REQ_TREE_SEARCH,
  TSDB_QUERY_REQ_GROUP,
  TSDB_QUERY_REQ_GRAPH,
  TSDB_QUERY_REQ_METADATA_OPEN_MERGE,
  TSDB_QUERY_REQ_METADATA_OPEN_RELATED,
  TSDB_QUERY_REQ_METADATA_PATTERN_MATCH,
  TSDB_QUERY_REQ_HIERARCHICAL_LEVEL,
  TSDB_QUERY_REQ_DATA_BY_ID,
  TSDB_QUERY_REQ_DATA_BY_NAME,
  TOTAL_OPCODE
};

// Data filters
#define DF_AVG              0x0001
#define DF_MIN              0x0002
#define DF_MAX              0x0004
#define DF_COUNT            0x0008
#define DF_SUM_COUNT        0x0010
#define DF_SUM_SQUARE       0x0020
#define DF_DATA_SUMMARY     0x0040
#define DF_PERCENTILE       0x0080
#define DF_SLAB_COUNT       0x0100
#define DF_CATEGORY         0x0200
#define DF_CORRELATED       0x0400
#define DF_MT_FILTER        0x0800
#define DF_SAMPLE_FILTER    0x1000
#define DF_NORMAL_DATA      0x003F    // mask for normal data 

// Metric filter type
#define FLT_TYPE_AVG      0x01
#define FLT_TYPE_MIN      0x02
#define FLT_TYPE_MAX      0x04
#define FLT_TYPE_COUNT    0x08
#define FLT_TYPE_INC      0x80

// Metric filter operators
#define OP_EQ           1
#define OP_GRT          2
#define OP_GRT_EQ       3
#define OP_LESS         4
#define OP_LESS_EQ      5
#define OP_IN_BTWN      6
#define OP_TOP          7
#define OP_BOT          8

/**
 * TSDB error codes
 * Cannot start from 0, we are sending error code in data_freq->freq
 */
#define TSDB_SUCCESS                  0
#define TSDB_ERR                      0xFFFFFFFF // max uint32
#define TSDB_ERR_INV_GLB_MT_ID        0xFFFFFFFE
#define TSDB_ERR_INV_SUB_FMT          0xFFFFFFFD
#define TSDB_ERR_INV_MEA_FMT          0xFFFFFFFC
#define TSDB_ERR_SUB_NOT_PRESENT      0xFFFFFFFB
#define TSDB_ERR_MEA_NOT_PRESENT      0xFFFFFFFA
#define TSDB_ERR_INVALID_TS           0xFFFFFFF0

// Subject modes
#define S_MODE_SAME     0x01
#define S_MODE_ALL      0x02
#define S_MODE_PATTERN  0x04

// Data type sizes
#define LONG_SIZE 8
#define CHAR_SIZE 1

extern const uint8_t  tsdb_nodes;
extern const uint32_t qhead_rt;
extern const uint16_t tsdb_id;

// sz = 16
typedef struct
{
    uint32_t msg_size;      // Size of the message on the wire excluding 4 bytes of msg_size.
    uint16_t opcode;        // Determines the C struct for the rest of the message
    uint8_t  version;       // Version for message format.
    uint8_t  partition_info;// use for testing to get the info about where the datas are extracted from
    uint64_t cor_id;        // correlation id
} MsgHdr_t;

// sz = 8
typedef struct
{
    uint32_t qhead_rt;
    uint8_t  tsdb_nodes;
    uint8_t hole[3];
} RTHdr_t;

// sz = 24
typedef struct
{
    uint32_t start_ts;
    uint32_t end_ts;
    uint32_t freq;
    uint32_t tr_num;
    uint16_t data_filter;
    uint16_t mt_count;
    uint16_t mt_offset;
    uint8_t  preset;
    uint8_t  hole[1];
} DataOpSpec_t;

// sz = 24
typedef struct
{
    uint8_t mt_filter_type;
    uint8_t mt_op;
    uint8_t hole[6];
    double  value1;
    double  value2;
} MetricFilterSpec_t, FilterSpec_t;

// sz = 12
typedef struct
{
    uint32_t start_ts;
    uint32_t freq;
    uint16_t mt_count;
    uint16_t sample_count;
} DataFreqSpec_t;

// sz = 56
typedef struct
{
    double min;
    double max;
    double avg;
    double count;
    double std_dev;
    double last_sample;
    double diff;
    double sum;
} DataSummary_t;


// sz = 52
typedef struct
{
    MsgHdr_t        msg_hdr;
    DataOpSpec_t    op_spec;
    uint8_t         var_data[];
} TSDB_Req_Data_By_Id_t, TSDB_Req_Data_By_Name_t;

// sz = 24
typedef struct
{
    MsgHdr_t    msg_hdr;
    RTHdr_t     rt_hdr;
    uint8_t     var_data[];
} TSDB_Resp_Data_t;

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
uint32_t start_time;
uint32_t end_time;
uint32_t freq;
uint32_t tr_num;
uint8_t app_id_len;
uint8_t client_id_len;
uint8_t preset;
uint8_t filter;
uint16_t num_metric_set;
uint8_t reserved[3];
uint8_t var_data[];
} TSDB_Req_Metadata_Open_Related_t;

/*typedef struct 
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
    uint16_t   num_metric_set;
    uint8_t   var_data[];
} TSDB_Req_Metadata_Open_Related_t;
*/

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
    uint16_t  num_groups;
    uint8_t  reserved[6];
    uint8_t  var_data[];
} TSDB_Resp_Metadata_t;

typedef struct
{   
    MsgHdr_t msg_hdr;
    uint32_t start_time;
    uint32_t end_time; 
    uint32_t tr_num;
    g_metric_grp_id_t id_mg;
    uint8_t client_id_len;
    uint8_t app_id_len;
    uint16_t num_members;
    uint8_t  num_levels;
    uint8_t  preset;
    uint8_t  reserved[2];
    uint8_t  var_data[];
} TSDB_Req_Hierarchical_Level_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    RTHdr_t rt_hdr;
    uint16_t mem_count;
    uint8_t  reserved[6];
    uint8_t  var_data[];
} TSDB_Resp_Hierarchical_Level_t;

typedef struct
{
    MsgHdr_t  msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  tr_num;
    uint8_t   client_id_len;
    uint8_t   app_id_len;
    uint8_t   preset;
    uint8_t   reserved[1];
    uint8_t   var_data[];
} TSDB_Req_Tree_Init_t;

typedef struct
{
    MsgHdr_t  msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  tr_num;
    uint8_t   app_id_len;
    uint8_t   client_id_len;
    uint8_t   preset;
    uint8_t   expand_level;
    uint8_t   var_data[];
} TSDB_Req_Expand_Tree_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    uint32_t start_time;
    uint32_t end_time;
    uint32_t tr_num;
    uint8_t  client_id_len;
    uint8_t  app_id_len;
    uint8_t  preset;
    uint8_t  search_level;
    uint16_t node_limit;
    uint8_t  search_mode;
    uint8_t  reserved[5];
    uint8_t  var_data[];
} TSDB_Req_Search_Tree_t;

typedef struct
{
  uint8_t id_type;
  uint64_t gdf_id;
  uint8_t name_len;
  uint8_t flags;
  uint16_t num_child;
  uint8_t var_data[];
} TreeNodeSpec_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    RTHdr_t rt_hdr;
    uint16_t num_members;
    uint8_t  flags;
    uint8_t reserved[5];
    uint8_t  var_data[];
} TSDB_Resp_Tree_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t tr_num;
    uint32_t id_mg;
    uint8_t  app_id_len;
    uint8_t  client_id_len;
    uint8_t  preset;
    uint8_t  reserved[1];
    uint8_t  var_data[];
} TSDB_Req_Graph_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    RTHdr_t rt_hdr;
    uint16_t count;
    uint8_t  reserved[6];
    uint8_t  var_data[];
} TSDB_Resp_Group_t, TSDB_Resp_Graph_t;

typedef struct
{
  MsgHdr_t msg_hdr;
  RTHdr_t rt_hdr;
  uint32_t error_code;
  uint16_t http_code;
  uint8_t  reserved[2];
  uint8_t  var_data[];
} TSDB_ErrorMessage_t;

#endif
