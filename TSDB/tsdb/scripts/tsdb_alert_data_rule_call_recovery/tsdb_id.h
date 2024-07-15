#ifndef _TSDB_ID_
#define _TSDB_ID_

#define ID_BIN_SIZE_BYTES (sizeof(metric_id_t)) //Bytes

#define ID_TYPE_METRIC_GROUP_TYPE  0
#define ID_TYPE_METRIC_GROUP       1
#define ID_TYPE_SUBJECT_VALUE      2
#define ID_TYPE_METRIC             3
#define ID_TYPE_SUBJECT_TYPE       4
#define ID_TYPE_LOCAL_MG           5
#define ID_TYPE_SUBJECT            6
#define ID_TYPE_MSG                7
#define ID_TYPE_ATTRIBUTE          8

/*
 Type
  1 Byte for identifying the object type that this ID is representing - can be one of following
    Metric Group Type - 0
    Metric Group - 1
    Subject Value Node - 2
    Metric - 3
    Subject Type Node - 4

 1a - Type node
  2 Bytes for Local Tree ID 
  3 Bytes for Table Id i.e. index for type node table into the table of tables
  4 Bytes for Table Idx - i.e. index for type node into the mvt table of subject node

 1b - 4 Bytes - Min index of Value Subject node in it’s MVT table. 
      The MVT table of the ‘type subject node’ can be obtained in the type node’s nodes_group field. 
      Hence it can be obtained from 1b.

 2a - 2 Bytes - Min index of mg in the global metric group table. 
      The starting address of the global metric table will be well known.

 3a - 2 Bytes Min index of Metric Group in local subject value node’s MG table.
      Note that the table id (index in table of tables) is present in the mg field of value subject node.

 3b - 2 Bytes Min index of Metric in local mg table on subject node.
      Note that the table id (index in table of tables) is present in the mg field of value subject node.
*/

typedef struct
{
  char type;  // For global metric Group - 1
  char pad1; //Alignment
  short g_mg_idx; //2a
} g_metric_grp_id_t;

typedef struct
{
 char type; //For Local Metric - 3
 char pad1; //For alignment
 short local_tree_idx;  //1a(1)
 int tt_idx; //1a(2)
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

/*typedef struct
{
  char type; // For Subject Value node - 2
  char pad1; //Alignment
  short local_tree_idx; //1a(1)
  int tt_idx; //1a(2)
  int table_idx; //1a(3)
  int subject_idx; //1b
  short g_mg_idx; //2a
  short pad2; //Alignment
}subject_value_id_t;
*/

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

//extern void *id_convert_long_to_bin(long metric_id, unsigned char id_type, void *buf);
//extern long id_convert_bin_to_long(void *bin_id);
extern char convert_hex2char(char *hexstr);

#endif
