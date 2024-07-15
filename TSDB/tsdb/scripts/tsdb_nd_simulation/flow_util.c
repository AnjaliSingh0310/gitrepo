#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h> 
#include "ns_string.h"
#include "flow_util.h"//Data Connection related functions

int debug_level = 0;
void get_server_ip_name(char *server_ip, char *server_name, char *tier_name, char *cmon_pid)
{
  int userID = ns_get_userid();
  int nvmID = ns_get_nvmid(); 
  int sessionID = ns_get_sessid();    
  
  ns_advance_param("TierName");
  sprintf(tier_name, "%s", ns_eval_string("{TierName}"));
  sprintf(server_name, "%s-%d-%d", tier_name, nvmID, userID);
  sprintf(server_ip, "%d.%d.%d.100", nvmID, userID, sessionID);
  strcpy(cmon_pid, ns_eval_string("{CmonVersion}"));
	
  if(debug_level >= 1)
    fprintf(stderr, "Random ServerName is [%s], Server_IP = %s, CMON PID = %s\n,", server_name, server_ip, cmon_pid);
}

void get_nd_agent_details(char *app_name, char *nd_app_server_host, char *tier_name, char *bci_start_time, char *bci_pid, char *bci_timestamp, char *server_ip, char *hostname, char *last_connection_time_stamp)
{
  int userID = ns_get_userid();
  int nvmID = ns_get_nvmid(); 
  int sessionID = ns_get_sessid();    
  
  ns_advance_param("TierName");
  sprintf(app_name, "ndAgentSimulator");
  sprintf(tier_name, "%s", ns_eval_string("{TierName}"));
  sprintf(nd_app_server_host, "%s-%d-%d", tier_name, nvmID, userID);
  sprintf(bci_start_time, "1585501539477");
  sprintf(bci_pid, "5555");
  sprintf(bci_timestamp, "%ld", 1000 * ((long) time(NULL)));
  sprintf(server_ip, "%d.%d.%d.100", nvmID, userID, sessionID);
  sprintf(hostname, "%s-%d-%d", tier_name, nvmID, userID);
  sprintf(last_connection_time_stamp, "197108351502");
}




/* to get monitor data if mindata and maxdata both  are same then randome value get dumped otherwise  random value in range of min and max dum
ped*/

float gen_random_val(float minVal, float maxVal)
{
  float scale_range = 0.0f;
  //if (minVal == maxVal)
   //return (float)rand();
  scale_range = rand() / (float) RAND_MAX; //it will  generate value in range 0.0 to 1.0  
  return minVal + scale_range * ( maxVal - minVal );      //min + [0.0 +1.0]*(max-min)
}

void  make_monitor_data(gdf_data *gdf_data_struct, int total_gdf_entries, char *buffer, gdf_file_struct **gdf_file, int idx, int tier_id, int instance_id, char *tier_name, char *nd_app_server_host, char *app_name )
{
  gdf_file_struct *gdf_file_struct_temp = *gdf_file + idx;
  int len = 0;

  if(debug_level >= 1)  
  {
    fprintf(stdout, "Goin to make monitor data\n");
    fprintf(stderr,"%s %s %s %s\n\n", tier_name, nd_app_server_host, app_name, gdf_file_struct_temp->vec_name);
  }

  if(gdf_file_struct_temp->slot_used)
  {
    if(gdf_file_struct_temp->monitor_type == CUSTOM_MONITOR)
      get_custom_monitor_data(gdf_file_struct_temp, buffer, total_gdf_entries, idx, tier_id, instance_id, tier_name, nd_app_server_host, app_name);
    else if(gdf_file_struct_temp->monitor_type == DVM_MONITOR)
      get_dvm_monitor_data(gdf_file_struct_temp, buffer, total_gdf_entries, idx, tier_id, instance_id, tier_name, nd_app_server_host, app_name);
  }
 if(debug_level >= 2)
 fprintf(stderr, "\n\n****** outgoing mesage buffer is [%s]\n ",buffer);

}

