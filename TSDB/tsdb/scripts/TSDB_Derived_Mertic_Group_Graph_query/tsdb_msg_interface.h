/*
 * TSDB messaging interface DS
 */
#ifndef TSDB_MSG_INTERFACE_H
#define TSDB_MSG_INTERFACE_H

#include <sys/types.h>
#include <stdint.h>
#include "tsdb_id.h"
// Opcodes
#define TSDB_QUERY_REQ_TREE_INIT                                     1
#define TSDB_QUERY_REQ_TREE_EXPAND                                   2
#define TSDB_QUERY_REQ_TREE_SEARCH                                   3
#define TSDB_QUERY_REQ_GROUP                                         4
#define TSDB_QUERY_REQ_GRAPH                                         5
#define TSDB_QUERY_REQ_METADATA_OPEN_MERGE                           6
#define TSDB_QUERY_REQ_METADATA_OPEN_RELATED                         7
#define TSDB_QUERY_REQ_METADATA_PATTERN_MATCH                        8
#define TSDB_QUERY_REQ_HIERARCHICAL_LEVEL                            9
#define TSDB_QUERY_REQ_DATA_BY_ID                                   10
#define TSDB_QUERY_REQ_DATA_BY_NAME                                 11
#define TSDB_QUERY_ERROR                                            999

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
    uint32_t tr_num;
    uint32_t app_id;
    uint32_t client_id;
    uint32_t group_id;
    uint8_t  num_members;
    uint8_t  reserved[7];
    uint8_t  var_data[];
} TSDB_Req_Group_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  freq;
    uint32_t  tr_num;
    uint32_t  app_id;
    uint32_t  client_id;
    uint8_t   preset;
    uint8_t   sub_member_count;
    uint8_t   measure_member_count;
    uint8_t   filter;
    uint8_t   exclude_overall;
    uint8_t   reserved[3];
    uint8_t   var_data[];
} TSDB_Req_Metadata_Open_Merge_t;

typedef struct 
{
    MsgHdr_t msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  freq;
    uint32_t  tr_num;
    uint32_t  app_id;
    uint32_t  client_id;
    uint8_t   preset;
    uint8_t   sub_member_count;
    uint8_t   measure_member_count;
    uint8_t   filter;
    uint8_t   exclude_overall;
    uint8_t   num_metric_set;
    uint8_t   reserved[2];
    uint8_t   var_data[];
} TSDB_Req_Metadata_Open_Related_t;

typedef struct 
{
    MsgHdr_t msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  freq;
    uint32_t  tr_num;
    uint32_t  app_id;
    uint32_t  client_id;
    uint8_t   preset;
    uint8_t   sub_member_count;
    uint8_t   measure_member_count;
    uint8_t   filter;
    uint8_t   exclude_overall;
    uint8_t   num_metric_set;
    uint8_t   p_threshold;
    uint8_t   inverse_match;
    uint8_t   var_data[];
} TSDB_Req_Metadata_Pattern_Match_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    RTHdr_t  rt_hdr;
    uint8_t  num_groups;
    uint8_t  reserved[7];
    uint8_t  var_data[];
} TSDB_Resp_Metadata_t;

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
    uint32_t  app_id;
    uint32_t  client_id;
    uint8_t   grp_pos;
    uint8_t   preset;
    uint8_t   reserved[2];
} TSDB_Req_Tree_Init_t;

typedef struct
{
    MsgHdr_t  msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  tr_num; 
    uint32_t  app_id;
    uint32_t  client_id;
    uint32_t  node_id;
    uint32_t  grp_id;
    uint8_t   grp_pos;
    uint8_t   preset;
    uint8_t   sub_member_count;
    uint8_t   measure_member_count; 
    uint8_t   var_data[];
} TSDB_Req_Expand_Tree_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    uint32_t  start_time;
    uint32_t  end_time;
    uint32_t  tr_num;
    uint32_t  app_id;
    uint32_t  client_id;
    uint8_t   search_level;  //In expand request this will not come. Same structure will be used for search also. 
    uint8_t   grp_pos;
    uint8_t   preset;
    uint8_t   reserved[1];
    uint8_t  var_data[];
} TSDB_Req_Search_Tree_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    RTHdr_t rt_hdr;
    uint8_t num_members;
    uint8_t reserved[7];
    uint8_t  var_data[];
} TSDB_Resp_Tree_t;

typedef struct
{
    MsgHdr_t msg_hdr;
    uint32_t tr_num;
    uint32_t app_id;
    uint32_t client_id;
    uint32_t group_id;
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
    uint32_t start_time;
    uint32_t end_time;
    uint32_t tr_num;
    g_metric_grp_id_t id_mg;
    uint8_t client_id_len;
    uint8_t app_id_len;
    uint16_t num_members;
    uint8_t  preset;
    uint8_t  reserved[3];
    uint8_t  var_data[];
} TSDB_Req_Hierarchical_Level_t;

