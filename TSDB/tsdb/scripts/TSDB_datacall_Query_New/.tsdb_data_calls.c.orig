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

int dbuff_sz = 0;
char *decompress_buffer;
#define EXIT_IF_ERROR(b) { \
  if (LZ4F_isError(b)) { \
    printf("Line: %d | Compression/Decompression failed: %s\n", __LINE__, LZ4F_getErrorName(b)); \
    exit(1); \
  } \
}
static size_t get_block_size(const LZ4F_frameInfo_t* info) {
  switch (info->blockSizeID) {
    case LZ4F_default:
    case LZ4F_max64KB:  return 1 << 16;
    case LZ4F_max256KB: return 1 << 18;
    case LZ4F_max1MB:   return 1 << 20;
    case LZ4F_max4MB:   return 1 << 22;
    default:
      printf("Impossible with expected frame specification (<=v1.6.1)\n");
      exit(1);
  }
}
static void decompress_response(char *cbuff, char **dbuff, int *dbuff_sz) //Compression
{

  *dbuff_sz = 1024;
  *dbuff = realloc(*dbuff, *dbuff_sz);
  // Handle MsgHdr
  memcpy(*dbuff, cbuff, sizeof(MsgHdr_t));

  struct LZ4F_dctx_s* dctx;
  int res = LZ4F_createDecompressionContext(&dctx, LZ4F_VERSION);
  EXIT_IF_ERROR(res);

  LZ4F_frameInfo_t info;
  size_t d_consumed_sz = *dbuff_sz;
  size_t c_consumed_sz = LZ4F_HEADER_SIZE_MAX;

  size_t expected_sz;
  size_t d_offset = sizeof(MsgHdr_t);
  size_t c_offset = sizeof(MsgHdr_t);

  // get frame info
  expected_sz = LZ4F_getFrameInfo(dctx, &info, cbuff + c_offset, &c_consumed_sz);
  EXIT_IF_ERROR(expected_sz);
  c_offset += c_consumed_sz;

  int block_sz = get_block_size(&info);
  
  while(expected_sz) {
    if((*dbuff_sz - d_offset) < block_sz) {
      *dbuff_sz += block_sz;
      *dbuff = realloc(*dbuff, *dbuff_sz);
    }

    c_consumed_sz = expected_sz;
    d_consumed_sz = *dbuff_sz;

    expected_sz = LZ4F_decompress(dctx, *dbuff + d_offset, &d_consumed_sz, cbuff + c_offset, &c_consumed_sz, NULL);
    EXIT_IF_ERROR(expected_sz);

    d_offset += d_consumed_sz;
    c_offset += c_consumed_sz;
  }

  LZ4F_freeDecompressionContext(dctx);
}

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
                 //"REMOTE_HOST=184.105.177.99:8891" //server ip
                 //"REMOTE_HOST=207.231.105.130:8000" //server ip
                );
  
  ns_end_transaction("DataCallConnect", NS_AUTO_STATUS);

   while(!ns_is_rampdown_user())
    {
     	
	  tsdb_query_by_name_set_req_fields(&tsdb_data_call);
	
	  
	  //int msg_len = create_req_for_data_call_by_name(&tsdb_data_call);
	  int msg_len = create_req_for_data_call(&tsdb_data_call);
	
	  
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
	
	  //fprintf(stderr, "Reading Response done\n");
	  #if 1
	  int msg_size;
	  char *recv_buffer = ns_url_get_body_msg(&msg_size);
	  if(recv_buffer == NULL)
            goto close_connection;
	  
	//#ifdef NS_DEBUG_ON
        #ifdef TSDB_QUERY_LOGGING
	  fprintf(query_log_fp, "\n\nread_status: %d, rec_buff_size: %d, opcode: %d\n\n", ret, msg_size, *((uint16_t *)recv_buffer));
	#endif

          //Decompression
          char *resp_buffer = recv_buffer - 4;
 
          MsgHdr_t *msg_hdr = (MsgHdr_t *)resp_buffer;

         if(msg_hdr->flags & TSDB_RESPONSE_COMPRESSED) {
             decompress_response(resp_buffer, &decompress_buffer, &dbuff_sz);
             resp_buffer = decompress_buffer;
          }
	 
          // Parse response
	  tsdb_parse_response(resp_buffer, msg_size, &tsdb_data_call);
	
	  #endif
	
	  int tsdb_tx_time;
	  // We need to send after parse of response as tx name will depend on the response 
	  tsdb_data_query_set_tx_name(&tsdb_data_call, &tsdb_tx_time); // set tx name
	  ns_end_transaction_as(TSDB_DC_TX_NAME, NS_AUTO_STATUS, tsdb_dc_ptr->tx_name);
      
       int tsdb_tx_res = atoi(ns_eval_string("{TSDB_RES_Time_TX}"));
       double think_time;  
       if(tsdb_tx_res == 1)
       {
         // Check if response time is less than 1000 microseconds (0 to 999 MicroSec)
       /*  if ((double)(tsdb_dc_ptr->rep_tsdb_rt) < 1000)
         {
	  // Assume time is in milli-seconds and then convert to seconds (divide by 1000)
	 //   Here we are converting as we cannot have think time < 1 ms (.001 seconds)
	 //   So reported tx time is in microseconds e.g. 1 sec in tx detail UI will be 1 microsec
	 // To show in ms, we need to divide by 1000 after exporting in Excel. 
	 //   For example, if tx time is 15 (this is in microseconds), then it will be 15/1000 = 0.015 milliseconds)
    
	   think_time = (double)(tsdb_dc_ptr->rep_tsdb_rt)/1000;
           strcat(tsdb_dc_ptr->tx_name, "_TSDB_MicroSec");
         }
         else*/
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