int create_gdf_table_entry(int *row_num, int *max_gdf_entries, int *total_gdf_entries, char **ptr)
{
  //fprintf(stderr, "Method Called, row_num = %d, total_gdf_entries = %d, max_gdf_entries = %d\n",*row_num, *total_gdf_entries, *max_gdf_entries);

  if (*total_gdf_entries == *max_gdf_entries) 
  {
    *ptr = realloc(*ptr, (*max_gdf_entries + GDF_DELTA_ENTRIES) * sizeof(gdf_file_struct));

    if (!*ptr) 
    {
      fprintf(stderr,"%s(): Error allocating more memory for gdf data.\n", __FUNCTION__);
      return 1;
    }
    else
    {
      *max_gdf_entries += GDF_DELTA_ENTRIES;
    }
  }
  *row_num = (*total_gdf_entries)++;

  //fprintf(stderr, "Method Called, row_num = %d, total_gdf_entries = %d, max_gdf_entries = %d\n",*row_num, *total_gdf_entries, *max_gdf_entries);
  return 0;
}

void read_msg_from_ndc_on_ctrl_conn(char *resp_body, char *msg_type, int *resp_size)
{
  //Check if any message realated to monitor has come
  ns_start_transaction(msg_type);
  
  char *resp = ns_web_websocket_read(1, 3000, resp_size); //in ms

  if(resp != NULL)
  {
    strcpy(resp_body, resp);
  if(debug_level >= 1)
    fprintf(stderr, "\n %s, [CMON <- NDC] (%d Bytes) = [%s] resp \n", __FUNCTION__, *resp_size, resp); 
  }
  
  ns_end_transaction(msg_type, NS_AUTO_STATUS);
}

char *decode(char *input)
{
  char *ptr;
  ptr = input;
  while((ptr = strchr(ptr, '+')) != NULL)
  {
    *ptr = ' ';
     ptr++;
  }
  ptr = NULL;
  //ptr = curl_unescape(input, strlen(input));
  return ptr;
}

//12304:0:CPU0|10.05 0.00 9.25 0.03 0.00 0.00 0.00 0.00 80.66
//12304:1:CPU1|9.32 0.00 8.87 0.02 0.00 0.00 0.00 0.00 81.79
void get_dvm_monitor_data (gdf_file_struct *gdf_file_temp, char *outBuff, int total_gdf_entries, int idx, int tier_id, int instance_id, char *tier_name, char *nd_app_server_host, char *app_name)
{
  int i;
  int len = 0;
  float random_val = 0.0f;
  
  if(debug_level >= 1)
    fprintf(stderr, "numvectors = %d num_vector1=%d numOfElement1=%d\n", gdf_file_temp->numvectors, gdf_file_temp->num_vector, gdf_file_temp->numOfElement);


  ns_start_transaction("NDTotalVectorMonitors");
  for(i = 0; i < gdf_file_temp->num_vector; i++)
  {  
                                    //Eventid,Tierid|InstanceId|vectorid:TierName>ServerName>InstanceName>VectorName|<Elements>\n
    len += sprintf (outBuff + len, "%d,%d|%d|%d:%s>%s>%s>%s_%d|", gdf_file_temp->eventId, tier_id, instance_id, i , tier_name, nd_app_server_host, app_name, gdf_file_temp->vec_name, i);
    
    //len += sprintf(outBuff + len, "0:%d:%s%d|",  i, gdf_file_temp->vec_name, i);  
    
    for(int j = 0; j < gdf_file_temp->numOfElement; j++)
    {  
      ns_start_transaction("NDTotalVectorIndices");
       random_val = gen_random_val(gdf_file_temp->minData, gdf_file_temp->maxData);
       len += sprintf(outBuff + len, "%f ",random_val);
      ns_end_transaction("NDTotalVectorIndices", 0);	
    }
    len += sprintf(outBuff + len, "\n");
  }
  ns_end_transaction("NDTotalVectorMonitors", 0);	
}

