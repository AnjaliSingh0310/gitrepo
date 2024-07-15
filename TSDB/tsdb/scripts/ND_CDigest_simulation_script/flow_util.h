#define SLEEP_INTERVAL 10 //In seconds
 #define BUFF_SIZE 1280000
#define MAX_SIZE 1024
#define GDF_DELTA_ENTRIES 5
#define CUSTOM_MONITOR 0
#define DVM_MONITOR    1
#define MAX_BUF_SIZE 1024

typedef struct vector
{
  char vecName[256];
  char data[12];
}vector;

typedef struct gdf_data
{
  char gdf_name[256];
  int slot_used;
  int monitor_type;
  int delInterval; //In seconds
  int addInterval;// In seconds
  int minVectors;
  int maxVectors;
  float minData;
  float maxData;
  int numvectors;
  char vec_prefix[128];
  vector *vec;
  int numOfElement;
  int group_id;
  int mon_id;
  int data_len;
  int new_vect_interval;
  int curr_vectors;
  //struct gdf_data* free_next; /* next free Vuser slot */
  //struct gdf_data* busy_next;
  //struct gdf_data* busy_prev;
}gdf_data;


typedef struct gdf_file_struct
{
  char gdf_name[256];
  int eventId;
  int group_id;
  int numOfElement;
  int monitor_type;
  float minData;
  float maxData;
  int mon_id;
  int num_vector;
  char tier_name[256];
  char server_name[256];
  char app_name[256];
  char vec_name[256];
  int slot_used;
  int numvectors;
  char vec_prefix[128];
  int data_len;
  int new_vect_interval;
  int curr_vectors;
  int graph_id;
  int cdigest_enable;
}gdf_file_struct;


//gdf_data* gBusyGdfHead = NULL;
//gdf_data* gBusyGdfTail = NULL;
//int send_monitor_data_to_ndc_on_data_conn(char *data);
int send_monitor_data_to_ndc_on_data_conn(gdf_data *gdf_data_struct, int total_gdf_entries, char *data, gdf_file_struct **gdf_file, int idx);
