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
  source $DATACALL_LIB/datacall_lib
  export RESPONSE_FILE="$DATA_REP/DC_${BATS_TEST_NUMBER}".txt
  if [ $BATS_TEST_NUMBER -eq 1 ];then
   #  if [ $MODE -eq 1 ] ;then
    #    export MT_DETAIL_FILE="MetricDetails.conf"
    # else
        get_metric
     #fi
  fi
  
  source ${MT_DETAIL_FILE}
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
  export DT_FILTER=()
}


#------------------------------------------------ Data call by Name ----------------------------------------------------------------

#bats test_tags=op:dcn,test:first
@test '[DC001]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS" 
}

#--------------------------------- Data Call by name with Subjectmode Pattern ---------------------------------------------------------------------

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[DC002]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC003]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC004]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC005]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#----------------------------------------------------- Data Call by name with Subject mode ALL--------------------------------------------------

#bats test_tags=tc:6,op:dcn,submode:all,test:six
@test '[DC006]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC007]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC008]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC009]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`
   
   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#---------------------------------------- Datacall uproll queries --------------------------------#
#bats test_tags=query:uproll,op:dcn,name:rah
@test '[DC010]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll' {
   GRANULARITY=$((NFIDX + 1))  
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC011]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll' {
   GRANULARITY=$((NFIDX + 1))  
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC012]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll' {
   GRANULARITY=$((NFIDX + 1))  
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC013]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll' {
   GRANULARITY=$((NFIDX + 1))  
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC014]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll' {
   GRANULARITY=$((NFIDX + 1))  
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[DC015]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll' {
   GRANULARITY=$((NFIDX + 1))  
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC016]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll' {
   GRANULARITY=$((NFIDX + 1))  
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC017]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll' {
   GRANULARITY=$((NFIDX + 1))  
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC018]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll' {
   GRANULARITY=$((NFIDX + 1))  
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#-------------------------------------------------------------data filter -------------------------------------------------------------------------

#bats test_tags=op:dcn,filter:min
@test '[DC019]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, Data-Filter=Min' {
   export DT_FILTER=(min)
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER[@]}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE[@]} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,filter:max
@test '[DC020]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, Data-Filter=Max' {
   export DT_FILTER=(max)
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"

}


#bats test_tags=op:dcn,filter:avg
@test '[DC021]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, Data-Filter=Avg' {
   export DT_FILTER=(avg)
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}