void get_custom_monitor_data (gdf_file_struct *gdf_file_temp, char *outBuff, int total_gdf_entries, int idx, int tier_id, int instance_id, char *tier_name, char *nd_app_server_host, char *app_name)
{
  int len = 0;
  float random_val = 0.0f;
  
  for(int idx = 0; idx < gdf_file_temp->num_vector; idx++)
  { 
    /*len += sprintf(outBuff, "%d,%d|%d|%d:%s>%s>%s>%s_%d|", gdf_file_temp->eventId, tier_id, instance_id, idx, tier_name, 
                                                          nd_app_server_host, app_name, gdf_file_temp->vec_name, idx);*/
    len += sprintf(outBuff, "%d,%d|%d|%d:%s>%s>%s|", gdf_file_temp->eventId, tier_id, instance_id, idx, tier_name, nd_app_server_host, app_name);
    //len += sprintf(outBuff + len, "%d:", gdf_file_temp->mon_id);
    
    ns_start_transaction("NDTotalScalarMonitors");
      for(int i = 0; i < gdf_file_temp->numOfElement; i++)
      {  
                ns_start_transaction("NDTotalScalarIndices");
        random_val = gen_random_val( gdf_file_temp->minData,  gdf_file_temp->maxData);
        len += sprintf(outBuff + len, " %f",random_val);
                ns_end_transaction("NDTotalScalarIndices", 0);	
      }
    ns_end_transaction("NDTotalScalarMonitors", 0);	

    len += sprintf(outBuff + len, "\n");
  }     
}

void dump_gdf_struct_info(gdf_file_struct **gdf_data_struct, int total_gdf_entries)
{ 
  if(debug_level >= 1)
  {
    fprintf(stderr, "%s, total_gdf_enries is %d \n",__FUNCTION__, total_gdf_entries);
  }
  gdf_file_struct *gdf_data_tmp =NULL;

  for(int row_num=0; row_num < total_gdf_entries; row_num++)
  {
    gdf_data_tmp = *gdf_data_struct + row_num;
    if(debug_level >= 1)
    fprintf(stderr, "Monitor Configuration data,IDX = %d, GDF = %s, numOfElement = %d, monitor_type = %d, minData = %f, maxData = %f, mon_id = %d, numvectors = %d, tier= %s  server= %s instance = %s  vector = %s\n", row_num, gdf_data_tmp->gdf_name, gdf_data_tmp->numOfElement, gdf_data_tmp->monitor_type,  gdf_data_tmp->minData, gdf_data_tmp->maxData, gdf_data_tmp->mon_id, gdf_data_tmp->num_vector, gdf_data_tmp->tier_name,
   gdf_data_tmp->server_name,  gdf_data_tmp->server_name, gdf_data_tmp->vec_name);
  }
}

int fill_gdf_data(gdf_data **gdf_data_struct, char *gdf_name, int mon_id, int *total_gdf_entries, int *max_gdf_entries)
{
  int idx;
  int row_num = 0;
  gdf_data *gdf_data_struct_tmp = *gdf_data_struct;

  if(debug_level >= 1)
  fprintf(stdout, "Method Called. total_gdf_entries = %d, gdf name = %s\n", *total_gdf_entries, gdf_name); 

  ns_save_string(gdf_name,"DV_GDFName");
  ns_eval_string("{DV_GDFName}");
  if(!strcmp("", ns_eval_string("{NumberOfElement}")))
  {
  if(debug_level >= 1)
    fprintf(stderr, "GDF %s not found in index param, Will not send data for this monitor.\n", gdf_name);
    return 1;
  }
  //Loop through the struture and check if gdf is already there. 
  //If already there nothing to do. If no then add data in the structure.
  for(idx = 0; idx < *total_gdf_entries; idx++)
  {
    gdf_data_struct_tmp = *gdf_data_struct + idx;

    if(gdf_data_struct_tmp->mon_id == mon_id && gdf_data_struct_tmp->slot_used)
    {
      //fprintf(stderr, "**********already entered  %s\n",gdf_data_struct_tmp->gdf_name);
      fprintf(stdout, "MON ID already have %d space, Ignoring idx [%d], GDF = %s\n", gdf_data_struct_tmp->mon_id , idx, gdf_name);
      return 1;
    }
  }

  //Create space in structure   
  create_gdf_table_entry(&row_num, max_gdf_entries, total_gdf_entries, (char **)gdf_data_struct);

  gdf_data_struct_tmp = *gdf_data_struct + row_num;  
  ns_save_string(gdf_name,"DV_GDFName");
  strcpy(gdf_data_struct_tmp->gdf_name, ns_eval_string("{DV_GDFName}"));
  gdf_data_struct_tmp->numOfElement = atoi(ns_eval_string("{NumberOfElement}"));
  gdf_data_struct_tmp->monitor_type = atoi(ns_eval_string("{MonitorType}"));
  gdf_data_struct_tmp->addInterval =  atoi(ns_eval_string("{AddInterVal}"));
  gdf_data_struct_tmp->delInterval =  atoi(ns_eval_string("{DeleteInterval}"));
  gdf_data_struct_tmp->minVectors = atoi(ns_eval_string("{MinVectors}"));
  gdf_data_struct_tmp->maxVectors = atoi(ns_eval_string("{maxVectors}"));
  strcpy(gdf_data_struct_tmp->vec_prefix, ns_eval_string("{VectorPrefix}"));
  gdf_data_struct_tmp->maxData = atof(ns_eval_string("{Data}"));
  gdf_data_struct_tmp->minData = 0.0; 
  gdf_data_struct_tmp->mon_id = mon_id;
  gdf_data_struct_tmp->slot_used = 1;
  if(gdf_data_struct_tmp->monitor_type == DVM_MONITOR)
  {
     gdf_data_struct_tmp->numvectors = (int)gen_random_val(gdf_data_struct_tmp->minVectors, gdf_data_struct_tmp->maxVectors);
  }
  //dump_gdf_struct_info(*gdf_data_struct, *total_gdf_entries);

  
  fprintf(stdout, "Returning with total_gdf_entries = %d, gdf name = %s\n", *total_gdf_entries, gdf_name); 
  return 0;
}

