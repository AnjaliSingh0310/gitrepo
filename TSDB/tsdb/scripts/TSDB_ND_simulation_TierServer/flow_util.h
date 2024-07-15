#define SLEEP_INTERVAL 10 //In seconds
 #define BUFF_SIZE 128000
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
  int mon_id;
  //struct gdf_data* free_next; /* next free Vuser slot */
  //struct gdf_data* busy_next;
  //struct gdf_data* busy_prev;
}gdf_data;


typedef struct gdf_file_struct
{
  char gdf_name[256];
  int eventId;
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
}gdf_file_struct;


//gdf_data* gBusyGdfHead = NULL;
//gdf_data* gBusyGdfTail = NULL;
 int send_monitor_data_to_ndc_on_data_conn(char *data);
