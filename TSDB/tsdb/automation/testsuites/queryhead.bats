#!/home/cavisson/bin/bats

get_metric() {
 #  if [ $TAG_FLAG -eq 1 ];then
  #   automation_log "1....TAG_FLAG=$TAG_FLAG"
   #  METRIC_LINE=`grep "Tier:datacall-tier" $METRIC_FILE | grep "tags:" | shuf -n 1`
   #else
     METRIC_LINE=`grep "Tier:datacall-tier" $METRIC_FILE |grep -v "tags"| shuf -n 1`
  # fi
   
   METRIC_ID=`echo $METRIC_LINE | cut -d',' -f1` 
   NFIDX=`echo $METRIC_LINE | cut -d',' -f2`
   #TAGS=`echo $METRIC_LINE | cut -d'"' -f2`
   SUBJECT=`echo $METRIC_LINE | cut -d"," -f3`
   #if [ $TAG_FLAG -eq 1 ];then
    #  MEASURE=`echo $METRIC_LINE | rev | cut -d',' -f2-4|rev`
  # else
   MEASURE=`echo $METRIC_LINE | cut -d"," -f4-6`
   #fi
   #MEASURE=`echo $METRIC_LINE | rev | cut -d"," -f2-4 | rev`
   echo "export METRIC_LINE='$METRIC_LINE'" > ${MT_DETAIL_FILE}
   echo "export METRIC_ID=$METRIC_ID" >> ${MT_DETAIL_FILE}
   echo "export NFIDX=$NFIDX" >> ${MT_DETAIL_FILE}
   echo "export SUBJECT='$SUBJECT'" >> ${MT_DETAIL_FILE}
   echo "export MEASURE='$MEASURE'" >> ${MT_DETAIL_FILE}
   #echo "export TAGS='$TAGS'" >> ${MT_DETAIL_FILE}
}

setup() {
  source ./testsuites/common
  common_setup
  source $QUERYHEAD_LIB/queryhread_lib
  #export RESPONSE_FILE="$DATA_REP/DC_${BATS_TEST_NUMBER}".txt
  #if [ $BATS_TEST_NUMBER -eq 1 ];then
   #  if [ $MODE -eq 1 ] ;then
    #    export MT_DETAIL_FILE="MetricDetails.conf"
    # else
  #      get_metric
     #fi
 # fi
  
 # source ${MT_DETAIL_FILE}
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
 # export DT_FILTER=()
}

@test '[QH-001] Queryhead Status Check ' {
    check_queryhead_status
    output=$(validate_response)
    assert_output "pass"
}
@test '[QH-002] New PID generation for nsi_check_query_head after killing the original process' {
    query_head_pid=$(pgrep -f "bin/query_head")
    kill -9 $query_head_pid
    sleep 10
    check_nsi_check_query_head_running
    output=$(validate_response)
    assert_output "pass"
}

@test '[QH-003] QueryHead Recovery Check' {
    check_queryhead_recovery_status
    output=$(validate_response)
    assert_output "pass"
}

@test '[TM-001] tsdb_main process is running for the stopped TR' {
    check_tsdb_main_running
    output=$(validate_response)
    output=$(validate_response)

}