int parse_start_instrumentation_message(char *recd_msg, int recd_msg_size, int *tier_id, int *server_id, int *instance_id, char *nd_app_server_host)
{
  char *decoded_recd_msg = ns_decode_url(recd_msg, recd_msg_size);

  char *ptr = strstr(decoded_recd_msg, "tierID=");
  char *ptr2 = strchr(ptr, '=');
  ptr2++;
  *tier_id =  atoi(ptr2);

  ptr = strstr(decoded_recd_msg, "ndAppServerID=");
  ptr2 = strchr(ptr, '=');
  ptr2++;
  *server_id =  atoi(ptr2);

  ptr = strstr(decoded_recd_msg, "appID=");
  ptr2 = strchr(ptr, '=');
  ptr2++;
  *instance_id =  atoi(ptr2);

  ptr = strstr(decoded_recd_msg, "ndAppServerHost=");
  ptr2 = strchr(ptr, '=');
  ptr2++;
  ptr=strchr(ptr2, ';');
  if(ptr) *ptr = '\0';
  strcpy(nd_app_server_host, ptr2);

  return 0;
}


int parse_hb_response_message(char *recd_msg, int recd_msg_size, gdf_data **gdf_data_struct, int *total_gdf_entries, int *max_gdf_entries, int *testidx)
{
  char gdf_name[128] = "\0";
  int mon_id;
  char *decoded_recd_msg = ns_decode_url(recd_msg, recd_msg_size);

  if(!strncmp(decoded_recd_msg, "cmon_get_config_msg_resp:type=1;", 32))
  {
    char *ptr = strstr(decoded_recd_msg, "TR=");
    char *ptr2 = strchr(ptr, '=');
    ptr2++;
    *testidx =  atoi(ptr2);
    return 1;
  }

  //Check for init message.
  //If this is init message then get mon id, GDF name, Get the number of graphs in the gdf.
  //Mon ID will be used to send the data over data connection.
  if(!strstr(decoded_recd_msg, "cm_init_monitor"))
    return 1;
  if(debug_level >= 1)
  fprintf(stderr, "Decoded msg = %s", decoded_recd_msg);
  if(debug_level >= 1)
  fprintf(stdout, " Got cm_init_monitor in response. Going to parse the message\n");

  //This is init message now get the mon id and gdf name
  char *ptr = strstr(decoded_recd_msg, "MON_ID");
  char *ptr2 = strchr(ptr, '=');
  ptr2++;
  mon_id = atoi(ptr2);
  if(debug_level >= 1)
  fprintf(stderr, "Monitor id = %d\n", mon_id);

  //Now get GDF name
  //MON_GDF=/home/cavisson/MSSQL_Monitoring/sys/cm_mssql_server_statsV2.gdf;MON_PGM
  ptr = strstr(ptr2, "MON_GDF");
  ptr = strstr(ptr, "cm_");//Pointing to start of the gdf name
  ptr2 = strchr(ptr, ';');
  *ptr2 = '\0'; 
  //copy gdf name into buffer
  strcpy(gdf_name, ptr);
  if(debug_level >= 1)
  fprintf (stderr,"gdf name is %s\n\n\n",gdf_name);
  
  int ret = fill_gdf_data(gdf_data_struct, gdf_name, mon_id, total_gdf_entries, max_gdf_entries);
  return ret; //Return 0 as we got init monitor
}

