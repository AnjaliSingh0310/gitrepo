#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ns_string.h"
#include "ns_socket_api.h"


//CMON Registration  
//1. CMON->NDC
     //cmon_ctrl_msg_req:Server=NS_70_9;tierName=DemoTier2;cmonVersion=4.1.13#21;serverIp=10.10.70.9;cmonHome=/home/cavisson/monitors;cmonPid=7925;cmonJavaHome=/home/cavisson/apps/jdk1.8.0_121/jre;cmonStartTime=1545049957483;machineType=LinuxEx;instance=CMON;hostName=netstorm-ProLiant-ML10;agentType=Java;requestType=1;lastConnectionTimeStamp=-1;connDuration=0;connDestination=NA;supportedProtocols=TCP;cmon_env_lmd=1545049161000

void sock_cmon()
{
  int ret = -1;
  int cmon_pid = 12781;
  char cmon_req[1024 + 1];
  char tier_name[64 + 1];
  char server_name[64 + 1];
  char ip[64 + 1];

  ns_advance_param("Tier");

  strcpy(tier_name, ns_eval_string("{Tier}"));
  strcpy(server_name, ns_eval_string("{Server}"));
  strcpy(ip, ns_eval_string("{IP}"));

  printf("**** tier_name = [%s], server_name = [%s], IP = %s\n", tier_name, server_name, ip);
  

  sprintf(cmon_req, "cmon_ctrl_msg_req:Server=%s;tierName=%s;"
                    "cmonVersion=4.1.13#21;serverIp=%s;cmonHome=/home/cavisson/monitors;cmonPid=%d;"
                    "cmonJavaHome=/home/cavisson/apps/jdk1.8.0_121/jre;cmonStartTime=1545049957483;machineType=LinuxEx;"
                    "instance=CMON;hostName=netstorm-ProLiant-ML10;agentType=Java;requestType=1;lastConnectionTimeStamp=-1;"
                    "connDuration=0;connDestination=NA;supportedProtocols=TCP;cmon_env_lmd=1545049161000\n", 
                     server_name, tier_name, ip, cmon_pid);
  
  ns_save_string(cmon_req, "message");
  printf("*** message = [%s]\n", ns_eval_string("{message}"));

  /* Connect to NDC */
  ns_start_transaction("ConnectToNDC");
  ret = ns_sock_create_socket("cmon_fd", "TCP", "RemoteHost=127.0.0.1:7892", LASTARG_MARKER);
  if(ret == -1)
    printf("*** Error: Unable to connect with NDC server: 127.0.0.1:7892 \n");
  ns_end_transaction("ConnectToNDC", 0);

  ns_page_think_time(1); 

  //If connection is successful then send message to register it self
  if(ret == 0) 
  {
    ns_start_transaction("Registration");
    ret = ns_sock_send("cmon_fd", "message", LASTARG_MARKER);
    ns_end_transaction("Registration", 0);

    ns_page_think_time(1); 

    printf("***  Registration: ret = %d\n", ret);

    if(ret < 0)
      printf("*** Error: CMON unable to register itself with NDC.\n"); 
    else
    {
      ns_sock_receive("cmon_fd", "read_buf", LASTARG_MARKER);
      printf("*** read_buf = [%s]\n", ns_eval_string("{read_buf}"));
    }
  }
  
  //ns_page_think_time(20); 
  ns_sock_close_socket("cmon_fd");
}
