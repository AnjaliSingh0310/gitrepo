#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ns_string.h"
#include "tsdb_meta_call_util.c"
//#include "tsdb_req_resp.c"

char metric_value; 
void tsdb_meta_data_open_merge()
{
  TSDBMetaCall tsdb_meta_call, *tsdb_dc_ptr;
  
  tsdb_dc_ptr = &tsdb_meta_call;

  tsdb_meta_data_query_init(&tsdb_meta_call);

  ns_start_transaction("MetaDataCallConnect");
  // Socket connection
  ns_socket_open("STEP=SocketOpen",
                 "ID=0",
                 "PROTOCOL=TCP",
                 "REMOTE_HOST={TSDB_HOST}" //server ip
                );
  
  ns_end_transaction("MetaDataCallConnect", NS_AUTO_STATUS);
  //while(!ns_is_rampdown_user())
  {
    tsdb_query_by_meta_data_set_req_fields(&tsdb_meta_call);
    int msg_len = create_req_for_meta_data_open_merge_call(&tsdb_meta_call);
	
    #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "\n\ntotal_size = %d, msg_size = %d\n\n", msg_len, *((uint32_t *)(tsdb_dc_ptr->buffer)));
    #endif
          	
    ns_save_binary_val((char*)(tsdb_dc_ptr->buffer) + 4, "send_data" , msg_len - 4);
	  
    ns_start_transaction(TSDB_MD_OM_TX_NAME);
	
   // Send request
    int ret = ns_socket_send("STEP=SocketSend",
	                 "ID=0",
	                 "LEN_FMT=4:B:L",
		         "MSG_FMT=B:N",
			 "MESSAGE={send_data}"
	                );
	
   if(ret != 0)
   {
     ns_end_transaction_as(TSDB_MD_OM_TX_NAME, NS_AUTO_STATUS, "Meta_Data_Open_Merge_Call_SendErr");
     goto close_connection;
    }
	    // Read response from server
   ret = ns_socket_recv("STEP=SocketRecv",
	                           "ID=0",
				   "LEN_FMT=4:B:L",
	                           "MSG_FMT=B:N",
	                           "MESSAGE={rec_buffer}",
	                           "TIMEOUT=30"
	                          );
	  
   if(ret != 0)
   {
      ns_end_transaction_as(TSDB_MD_OM_TX_NAME, NS_AUTO_STATUS, "Meta_Data_Open_Merge_Call_RecvErr");
     goto close_connection;
   }
	
   int msg_size;
   char *recv_buffer = ns_url_get_body_msg(&msg_size);
   if(recv_buffer == NULL)
   goto close_connection;
	  
   #ifdef TSDB_QUERY_LOGGING
       fprintf(query_log_fp, "\n\nread_status: %d, rec_buff_size: %d, opcode: %d\n\n", ret, msg_size, *((uint16_t *)recv_buffer));
   #endif
        	
   // Parse response
   tsdb_parse_response(recv_buffer - 4, msg_size, &tsdb_meta_call);

   int tsdb_tx_time;
  // We need to send after parse of response as tx name will depend on the response 
   tsdb_meta_data_open_merge_set_tx_name(&tsdb_meta_call, &tsdb_tx_time); // set tx name
   ns_end_transaction_as(TSDB_MD_OM_TX_NAME, NS_AUTO_STATUS, tsdb_dc_ptr->tx_name);
   ns_page_think_time(0.01);

  int tsdb_tx_res = atoi(ns_eval_string("{TSDB_RES_Time_TX}"));
       
  if(tsdb_tx_res == 1)
  {
       strcat(tsdb_dc_ptr->tx_name, "_TSDB");
       
       ns_start_transaction(tsdb_dc_ptr->tx_name);
       
       //printf("tx_time = %d, tsdb_rt = %d, rt= %f\n", tsdb_tx_time, tsdb_dc_ptr->rep_tsdb_rt, (double)( tsdb_dc_ptr->rep_tsdb_rt));
                  
       ns_page_think_time((double)(tsdb_dc_ptr->rep_tsdb_rt) / 1000);

       ns_end_transaction(tsdb_dc_ptr->tx_name, NS_AUTO_STATUS);     
   }
  }
  close_connection:
  // Close Socket
  ns_page_think_time(1);
  ns_start_transaction("MetaDataCallClose");
  ns_socket_close("STEP=SocketClose", "ID=0");
  ns_end_transaction("MetaDataCallClose", NS_AUTO_STATUS);

  return;
}
