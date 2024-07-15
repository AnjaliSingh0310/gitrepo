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
  source $ALERT_LIB/alert_lib
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

#------------------------------------------------ Alert Global Configuration -------------------------------------------------------------

#   automation_log "tsdb_admin --op al-gc --alert-file ${ALERT_FILE} --port ${PORT}"
 #  tsdb_admin --op al-gc --alert-file ${ALERT_FILE} --port ${PORT} > ${RESPONSE_FILE} 2>/dev/null
   

@test '[AL-GC001] Global Configuration check ' {
    check_global_config
    output=$(validate_alert_response)
    assert_output "PASS" 
}

@test '[AL-GC002] Global Configuration Rule Scheduling check ' {
    check_rule_scheduling_global_config
    output=$(validate_alert_response)
    assert_output "PASS" 
}

@test '[AL-GM003] Global Maintenance check' {
    check_global_maintenance
    output=$(validate_alert_response)
    assert_output "PASS" 
}

@test '[AL-RC001] Rule Recovery check ' {
    check_rule_recovery  
    output=$(validate_alert_response)
    automation_log "recovery_flg_done"
    assert_output "PASS"
}

@test '[AL-FC001] Force Clear check ' {
    check_force_clear   
    output=$(validate_alert_response)
    assert_output "PASS"
}

@test '[AL-CP001] Rule ID Consistency Test' {
    #test_rule_id_consistency
    check_persistence
    output=$(validate_alert_response)
    assert_output "PASS"
}