#if 0
typedef struct
{
    uint8_t  operation; // Type of operation requested
    uint8_t  ts_ar;
    uint8_t  reserved[6];
    uint32_t agg;
    uint32_t preset;
    uint32_t granularity;
    uint32_t tr_num;
    uint32_t app_id;
    uint32_t client_id;
    uint64_t start_time;
    uint64_t end_time;
} __attribute__((packed)) OpSpec_t;

typedef struct
{
    uint16_t offset; // Offset into var_data for array of IDs/Name
    uint16_t count; // Number of IDs/Name in the list
    uint8_t  reserved[4];
} __attribute__((packed)) OffsetCount_t, IDSpec_t, NameSpec_t, DataTypeSpec_t, DerivedSpec_t;

typedef struct
{
    uint8_t type;
    uint8_t m_operator;
    uint8_t include ;
    uint8_t Reserved[5];
    double value1;
    double value2;
} __attribute__((packed)) FilterSpec_t;

typedef struct
{
    uint8_t num_fields;//This is the number of fields in TSDB_Data_Summary_t struct
    double min;
    double max;
    double avg;
    double count;
    double std_dev;
    double last_sample;
    double diff;
} __attribute__((packed)) TSDB_Data_Summary_t;

typedef struct
{
    uint64_t start_time;        // Response timestamps will be rounded based on granularity being used.
    uint64_t end_time;          // Response timestamps will be rounded based on granularity being used.
    uint16_t granularity;       // Granularity of the data. Redundant = duration / value_count
    uint16_t metric_count;      // Number of time series' being returned
    uint16_t metadata_offset;   // Offset into var_data for meta data array of type MetricDataSpec_t
    uint16_t reserved;          // Number of samples per time series being returned
} __attribute__((packed)) DataSpec_t;

typedef struct
{
    long mt_id; //Thsi is to save Metric ID
    uint16_t value_data_type; // used by client to determine how to use the data
    uint16_t value_count; // Number of samples per time series being returned: TODO: Is it possible that different MT will have different numbers of value_count or it will be same for all MTs. ??
    uint32_t value_offset; // Offset into var_data for values array. TODO: This can be more than 65K??? Made int instead of short
} __attribute__((packed)) MetricDataSpec_t;

typedef struct
{
    long mt_id;
    uint8_t sub_mem_count;//how many levels are there in subject
    uint8_t ms_mem_count;//how many levels are there in metric
    uint16_t sub_offset;//At offset we wil have subject level(tag) len(uint16_t) and subject level(tag), subject value len(uint16_t) and subject value
    uint16_t ms_offset;//At offset we wil have mt level(tag) len(uint16_t) and mt level(tag), mt value len(uint16_t) and mt value
    uint16_t reserved;
    uint32_t value_offset;
    uint16_t value_data_type; //This is the type of data. Ex: Scalar, TIMES, TIMES_STD
    uint16_t value_count; // Number of samples per time series being returned
} __attribute__((packed)) MetricDataSpecName_t;

typedef struct
{
    MsgHdr_t hdr;                                      
    uint64_t start_time;
    uint64_t end_time;
    uint32_t tr_num; //Right now we do not have tr number in TSDB
    uint32_t app_id; //Not sure about this right now
    uint32_t client_id; //Not sure about this right now
    uint8_t  op; 
    uint8_t  grp_pos;
    uint8_t  reserved[2];
} __attribute__((packed)) TSDB_Req_Tree_Init_t;

typedef struct
{
    MsgHdr_t  hdr;
    uint64_t  start_time;
    uint64_t  end_time;
    uint32_t  tr_num;
    uint32_t  app_id;
    uint32_t  client_id;
    uint8_t   op;
    uint8_t   grp_pos;
    uint16_t  num_members; //This is to give how many members are there in request 
    uint8_t   reserved[1];
    uint64_t  grp_id;
    uint64_t  mg_type_id;
    uint64_t  mg_id;
    uint8_t   var_data[];
} __attribute__((packed)) TSDB_Req_Expand_Tree_t;

typedef struct
{
    MsgHdr_t hdr;
    uint64_t start_time;
    uint64_t end_time;
    uint32_t tr_num;
    uint32_t app_id;
    uint32_t client_id;
    uint8_t  op;
    uint8_t  grp_pos;
    uint8_t  search_level;  //In expand request this will not come. Same structure will be used for search also. 
    uint8_t  is_regex;  //In expand request this will not come. Same structure will be used for search also. 
    uint8_t  var_data[];
} __attribute__((packed)) TSDB_Req_Search_Tree_t;

