#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ns_string.h"
#include <errno.h>
#include <time.h>

//#include "tsdb_data_query.h"
#include <lz4frame.h>
//#include "tsdb_msg_interface.h"
#include "tsdb_data_call_util.c"

void tsdb_data_calls()
{
  TSDBDataCall tsdb_data_call, *tsdb_dc_ptr;
  tsdb_dc_ptr = &tsdb_data_call;
  tsdb_query_by_name_init(&tsdb_data_call);
  ns_start_transaction("DataCallConnect");
  // Socket connection
  ns_socket_open("STEP=SOCKETOPEN",
                 "ID=0",
                 "PROTOCOL=TCP",
                 "REMOTE_HOST={TSDB_HOST}" //server ip
                );
  
  ns_end_transaction("DataCallConnect", NS_AUTO_STATUS);

 //while(!ns_is_rampdown_user())
  {
	  tsdb_query_by_name_set_req_fields(&tsdb_data_call);
	  int msg_len = create_req_for_alert_global_config(tsdb_data_call.buffer, &tsdb_data_call);
	  
//	#ifdef NS_DEBUG_ON
        #ifdef TSDB_QUERY_LOGGING
	  fprintf(query_log_fp, "\n\ntotal_size = %d, msg_size = %d\n\n", msg_len, *((uint32_t *)(tsdb_dc_ptr->buffer)));
	#endif
	
	  ns_save_binary_val((char*)(tsdb_dc_ptr->buffer) + 4, "send_data" , msg_len - 4);
	  
	  ns_start_transaction(TSDB_DC_TX_NAME);
	
	  //fprintf(stderr, "Sending request\n");
	
	  // Send request
	  int ret = ns_socket_send("STEP=SocketSend",
	                 "ID=0",
	                 "LEN_FMT=4:B:L",
		         "MSG_FMT=B:N",
			 "MESSAGE={send_data}",
	                );
	
           if(ret != 0)
           {
	     ns_end_transaction_as(TSDB_DC_TX_NAME, NS_AUTO_STATUS, "DataCallByNameSendErr");
             goto close_connection;
           }
	  //fprintf(stderr, "Reading Response\n");
	    // Read response from server
	  ret = ns_socket_recv("STEP=SocketRecv",
	                           "ID=0",
				   "LEN_FMT=4:B:L",
	                           "MSG_FMT=B:N",
	                           "MESSAGE={rec_buffer}",
	                           "TIMEOUT=60",
	                          );
	  
           if(ret != 0)
           {
	     ns_end_transaction_as(TSDB_DC_TX_NAME, NS_AUTO_STATUS, "DataCallByNameRecvErr");
             goto close_connection;
           }

	  int msg_size;
	  char *recv_buffer = ns_url_get_body_msg(&msg_size);
	  if(recv_buffer == NULL)
            goto close_connection;
	  
	//#ifdef NS_DEBUG_ON
        #ifdef TSDB_QUERY_LOGGING
	  fprintf(query_log_fp, "\n\nread_status: %d, rec_buff_size: %d, opcode: %d\n\n", ret, msg_size, *((uint16_t *)recv_buffer));
	#endif

	 
          // Parse response
	  tsdb_parse_response(recv_buffer - 4, msg_size, &tsdb_data_call);
	
	  int tsdb_tx_time;
	  // We need to send after parse of response as tx name will depend on the response 
	  tsdb_data_query_set_tx_name(&tsdb_data_call, &tsdb_tx_time); // set tx name
	  ns_end_transaction_as(TSDB_DC_TX_NAME, NS_AUTO_STATUS, tsdb_dc_ptr->tx_name);
      
       int tsdb_tx_res = atoi(ns_eval_string("{TSDB_RES_Time_TX}"));
       double think_time;  
       if(tsdb_tx_res == 1)
       {
         // Check if response time is less than 1000 microseconds (0 to 999 MicroSec)
         if ((double)(tsdb_dc_ptr->rep_tsdb_rt) < 1000)
         {
	  // Assume time is in milli-seconds and then convert to seconds (divide by 1000)
	 //   Here we are converting as we cannot have think time < 1 ms (.001 seconds)
	 //   So reported tx time is in microseconds e.g. 1 sec in tx detail UI will be 1 microsec
	 // To show in ms, we need to divide by 1000 after exporting in Excel. 
	 //   For example, if tx time is 15 (this is in microseconds), then it will be 15/1000 = 0.015 milliseconds)
    
	   think_time = (double)(tsdb_dc_ptr->rep_tsdb_rt)/1000;
           strcat(tsdb_dc_ptr->tx_name, "_TSDB_MicroSec");
         }
         else
        {
	 // Convert microseconds to seconds (divide by 1000 * 1000)
	 // Here we will loose granulaty beyong ms. 1.x ms will be reported as 1 ms.
          think_time = (double)(tsdb_dc_ptr->rep_tsdb_rt)/1000000;
          strcat(tsdb_dc_ptr->tx_name, "_TSDB");
         }
	  
	  ns_start_transaction(tsdb_dc_ptr->tx_name);
          ns_page_think_time(think_time);
          ns_end_transaction(tsdb_dc_ptr->tx_name, NS_AUTO_STATUS);
       }

   }	  

close_connection:
  // Close Socket
  ns_page_think_time(1);
  ns_start_transaction("DataCallClose");
  ns_socket_close("STEP=SocketClose", "ID=0");
  ns_end_transaction("DataCallClose", NS_AUTO_STATUS);

  return;
}