/*void make_monitor_data(gdf_data *gdf_data_struct, char *buffer, int total_gdf_entries)
{
  gdf_data *gdf_data_struct_tmp = NULL;
  int idx;
  int len = 0;
  //for( idx = 0; idx < total_gdf_entries; ++idx )
  for( idx = 0; idx < total_gdf_entries; idx++)
  {
     gdf_data_struct_tmp = gdf_data_struct + idx;

     if(gdf_data_struct_tmp->slot_used)
     {
       if(gdf_data_struct_tmp->monitor_type == CUSTOM_MONITOR)
         get_custom_monitor_data(gdf_data_struct_tmp, buffer,  &len);
       else if(gdf_data_struct_tmp->monitor_type == DVM_MONITOR)
       {
         get_dvm_monitor_data(gdf_data_struct_tmp, buffer, &len);
       }
     }
  }
  fprintf(stderr, "\n\n\n\n****** outgoing mesage buffer is %s\n ",buffer);
   //send_monitor_data_to_ndc_on_data_conn(buffer);
}*/


int parse_gdf_file(gdf_file_struct **gdf_file, char *gdf_file_path, int *total_gdf_entries, int *max_gdf_entries)
{
  int row_num = 0;
  gdf_file_struct *gdf_file_tmp;
  char buff[MAX_BUF_SIZE];
  FILE *fp = fopen(gdf_file_path, "re");
  char gdf_name[256];
  char tier_name[256];
  char server_name[256];
  char app_name[256];
  char vec_name[256];
  int num_of_elements;
  float min_data;
  float max_data;
  int min_vectors;
  int max_vectors;
  int  event_id;
  int num_vector; 
  int monitor_type;

  if(fp == NULL)
  {
    fprintf(stderr, "Error in opening  file  : %s\n", gdf_file_path);
    return -1;
  }
  while(fgets(buff, MAX_BUF_SIZE, fp))
  {
    if (buff[0] == ' ' ||  buff[0] == '#')
      continue;

//#gdf_name   event_id   no_of_element   Upper_limit    lower_limit   num_vector     min_vectors    max_vectors    monitortype(0 - custom, 1 - dynamic) server    vectorprefix 

    sscanf(buff, "%s%d%d%f%f%d%d%d%d%s%s", gdf_name, &event_id, &num_of_elements, &max_data, &min_data, &num_vector, &min_vectors, &max_vectors, &monitor_type, server_name, vec_name);
// sscanf(buff, "%s%d%d%f%f%d%s%s%s%s", gdf_name, &event_id, &num_of_elements, &max_data, &min_data, &num_vector, tier_name, server_name, app_name, vec_name);
    create_gdf_table_entry(&row_num, max_gdf_entries, total_gdf_entries, (char **)gdf_file);

    gdf_file_tmp = *gdf_file + row_num; 

    strcpy(gdf_file_tmp->gdf_name, gdf_name );   
/////
    gdf_file_tmp->slot_used = 1;   
/////
    gdf_file_tmp->eventId = event_id;   
    gdf_file_tmp->numOfElement = num_of_elements;   
    gdf_file_tmp->minData  = min_data;   
    gdf_file_tmp->maxData  = max_data;   
    gdf_file_tmp->num_vector = num_vector;
    gdf_file_tmp->numvectors = num_vector;
    gdf_file_tmp->monitor_type = monitor_type;    
    strcpy(gdf_file_tmp->tier_name, tier_name);
    strcpy(gdf_file_tmp->server_name, server_name);
    strcpy(gdf_file_tmp->app_name, app_name);
    strcpy(gdf_file_tmp->vec_name, vec_name);
} 
return 0;
}