typedef struct
{
    MsgHdr_t hdr;
    RTHdr_t rt_hdr;
    uint64_t start_time;
    uint64_t end_time;
    uint8_t  num_sets;
    uint8_t  num_members;
    uint8_t  reserved[6];
    uint8_t  var_data[];
} __attribute__ ((packed)) TSDB_Resp_Tree_t, TSDB_Resp_Tree_Init_t, TSDB_Resp_Expand_Tree_t, TSDB_Resp_Search_Tree_t;

typedef struct
{
    MsgHdr_t hdr;
    uint32_t tr_num;
    uint32_t app_id;
    uint32_t client_id;
    uint32_t group_id;
    uint8_t  mem_count;
    uint8_t  reserved[7];
    uint8_t  var_data[];
} __attribute__ ((packed)) TSDB_Req_Hierarchical_Level_t;

typedef struct
{
    MsgHdr_t hdr;
    RTHdr_t rt_hdr;
    uint16_t mem_count;
    uint8_t  resserved[6];
    uint8_t  var_data[];
} __attribute__ ((packed)) TSDB_Resp_Hierarchical_Level_t;

typedef struct
{
    uint8_t op;
    uint32_t tr_num;
    uint32_t app_id;
    uint32_t client_id;
    uint64_t start_time;
    uint64_t end_time;
    uint32_t agg;
    uint8_t  present;
    uint16_t grp_by_sub_offset;
    uint16_t grp_by_measure_offset; 

} __attribute__ ((packed)) TSDB_Req_Metadata_t;

typedef struct
{
    MsgHdr_t hdr;
    RTHdr_t rt_hdr;
    uint16_t panel_data_count;
    uint16_t panet_data_offset;
    uint8_t  reserved[4];
    uint8_t  var_data[];
} __attribute__ ((packed)) TSDB_Resp_Metadata_t;

typedef struct
{
    MsgHdr_t hdr;
    OpSpec_t op_specs;
    DataTypeSpec_t data_type_specs;
    OffsetCount_t  offset_count_specs;
    uint8_t var_data[];
} __attribute__((packed)) TSDB_Req_Data_By_Id_t, TSDB_Req_Data_By_Name_t;

typedef struct
{
    MsgHdr_t hdr;
    OpSpec_t op_specs;                                                                                                                                              
    DataTypeSpec_t data_type_specs;
    OffsetCount_t  offset_count_specs;
    FilterSpec_t   filter_spec;
    uint8_t var_data[];
} __attribute__((packed)) TSDB_Req_Data_By_Name_With_Filter_t, TSDB_Req_Data_By_Id_With_Filter_t;

typedef struct
{
    MsgHdr_t hdr;
    RTHdr_t rt_hdr;
    DataSpec_t data_spec;
    uint8_t var_data[]; // Contains variable length arrays, strings etc
} __attribute__((packed)) TSDB_Resp_Data_t;

#if 0

typedef struct
{
   uint16_t id_offset;
   uint16_t id_count;
   uint8_t reserved[4];
}__attribute__((packed)) DerivedSpec_t;

typedef struct
{
    MsgHdr_t hdr;
    uint16_t member_count; // Number of vectors or metrics or metric groups being returned at the level
    uint16_t idOffset; // Offset into var_data for IDs
    uint16_t valueOffsets; // Offsets array into var_data which points to Names
    // More offsets as required
    uint8_t var_data[]; // Contains variable length arrays, strings etc
} __attribute__((packed)) TSDB_RespMsg_Tree_1_t;

typedef struct
{
    MsgHdr_t hdr;
    uint16_t node_count; // Total node count, all arrays are of this size
    uint16_t treeBPBitmaskOffset; // For succint representation of the tree, parenthesis representation
    uint16_t idOffset; // Offset into var_data for IDs
    uint16_t nameOffsets; // Offsets array into var_data which points to Names
    uint8_t var_data[]; // Contains variable length arrays, strings etc
} __attribute__((packed)) TSDB_RespMsg_Tree_F_t;



typedef struct
{
    MsgHdr_t hdr;
    uint32_t stream_id;
    uint32_t port;
} __attribute__((packed)) ConnSpec_t;

// Example: Structure for query: get data for a specific TSID: Get 1 or multiple graphs based on input
typedef struct
{
    MsgHdr_t hdr; // Header, never changes between different message sizes;
    OpSpec_t query_op; // Query operation spec
    IDSpec_t tsID; // Time series ID spec
    uint8_t var_data[]; // Contains variable length arrays, strings etc
} __attribute__((packed)) TSDB_ReqMsg_1_t;

