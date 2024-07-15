#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ns_string.h"
#include "flow_util.h"//Data Connection related functions


int debug_level = 1;
double time_factor;
void initialize_variable()
{
  debug_level = atoi(ns_eval_string("{debugLevel}"));
  time_factor = atof(ns_eval_string("{Time_Factor}"));
}


void get_server_ip_name(char *server_ip, char *server_name, char *tier_name, char *cmon_pid)
{
  int userID = ns_get_userid();
  int nvmID = ns_get_nvmid(); 
  int sessionID = ns_get_sessid();    
  
  ns_advance_param("TierName");
  sprintf(tier_name, "%s", ns_eval_string("{TierName}"));
  sprintf(server_name, "%s-%d-%d-0-%d", tier_name, nvmID, userID, (int)time(NULL)); //TODO: Add generator ID in place of 0
  sprintf(server_ip, "%d.%d.%d.100", nvmID, userID, sessionID); //TODO: Make it file param.
  strcpy(cmon_pid, ns_eval_string("{CmonVersion}"));
	
  if(debug_level >= 1)
    fprintf(stderr, "Random ServerName is [%s], Server_IP = %s, CMON PID = %s\n,", server_name, server_ip, cmon_pid);
}

void read_msg_from_ndc_on_ctrl_conn(char *resp_body, char *msg_type, int *resp_size)
{
  //Check if any message realated to monitor has come
  ns_start_transaction(msg_type);
  
  char *resp = ns_web_websocket_read(3, 500, resp_size); //in ms

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


//12304:0:CPU0|10.05 0.00 9.25 0.03 0.00 0.00 0.00 0.00 80.66
//12304:1:CPU1|9.32 0.00 8.87 0.02 0.00 0.00 0.00 0.00 81.79
void get_dvm_monitor_data (gdf_data *gdf_data_struct_tmp, char *outBuff, int *len)
{
  int idx;
  int i;
  float random_val = 0.0f;

  ns_start_transaction("CmonTotalVectorMonitors");
  for(i = 0; i < gdf_data_struct_tmp->numvectors; i++)
  {  
    *len += sprintf(outBuff + *len, "%d:%d:%s%d|", gdf_data_struct_tmp->mon_id, i, gdf_data_struct_tmp->vec_prefix, i);
    for(idx = 0; idx < gdf_data_struct_tmp->numOfElement; idx++)
    {  
      ns_start_transaction("CmonTotalVectorIndices");
      random_val = gen_random_val( gdf_data_struct_tmp->minData[idx],  gdf_data_struct_tmp->maxData[idx]);
      *len += sprintf(outBuff + *len, "%f ",random_val);
      ns_end_transaction("CmonTotalVectorIndices", 0);
      //ns_end_transaction_as("CmonTotalVectorIndices", 0, "CmonTotalVectorIndices");
    }
    *len += sprintf(outBuff + *len, "\n");
  }
  ns_end_transaction("CmonTotalVectorMonitors", 0);
  //ns_end_transaction_as("CmonTotalVectorMonitors", 0, "CmonTotalVectorMonitors");
}

void get_custom_monitor_data (gdf_data *gdf_data_struct_tmp, char *outBuff, int *len)
{
  int idx;
  float random_val = 0.0f;

  *len += sprintf(outBuff + *len, "%d:", gdf_data_struct_tmp->mon_id);

  ns_start_transaction("CmonTotalScalarMonitors");
  for(idx = 0; idx < gdf_data_struct_tmp->numOfElement; idx++)
  {  
    ns_start_transaction("CmonTotalScalarIndices");
    random_val = gen_random_val( gdf_data_struct_tmp->minData[idx],  gdf_data_struct_tmp->maxData[idx]);
    *len += sprintf(outBuff + *len, " %f",random_val);
    ns_end_transaction("CmonTotalScalarIndices", 0);
    //ns_end_transaction_as("CmonTotalScalarIndices", 0, "CmonTotalScalarIndices");
  }
  ns_end_transaction("CmonTotalScalarMonitors", 0);
  //ns_end_transaction_as("CmonTotalScalarMonitors", 0, "CmonTotalScalarMonitors");
  *len += sprintf(outBuff + *len, "\n");
}     

int create_gdf_table_entry(int *row_num, int *max_gdf_entries, int *total_gdf_entries, char **ptr)
{
  if(debug_level >= 1)
    fprintf(stderr, "Method Called, row_num = %d, total_gdf_entries = %d, max_gdf_entries = %d\n",
                        *row_num, *total_gdf_entries, *max_gdf_entries);

  if (*total_gdf_entries == *max_gdf_entries) 
  {
    *ptr = realloc(*ptr, (*max_gdf_entries + GDF_DELTA_ENTRIES) * sizeof(gdf_data));

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

  if(debug_level >= 1)
    fprintf(stderr, "Method Called, row_num = %d, total_gdf_entries = %d, max_gdf_entries = %d\n",
                        *row_num, *total_gdf_entries, *max_gdf_entries);
  return 0;
}

void dump_gdf_struct_info(gdf_data *gdf_data_struct, int total_gdf_entries)
{
  fprintf(stderr, "%s, total_gdf_enries is %d \n",__FUNCTION__, total_gdf_entries);
  gdf_data *gdf_data_tmp = gdf_data_struct;

  for(int row_num=0; row_num < total_gdf_entries; row_num++)
  {
    gdf_data_tmp = gdf_data_struct + row_num;
    fprintf(stderr, "Monitor Configuration data,IDX = %d, GDF = %s, numOfElement = %d, monitor_type = %d, addInterval = %d, delInterval = %d, minVectors = %d, maxVectors = %d, minData = %f, maxData = %f, mon_id = %d, numvectors = %d, frequency= %d\n", row_num, gdf_data_tmp->gdf_name, gdf_data_tmp->numOfElement, gdf_data_tmp->monitor_type, gdf_data_tmp->addInterval, gdf_data_tmp->delInterval, gdf_data_tmp->minVectors, gdf_data_tmp->maxVectors, gdf_data_tmp->minData, gdf_data_tmp->maxData, gdf_data_tmp->mon_id, gdf_data_tmp->numvectors, gdf_data_tmp->frequency);
  }
}

int get_tokens_with_multi_delimiter(char *read_buf, char *fields[], char *token, int max_flds)
{
  int totalFlds = 0;
  char *ptr;
  char *token_ptr;
  char *rest;

  ptr = read_buf;
  while((token_ptr = strtok_r(ptr, token, &rest)) != NULL)
  {
    ptr = NULL;
    totalFlds++;
    if(totalFlds > max_flds)
    {
      //fprintf(stderr, "Total fields are more than max fields (%d), remaining fields are ignored\n", max_flds);
      totalFlds = max_flds;
      break;  /* break from while */
    }
    ptr = rest;
    fields[totalFlds - 1] = token_ptr;
  }
  return(totalFlds);
}

int fill_gdf_data(gdf_data **gdf_data_struct, char *gdf_name, int mon_id, int *total_gdf_entries, int *max_gdf_entries, int frequency)
{
  int idx;
  int row_num = 0;
  gdf_data *gdf_data_struct_tmp = *gdf_data_struct;

  if(debug_level >= 2)
  fprintf(stdout, "Method Called. total_gdf_entries = %d, gdf name = %s\n", *total_gdf_entries, gdf_name); 

  ns_save_string(gdf_name,"DV_GDFName");
  ns_eval_string("{DV_GDFName}");
  if(!strcmp("", ns_eval_string("{NumberOfElement}")))
  {
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
   if(debug_level >= 2)
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
  char *field[460]; 
  char *read_buf = ns_eval_string("{Data}");
  int no_tokens = get_tokens_with_multi_delimiter(read_buf, field, ":|", 460);
  for(int i=0; i<gdf_data_struct_tmp->numOfElement; i++)
  {
    gdf_data_struct_tmp->maxData[i] = atof(field[i*2]);
    gdf_data_struct_tmp->minData[i] = atof(field[(i*2)+1]);
     if(debug_level >= 1)
    fprintf(stderr, "min data %f and max data %f\n", gdf_data_struct_tmp->maxData[i], gdf_data_struct_tmp->minData[i]);
  } 
  gdf_data_struct_tmp->mon_id = mon_id;
  gdf_data_struct_tmp->frequency = frequency;
  gdf_data_struct_tmp->slot_used = 1;
  gdf_data_struct_tmp->last_time_data_sent = 0;

  if(gdf_data_struct_tmp->monitor_type == DVM_MONITOR)
     gdf_data_struct_tmp->numvectors = (int)gen_random_val(gdf_data_struct_tmp->minVectors, gdf_data_struct_tmp->maxVectors);

  if(debug_level >= 1)
    dump_gdf_struct_info(*gdf_data_struct, *total_gdf_entries);

  if(debug_level >= 1)
    fprintf(stderr, "Returning with total_gdf_entries = %d, gdf name = %s\n", *total_gdf_entries, gdf_name); 

  return 0;
}

int parse_hb_response_message(char *recd_msg, int recd_msg_size, gdf_data **gdf_data_struct, int *total_gdf_entries, int *max_gdf_entries, int *testidx)
{
  char gdf_name[128] = "\0";
  int mon_id,frequency;
  char *decoded_recd_msg = ns_decode_url(recd_msg, recd_msg_size);

  if(debug_level >= 1)
    fprintf(stderr, "Decoded msg = %s", decoded_recd_msg);

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

  if(debug_level >= 4)
    fprintf(stdout, " Got cm_init_monitor in response. Going to parse the message. userID = %d, nvmID = %d\n",  ns_get_userid(), ns_get_nvmid());

  //This is init message now get the mon id and gdf name
  char *ptr = strstr(decoded_recd_msg, "MON_ID");
  
  // Manish: Adding check to avoid core dump
  if(!ptr)
    return 1; 

  char *ptr2 = strchr(ptr, '=');

  if(!ptr2)
    return 1;

  ptr2++;
  mon_id = atoi(ptr2);

  char *ptr3 = strstr(decoded_recd_msg, "MON_FREQUENCY");

  if(!ptr3)
    return 1;

  char *freq_ptr = strchr(ptr3,'=');
   
   freq_ptr++;
   frequency = atoi(freq_ptr);

  if(debug_level >= 1)
    fprintf(stderr, "Monitor id = %d , frequnecy = %d\n", mon_id, frequency);

  //Now get GDF name
  //MON_GDF=/home/cavisson/MSSQL_Monitoring/sys/cm_mssql_server_statsV2.gdf;MON_PGM
  ptr = strstr(decoded_recd_msg, "MON_GDF");
	
    if(!ptr)
    return 1;

  ptr = strstr(ptr, "cm_");//Pointing to start of the gdf name

    if(!ptr)
    return 1;

  ptr2 = strchr(ptr, ';');

  *ptr2 = '\0'; 
  //copy gdf name into buffer
  strcpy(gdf_name, ptr);

  if(debug_level >= 1)
    fprintf (stderr,"gdf name is %s\n\n\n",gdf_name);
  
  int ret = fill_gdf_data(gdf_data_struct, gdf_name, mon_id, total_gdf_entries, max_gdf_entries, frequency);
  return ret; //Return 0 as we got init monitor
}

void make_monitor_data(gdf_data *gdf_data_struct, char *buffer, int total_gdf_entries)
{
  int idx;
  int len = 0;
  //for( idx = 0; idx < total_gdf_entries; ++idx )

     if(gdf_data_struct->slot_used)
     {
       if(gdf_data_struct->monitor_type == CUSTOM_MONITOR)
         get_custom_monitor_data(gdf_data_struct, buffer,  &len);
       else if(gdf_data_struct->monitor_type == DVM_MONITOR)
       {
         get_dvm_monitor_data(gdf_data_struct, buffer, &len);
       }
     }
  //   fprintf(stderr, "\n\n\n\n Data size in buffer = %d\n", len);


  if(debug_level >= 1)
    fprintf(stderr, "\n\n\n\n****** gdf_name %s and  outgoing mesage buffer is %s\n ",gdf_data_struct->gdf_name , buffer);
   //send_monitor_data_to_ndc_on_data_conn(buffer);
}
