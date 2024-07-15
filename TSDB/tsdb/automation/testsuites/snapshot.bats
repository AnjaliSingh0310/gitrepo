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
  source $SNAPSHOT_LIB/snapshot_lib
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


@test '[SS-001] Snapshot Recovery Check' {
    check_recovery_from_snapshot
    output=$(validate_response)
    assert_output "PASS"
}


@test '[SS-002] check TSDB_SNAPSHOT_SETTINGS disable' {
    
   value_from_file=$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' $NS_WDIR/MVTKeywords.dat | grep -w "TSDB_SNAPSHOT_SETTINGS 0")
   
   if [ -n "$value_from_file" ]; then

       if [ "$value_from_file" == "TSDB_SNAPSHOT_SETTINGS 0" ]; then
           automation_log "no directory is created when snapshot is disabled"
           result=0 #pass
       else
           automation_log "Snapshot are enabled"
           result=1 #fail
       fi
   else 
       automation_log "Disable Keyword is not present and Snapshot are enabled"
       result=1 
   fi  
       
    output=$(validate_response)
    assert_output "PASS"
}

@test '[SS-003] check TSDB_SNAPSHOT_RETENTION disable' {
    
   value_from_file=$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' "$NS_WDIR/MVTKeywords.dat" | grep "^TSDB_SNAPSHOT_RETENTION 0")

   if [ -n "$value_from_file" ]; then

     if [ "$value_from_file" == "TSDB_SNAPSHOT_RETENTION 0" ]; then
        automation_log "retention policy disable is applied then the snapshot directory is deleted"
        result=0 #Pass
     else
       automation_log "retention policy is not applied then the snapshot directory is deleted"
       result=1
     fi
   else 
       automation_log "Keyword is not present"
       result=1 # Fail
   fi  
       
    output=$(validate_response)
    assert_output "PASS"
}

@test "[SS-004] Cav_tsdb is Running check " {
    check_cav_tsdb_running
    output=$(validate_response)
    assert_output "PASS"
}