// Example: Structure for query: get data for all, pattern, specific host for a metric: Merge all/pattern, Open all group members. Tree op next level
typedef struct
{
    MsgHdr_t hdr;
    OpSpec_t query_op; // Query operation spec
    MetricSpec_t mInfo;
    SubjectSpec_t sInfo;
    uint8_t var_data[]; // Contains variable length arrays, strings etc
} __attribute__((packed)) TSDB_ReqMsg_3_t;

typedef struct
{
    uint16_t data_type_offset;
    uint8_t  data_type_count;
    uint8_t  reserved[5];
} __attribute__((packed)) DataTypeSpec_t;

typedef struct
{
    uint16_t idOffset; // Offset into var_data for array of IDs
    uint16_t id_count; // Number of IDs in the list
    uint8_t  reserved[4];
} __attribute__((packed)) IDSpec_t;

typedef struct
{
    uint32_t group_id;
    uint32_t graph_id;
    uint32_t metric_id;
    uint8_t id_or_name_or_pattern;
    uint16_t offset;
    uint8_t count;
    uint8_t summary_data;
    uint8_t ns_txn_detail;
    uint8_t Reserved[6];

#if 0
    uint16_t data_type_offset;
    uint8_t  summary_data;
    uint8_t  ns_txn_detail;
    uint32_t group_id;
    uint32_t graph_id;
    uint32_t metric_id;
    uint8_t  id_or_name_or_pattern_flag; // How to interpret union
    uint16_t offset;
    uint8_t  count;
    uint8_t  reserved[4];
    /*
    int percentile
    union
    {
        uint16_t mNameOffset;   // Offset into var_data[] for metric name or Group name
        uint64_t mId; // Depends on subj_id_or_name_flag or a Group id
    } */
#endif
} __attribute__((packed)) MetricSpec_t;

typedef struct
{
    uint32_t test_run;
    uint32_t app_id;
    uint64_t customer_id;
    uint8_t  id_or_name_or_pattern;
    uint16_t offset;
    uint8_t  count;
    uint32_t node_id;
    uint8_t  search_lvl;
    uint8_t  reserved[7];

    /*
    uint32_t search_pattern_offset; // offset to var_data
    uint32_t pattern_offset; // offset to var_data
    uint8_t  subj_id_or_name_flag; // How to interpret union
    union
    {
        uint32_t subjectNameOffset;  // Offset into var_data[] for subject name or pattern
        uint64_t subjectId; // Depends on subj_id_or_name_flag
    }; */
} __attribute__((packed)) SubjectSpec_t;

typedef struct
{
    uint16_t group_name_offset;
    uint16_t group_name_len;
    uint16_t group_metric_name_offset;
    uint16_t group_metric_name_len;
    uint32_t group_id;
    uint8_t  is_group_type_vector;
    uint8_t  reserved[3];
} __attribute__ ((packed)) Group_t;

typedef struct
{
    uint32_t name_offset;
    uint32_t name_len;
    uint32_t desc_offset;
    uint32_t desc_len;
    uint32_t count;
    uint8_t  reserved[6];
} __attribute__ ((packed)) Graph_t;

typedef struct
{
    MsgHdr_t hdr;
    uint8_t  op;
    uint8_t  grp_pos;
    uint8_t  sub_mem_count;
    uint8_t  measure_lvl_count;
    uint32_t tr_num;
    uint64_t start_time;
    uint64_t end_time;
    uint32_t app_id;
    uint32_t client_id;
    uint32_t node_id;
    uint32_t grp_id;
    uint32_t mg_type_id;
    uint32_t mg_id;
    uint64_t mt_id;
    uint8_t  var_data[];
} __attribute__ ((packed)) TSDB_Req_Expand_Tree_t;

typedef struct
{
    uint8_t  op;
    uint8_t  grp_pos;
    uint8_t  search_level;
    uint32_t tr_num;
    uint32_t app_id;
    uint32_t client_id;
    uint64_t start_time;
    uint64_t end_time;
    uint8_t  var_data[]; // search pattern will start from here and will be null terminated
} __attribute__ ((packed)) TSDB_Req_Search_Tree_t;

typedef struct
{
    MsgHdr_t hdr;
    RTHdr_t rt_hdr;
    uint64_t start_time;
    uint64_t end_time;
    uint8_t  num_sets;
    uint8_t  num_members;
    uint8_t  reserved[6];
    uint64_t group_id;
    uint8_t  var_data[];
} __attribute__((packed)) TSDB_Resp_Expand_Tree_t;

typedef struct
{
    MsgHdr_t hdr;
    RTHdr_t rt_hdr;
    uint64_t start_time;
    uint64_t end_time;
    uint8_t  search_level;
    uint8_t  num_sets;
    uint8_t  num_members;
    uint8_t  reserved[5];
    uint8_t  var_data[];
}  __attribute__ ((packed)) TSDB_Resp_Search_Tree_t;

#endif
#endif

#endif
