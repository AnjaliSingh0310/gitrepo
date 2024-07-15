#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ns_string.h"
#include "tsdb_tree_call_util.c"
#include "tsdb_req_resp.c"

char metric_value; 
void tsdb_tree_call()
{
  TSDBDataCall tsdb_tree_call, *tsdb_dc_ptr;
  
  int counter = 0;
  tsdb_dc_ptr = &tsdb_tree_call;

  tsdb_query_by_tree_init(&tsdb_tree_call);

  ns_start_transaction("TreeCallConnect");
  // Socket connection
  ns_socket_open("STEP=SocketOpen",
		 "ID={Tree_Search_ID}",
                 "PROTOCOL=TCP",
                 "REMOTE_HOST={TSDB_HOST}" //server ip
                );
  
  ns_end_transaction("TreeCallConnect", NS_AUTO_STATUS);
 while(!ns_is_rampdown_user())
  {
    tsdb_query_by_tree_set_req_fields(&tsdb_tree_call);
    int msg_len = create_req_for_tree_search_call(&tsdb_tree_call);
	
    #ifdef TSDB_QUERY_LOGGING
      fprintf(query_log_fp, "\n\ntotal_size = %d, msg_size = %d\n\n", msg_len, *((uint32_t *)(tsdb_dc_ptr->buffer)));
    #endif
          	
    ns_save_binary_val((char*)(tsdb_dc_ptr->buffer) + 4, "send_data" , msg_len - 4);
	  
    ns_start_transaction(TSDB_TCS_TX_NAME);
	
	  // Send request
    int ret = ns_socket_send("STEP=SocketSend",
	                 "ID={Tree_Search_ID}",
	                 "LEN_FMT=4:B:L",
		         "MSG_FMT=B:N",
			 "MESSAGE={send_data}"
	                );
	
   if(ret != 0)
   {
     ns_end_transaction_as(TSDB_TCS_TX_NAME, NS_AUTO_STATUS, "Tree_Search_Call_SendErr");
     goto close_connection;
    }
	    // Read response from server
   ret = ns_socket_recv("STEP=SocketRecv",
	                           "ID={Tree_Search_ID}",
				   "LEN_FMT=4:B:L",
	                           "MSG_FMT=B:N",
	                           "MESSAGE={rec_buffer}",
	                           "TIMEOUT=60"
	                          );
	  
   if(ret != 0)
   {
      ns_end_transaction_as(TSDB_TCS_TX_NAME, NS_AUTO_STATUS, "Tree_Search_Call_RecvErr");
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
   tsdb_parse_response(recv_buffer - 4, msg_size, &tsdb_dc_ptr, counter);

   int tsdb_tx_time;
   tsdb_dc_ptr->tree_size = msg_size - (sizeof(TSDB_Resp_Tree_t) + tsdb_dc_ptr->rt_hdr_node);
  // We need to send after parse of response as tx name will depend on the response 
 //  tsdb_tree_search_query_set_tx_name(&tsdb_tree_call, &tsdb_tx_time); // set tx name
   ns_end_transaction_as(TSDB_TCS_TX_NAME, NS_AUTO_STATUS, tsdb_dc_ptr->tx_name);
//   ns_page_think_time(0.01);

  int tsdb_tx_res = atoi(ns_eval_string("{TSDB_RES_Time_TX}"));
      
  if(tsdb_tx_res == 1)
   {
      strcat(tsdb_dc_ptr->tx_name, "TSDB");
      ns_start_transaction(tsdb_dc_ptr->tx_name);
      //printf("tx_time = %d, tsdb_rt = %d, rt= %f\n", tsdb_tx_time, tsdb_dc_ptr->rep_tsdb_rt, (double)( tsdb_dc_ptr->rep_tsdb_rt) / 1000000);
      ns_page_think_time((double)(tsdb_dc_ptr->rep_tsdb_rt) / 1000000);
      ns_end_transaction(tsdb_dc_ptr->tx_name, NS_AUTO_STATUS);
   }

  }
  close_connection:
  // Close Socket
  ns_page_think_time(1);
  ns_start_transaction("TreeCallClose");
  ns_socket_close("STEP=SocketClose", "ID={Tree_Search_ID}");
  ns_end_transaction("TreeCallClose", NS_AUTO_STATUS);

  return;
}
