#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ns_string.h"
//#include "tsdb_tree_query.h"
//#include <lz4frame.h>
//#include "tsdb_msg_interface.h"
#include "tsdb_tree_call_util.c"
#include "tsdb_req_resp.c"

int dbuff_sz = 0;
/*char *decompress_buffer;
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
}*/

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
		 "ID={Tree_ID}",
                 "PROTOCOL=TCP",
                 "REMOTE_HOST={TSDB_HOST}" //server ip
                );
  
  ns_end_transaction("TreeCallConnect", NS_AUTO_STATUS);
  //while(!ns_is_rampdown_user())
  {
      tsdb_query_by_tree_set_req_fields(&tsdb_tree_call);
	
      int msg_len = create_req_for_init_call(&tsdb_tree_call);
	
	  
        #ifdef TSDB_QUERY_LOGGING
	  fprintf(query_log_fp, "\n\ntotal_size = %d, msg_size = %d\n\n", msg_len, *((uint32_t *)(tsdb_dc_ptr->buffer)));
	#endif
          	
	  ns_save_binary_val((char*)(tsdb_dc_ptr->buffer) + 4, "send_data" , msg_len - 4);
	  
	  ns_start_transaction(TSDB_TCI_TX_NAME);
	
	  // Send request
	  int ret = ns_socket_send("STEP=SocketSend",
			 "ID={Tree_ID}",
	                 "LEN_FMT=4:B:L",
		         "MSG_FMT=B:N",
			 "MESSAGE={send_data}"
	                );
	
           if(ret != 0)
           {
	     ns_end_transaction_as(TSDB_TCI_TX_NAME, NS_AUTO_STATUS, "Tree_Init_Call_SendErr");
             goto close_connection;
           }
	    // Read response from server
	  ret = ns_socket_recv("STEP=SocketRecv",
				   "ID={Tree_ID}",
				   "LEN_FMT=4:B:L",
	                           "MSG_FMT=B:N",
	                           "MESSAGE={rec_buffer}",
	                           "TIMEOUT=30"
	                          );
	  
           if(ret != 0)
           {
	     ns_end_transaction_as(TSDB_TCI_TX_NAME, NS_AUTO_STATUS, "Tree_Init_Call_RecvErr");
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
           int id_type;
	   tsdb_parse_response(recv_buffer - 4, msg_size, &tsdb_dc_ptr, counter, &id_type);

	  int tsdb_tx_time;
          tsdb_dc_ptr->msg_length = msg_size - (sizeof(TSDB_Resp_Tree_t) + tsdb_dc_ptr->rt_hdr_node) ;

	  // We need to send after parse of response as tx name will depend on the response 
	  //tsdb_tree_init_query_set_tx_name(&tsdb_tree_call, &tsdb_tx_time); // set tx name
	  ns_end_transaction_as(TSDB_TCI_TX_NAME, NS_AUTO_STATUS, tsdb_dc_ptr->tx_name);
  //        ns_page_think_time(0.01);

       int tsdb_tx_res = atoi(ns_eval_string("{TSDB_RES_Time_TX}"));
       
       if(tsdb_tx_res == 1)
       {
       strcat(tsdb_dc_ptr->tx_name, "_TSDB");
       ns_start_transaction(tsdb_dc_ptr->tx_name);
       //printf("tx_time = %d, tsdb_rt = %d, rt= %f\n", tsdb_tx_time, tsdb_dc_ptr->rep_tsdb_rt, (double)( tsdb_dc_ptr->rep_tsdb_rt));
       ns_page_think_time((double)(tsdb_dc_ptr->rep_tsdb_rt) / 1000000);
       ns_end_transaction(tsdb_dc_ptr->tx_name, NS_AUTO_STATUS);     
       }
       while(1)
       {
         msg_len = create_req_for_expand_call(&tsdb_tree_call, counter);
         
        #ifdef TSDB_QUERY_LOGGING
        fprintf(query_log_fp, "\n\ntotal_size = %d, msg_size = %d,exp_counter = %d\n\n",
                 msg_len, *((uint32_t *)(tsdb_dc_ptr->buffer)), counter);
        #endif

          ns_save_binary_val((char*)(tsdb_dc_ptr->buffer) + 4, "send_data" , msg_len - 4);

          ns_start_transaction(TSDB_TCE_TX_NAME);
          
           // Send request
          ret = ns_socket_send("STEP=SocketSend_1",
			 "ID={Tree_ID}",
                         "LEN_FMT=4:B:L",
                         "MSG_FMT=B:N",
                         "MESSAGE={send_data}"
                        );

           if(ret != 0)
           {
             ns_end_transaction_as(TSDB_TCE_TX_NAME, NS_AUTO_STATUS, "Tree_Expand_Call_SendErr");
             goto close_connection;
           }
            // Read response from server
          ret = ns_socket_recv("STEP=SocketRecv_1",
				   "ID={Tree_ID}",
                                   "LEN_FMT=4:B:L",
                                   "MSG_FMT=B:N",
                                   "MESSAGE={rec_buffer_1}",
                                   "TIMEOUT=60"   // 30 was changed to 60 due to TO
                                  );

           if(ret != 0)
           {
             ns_end_transaction_as(TSDB_TCE_TX_NAME, NS_AUTO_STATUS, "Tree_Expand_Call_RecvErr");
             goto close_connection;
           }
          
          int mesg_size; 
          char *recv_buffer_1 = ns_url_get_body_msg(&mesg_size);
          if(recv_buffer_1 == NULL)
            goto close_connection;

        #ifdef TSDB_QUERY_LOGGING
          fprintf(query_log_fp, "\n\nread_status: %d, rec_buff_size: %d, opcode: %d\n\n", ret, mesg_size, *((uint16_t *)recv_buffer_1));
        #endif
          
         /*//Decompression
          char *resp_buffer = recv_buffer - 4;

          MsgHdr_t *msg_hdr = (MsgHdr_t *)resp_buffer;

         if(msg_hdr->flags & TSDB_RESPONSE_COMPRESSED) {
             decompress_response(resp_buffer, &decompress_buffer, &dbuff_sz);
             resp_buffer = decompress_buffer;
          }*/


          // Parse response
          int ret = tsdb_parse_response(recv_buffer_1 - 4, mesg_size, &tsdb_dc_ptr, counter, &id_type);
          tsdb_dc_ptr->Ex_len =  mesg_size - (sizeof(TSDB_Resp_Tree_t) + tsdb_dc_ptr->rt_hdr_node) ;;

          //tsdb_tree_expand_query_set_tx_name(&tsdb_tree_call, &tsdb_tx_time); // set tx name
          ns_end_transaction_as(TSDB_TCE_TX_NAME, NS_AUTO_STATUS, tsdb_dc_ptr->tx_name);
   //       ns_page_think_time(0.01);
        
          int tsdb_tx_res = atoi(ns_eval_string("{TSDB_RES_Time_TX}"));        

        if(tsdb_tx_res == 1)
         {
           strcat(tsdb_dc_ptr->tx_name, "TSDB");
           ns_start_transaction(tsdb_dc_ptr->tx_name);
          #ifdef TSDB_QUERY_LOGGING 
          fprintf(query_log_fp,"tx_time = %d, tsdb_rt = %d, rt= %f\n", tsdb_tx_time, tsdb_dc_ptr->rep_tsdb_rt, (double)( tsdb_dc_ptr->rep_tsdb_rt) / 1000000);
          #endif
           ns_page_think_time((double)(tsdb_dc_ptr->rep_tsdb_rt) / 1000000);
           ns_end_transaction(tsdb_dc_ptr->tx_name, NS_AUTO_STATUS);
         }
         if(ret == 999)
         {
           #ifdef TSDB_QUERY_LOGGING
           fprintf(query_log_fp,"Failed - %d", ret);
          #endif
         }

    //TODO apply check if type id =3 then exit the for loop  
     if(id_type == 3)
     {
       #ifdef TSDB_QUERY_LOGGING
       fprintf(query_log_fp, "Metric is leaf node. Can't expand beyond");
       #endif
       break;
     }
    }
}
  close_connection:
  // Close Socket
  ns_page_think_time(1);
  ns_start_transaction("TreeCallClose");
  ns_socket_close("STEP=SocketClose", "ID={Tree_ID}");
  ns_end_transaction("TreeCallClose", NS_AUTO_STATUS);

  return;
}