#bats test_tags=op:dcn,filter:count
@test '[DC022]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, Data-Filter=Count' {
   export DT_FILTER=(count)
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#--------------------------------- Data Call by name with Subjectmode Pattern ---------------------------------------------------------------------

#bats test_tags=op:dcn,submode:pattern,pattern:max
@test '[DC023]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, Data-filter=Max' {
   export DT_FILTER=(max)
  
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,pattern:count
@test '[DC024]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, Data-filter=Count' {
   export DT_FILTER=(count)

   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,pattern:min
@test '[DC025]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, Data-filter=Min' {
   export DT_FILTER=(min)

   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,pattern:avg
@test '[DC026]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, Data-filter=Avg' {
   export DT_FILTER=(avg)

   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------------------Data call by name with subject mode pattern server---------------------------


#bats test_tags=op:dcn,submode:pattern,mode:server
@test '[DC027]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=Avg' {
   export DT_FILTER=(avg)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,mode:server
@test '[DC028]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=Min' {
   export DT_FILTER=(min)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:server
@test '[DC029]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=Max' {
   export DT_FILTER=(max)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:server
@test '[DC030]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=Count' {
   export DT_FILTER=(count)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:server
@test '[DC031]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=max min' {
   export DT_FILTER=(max min)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------------------Data call by name with subject mode pattern instance---------------------------

#bats test_tags=op:dcn,submode:pattern,mode:instance
@test '[DC032]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=Avg' {
   export DT_FILTER=(avg)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,mode:instance
@test '[DC033]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=Min' {
   export DT_FILTER=(min)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,mode:instance
@test '[DC034]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=Max' {
   export DT_FILTER=(max)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,mode:instance
@test '[DC035]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=Count' {
   export DT_FILTER=(count)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:instance,rahul:bisht
@test '[DC036]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=min max Count ' {
   export DT_FILTER=(min max)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER[@]}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER[@]}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#----------------------------------------------Data call by name with subject mode pattern all---------------------------


#bats test_tags=op:dcn,submode:pattern,mode:all
@test '[DC037]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=Avg' {
   export DT_FILTER=(avg)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:all
@test '[DC038]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=Min' {
   export DT_FILTER=(min)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:all
@test '[DC039]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=Max' {
   export DT_FILTER=(max)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:all
@test '[DC040]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=Count' {
   export DT_FILTER=(count)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:all
@test '[DC041]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=max Count' {
   export DT_FILTER=(max count)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------------------------- Data Call by name with Subject mode ALL--------------------------------------------------

#bats test_tags=tc:6,op:dcn,submode:all
@test '[DC042]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, Data-filter=avg' {
   export DT_FILTER=(avg)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[DC043]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, Data-filter=min' {
   export DT_FILTER=(min)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[DC044]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, Data-filter=max' {
   export DT_FILTER=(max)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[DC045]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, Data-filter=count' {
   export DT_FILTER=(count)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}
#-------------------------------------------Data Call by name with Subject mode ALLserver---------------------------
#bats test_tags=op:dcn,submode:all
@test '[DC046]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=avg ' {
   export DT_FILTER=(avg)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[DC047]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=min ' {
   export DT_FILTER=(min)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC048]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=max ' {
   export DT_FILTER=(max)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC049]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=count ' {
   export DT_FILTER=(count)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC050]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=avg max ' {
   export DT_FILTER=(avg max)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#-------------------------------------------Data Call by name with Subject mode ALLinstance------------------------------------

#bats test_tags=op:dcn,submode:all
@test '[DC051]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, data-filter=avg' {
   export DT_FILTER=(avg)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first,rahul:bishtt
#@test '[DC001]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact' {
#   TAG_FLAG=1
#   automation_log "TAG_FLAG=$TAG_FLAG"
#   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --agg_flag no"
#   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --agg_flag no> ${RESPONSE_FILE} 2>/dev/null
#   set_dcn_expected_values "10" "Exact"
#   extract_actual_output
   #output=$(validate_response)
   #assert_output "PASS"
#}


#bats test_tags=op:dcn,submode:all
@test '[DC052]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, data-filter=min' {
   export DT_FILTER=(min)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[DC053]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, data-filter=max' {
   export DT_FILTER=(max)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[DC054]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, data-filter=count' {
   export DT_FILTER=(count)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#-------------------------------------------Data Call by name with Subject mode ALL-----------------------------------
#bats test_tags=op:dcn,submode:all
@test '[DC055]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, data-filter=avg' {
   export DT_FILTER=(avg)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[DC056]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, data-filter=min' {
   export DT_FILTER=(min)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC057]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, data-filter=max' {
   export DT_FILTER=(max)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC058]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, data-filter=count' {
   export DT_FILTER=(count)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#------------------------------------------------uproll----------------
#bats test_tags=query:uproll,op:dcn
@test '[DC059]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll, data-filter=avg' {
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=query:uproll,op:dcn
@test '[DC060]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll, data-filter=min' {
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=query:uproll,op:dcn
@test '[DC061]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll, data-filter=max' {
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=query:uproll,op:dcn
@test '[DC062]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll, data-filter=count' {
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#-------------------------------------------------uprollfor pattern----------------tier-------------
#bats test_tags=op:dcn,submode:pattern
@test '[DC063]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll, data-filter=avg' {
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test '[DC064]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll, data-filter=min' {
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC065]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll, data-filter=max' {
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC066]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll, data-filter=count' {
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------------------------uprollserver pattern--------------
#bats test_tags=op:dcn,submode:pattern
@test '[DC067]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll, data-filter=avg' {
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test '[DC068]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll, data-filter=min' {
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test '[DC069]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll, data-filter=max' {
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC070]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll, data-filter=count' {
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------uproll payttern on instance----------------------

#bats test_tags=op:dcn,submode:pattern
@test '[DC071]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll, data-filter=avg' {
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test '[DC072]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll, data-filter=min' {
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test '[DC073]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll, data-filter=max' {
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC074]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll, data-filter=count' {
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#--------------------------uproll all pattern ---------------------------------------------------

#bats test_tags=op:dcn,submode:pattern
@test '[DC075]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll, data-filter=avg' {
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test '[DC076]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll, data-filter=min' {
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[DC077]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll, data-filter=max' {
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
} 


#bats test_tags=op:dcn,submode:pattern
@test '[DC078]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll, data-filter=count' {
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#------------------------------uproll---------------------------------------------------------

#bats test_tags=tc:6,op:dcn,submode:all
@test '[DC079]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll, data-filter=avg' {
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[DC080]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll, data-filter=min' {
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[DC081]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll, data-filter=max' {
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[DC082]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll, data-filter=count' {
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#------------------------------------------------------------uproll server------------


#bats test_tags=op:dcn,submode:all
@test '[DC083]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll, data-filter=avg' {
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[DC084]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll, data-filter=min' {
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}



#bats test_tags=op:dcn,submode:all
@test '[DC085]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll, data-filter=max' {
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[DC086]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll, data-filter=count' {
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#----------------------------------------------------------------


#bats test_tags=op:dcn,submode:all
@test '[DC087]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll, data-filter=avg' {
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[DC088]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll, data-filter=min' {
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[DC089]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll, data-filter=max' {
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC090]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll, data-filter=count' {
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#---------------------------------------------------uproll-------------

#bats test_tags=op:dcn,submode:all
@test '[DC091]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll, data-filter=avg' {
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC092]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll, data-filter=min' {
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC093]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll, data-filter=max' {
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[DC094]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll, data-filter=count' {
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s"
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#------------------------------------------------------------UNIT MASK-----------------------------------------

#bats test_tags=op:dcn,test:first,unit:id
@test '[DC095]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --unit "sec" >  ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,test:second,unit:id
@test '[DC096]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,unit:id
@test '[DC097]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec"  > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,unit:id
@test '[DC098]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec"  > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,unit:id
@test '[DC099]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec" "
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,unit:id
@test '[DC0100]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,unit:id
@test '[DC0101]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/datacall-tier-*/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/datacall-server-*/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/Processor-*/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all,test:six,unit:id
@test '[DC0102]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all,unit:id
@test '[DC0103]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all,unit:id
@test '[DC0104]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all,unit:id
@test '[DC0105]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_VAL=`echo $TIER | cut -d':' -f2`
   TIER_PATTERN=`echo $TIER | sed "s/$TIER_VAL/ALL/g"`

   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_VAL=`echo $SERVER | cut -d':' -f2`
   SERVER_PATTERN=`echo $SERVER | sed "s/$SERVER_VAL/ALL/g"`

   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_VAL=`echo $INSTANCE | cut -d':' -f2`
   INSTANCE_PATTERN=`echo $INSTANCE | sed "s/$INSTANCE_VAL/ALL/g"`

   export SUB_PATTERN=`echo $SUBJECT |sed -e "s/$TIER/$TIER_PATTERN/g" -e "s/$SERVER/$SERVER_PATTERN/g" -e  "s/$INSTANCE/$INSTANCE_PATTERN/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --unit "sec""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --unit "sec" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}









