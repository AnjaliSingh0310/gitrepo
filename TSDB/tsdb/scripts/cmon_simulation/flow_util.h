#define SLEEP_INTERVAL 10 //In seconds
#define MAX_SIZE 1024
#define GDF_DELTA_ENTRIES 5
#define CUSTOM_MONITOR 0
#define DVM_MONITOR    1

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
  float minData[230];
  float maxData[230];
  int numvectors;
  char vec_prefix[128];
  vector *vec;
  int numOfElement;
  long mon_id;
  int frequency;
  long last_time_data_sent;
  long curr_time;
  //double time_factor;

  //struct gdf_data* free_next; /* next free Vuser slot */
  //struct gdf_data* busy_next;
  //struct gdf_data* busy_prev;
}gdf_data;

//gdf_data* gBusyGdfHead = NULL;
//gdf_data* gBusyGdfTail = NULL;
 int send_monitor_data_to_ndc_on_data_conn(char *data);
