#!/home/cavisson/bin/bats

get_metric() {
   METRIC_LINE=`grep "Tier:datacall-tier" $METRIC_FILE | grep "tags:" | shuf -n 1`
   METRIC_ID=`echo $METRIC_LINE | cut -d',' -f1` 
   NFIDX=`echo $METRIC_LINE | cut -d',' -f2`
   SUBJECT=`echo $METRIC_LINE | cut -d"," -f3`
   TAGS=`echo $METRIC_LINE | cut -d',' -f4- | rev | cut -d',' -f5- | rev|cut -d '"' -f 2`
   MEASURE=`echo $METRIC_LINE | cut -d',' -f4- | rev | cut -d',' -f2-4 |rev`
   
   echo "export METRIC_LINE='$METRIC_LINE'" > ${MT_DETAIL_FILE}
   echo "export METRIC_ID=$METRIC_ID" >> ${MT_DETAIL_FILE}
   echo "export NFIDX=$NFIDX" >> ${MT_DETAIL_FILE}
   echo "export SUBJECT='$SUBJECT'" >> ${MT_DETAIL_FILE}
   echo "export MEASURE='$MEASURE'" >> ${MT_DETAIL_FILE}
   echo "export TAGS='$TAGS'" >> ${MT_DETAIL_FILE}
   echo "$TAGS" >.exp_tags
   automation_log "TAGS=$TAGS"
}



setup() {
  source ./testsuites/common
  common_setup
  source $DATACALL_LIB/datacall_lib_tags
  export RESPONSE_FILE="$DATA_TAG/DCT_${BATS_TEST_NUMBER}".txt
  if [ $BATS_TEST_NUMBER -eq 1 ];then
     get_metric
  fi
  
  source ${MT_DETAIL_FILE}
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
  export DT_FILTER=()
}


#------------------------------------------------ Data call by Name ----------------------------------------------------------------

#bats test_tags=op:dcn,test:first
@test 'ID=DCTAG001, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS" 
}

#--------------------------------- Data Call by name with Subjectmode Pattern ---------------------------------------------------------------------

#bats test_tags=op:dcn,submode:pattern,test:second
@test 'ID=DCTAG002, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --tag_name "$tags" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG003, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG004, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG005, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#----------------------------------------------------- Data Call by name with Subject mode ALL--------------------------------------------------

#bats test_tags=tc:6,op:dcn,submode:all,test:oo
@test 'ID=DCTAG006, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG007, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG008, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all,name:rah
@test 'ID=DCTAG009, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all' { 
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#---------------------------------------- Datacall uproll queries --------------------------------#
#bats test_tags=query:uproll,op:dcn
@test 'ID=DCTAG010, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll' { 
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   GRANULARITY=$((NFIDX + 1))  
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG011, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   GRANULARITY=$((NFIDX + 1))  
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG012, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   GRANULARITY=$((NFIDX + 1))  
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG013, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   GRANULARITY=$((NFIDX + 1))  
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG014, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test 'ID=DCTAG015, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   GRANULARITY=$((NFIDX + 1))  
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG016, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   GRANULARITY=$((NFIDX + 1))  
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG017, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   GRANULARITY=$((NFIDX + 1))  
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG018, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#-------------------------------------------------------------data filter -------------------------------------------------------------------------

#bats test_tags=op:dcn,filter:min
@test 'ID=DCTAG019, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, Data-Filter=Min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER[@]}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags" > ${RESPONSE_FILE[@]} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,filter:max
@test 'ID=DCTAG020, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, Data-Filter=Max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"

}


#bats test_tags=op:dcn,filter:avg
@test 'ID=DCTAG021, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, Data-Filter=Avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}



#bats test_tags=op:dcn,filter:count,name:rahul
@test 'ID=DCTAG022, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, Data-Filter=Count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#--------------------------------- Data Call by name with Subjectmode Pattern ---------------------------------------------------------------------

#bats test_tags=op:dcn,submode:pattern,pattern:max
@test 'ID=DCTAG023, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, Data-filter=Max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
  
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,pattern:count
@test 'ID=DCTAG024, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, Data-filter=Count' {
   export DT_FILTER=(count)
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,pattern:min
@test 'ID=DCTAG025, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, Data-filter=Min' {
   export DT_FILTER=(min)
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,pattern:avg
@test 'ID=DCTAG026, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, Data-filter=Avg' {
   export DT_FILTER=(avg)
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------------------Data call by name with subject mode pattern server---------------------------


#bats test_tags=op:dcn,submode:pattern,mode:server
@test 'ID=DCTAG027, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=Avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,mode:server
@test 'ID=DCTAG028, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=Min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:server
@test 'ID=DCTAG029, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=Max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:server
@test 'ID=DCTAG030, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=Count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:server
@test 'ID=DCTAG031, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, Data-filter=max min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max min)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------------------Data call by name with subject mode pattern instance---------------------------

#bats test_tags=op:dcn,submode:pattern,mode:instance
@test 'ID=DCTAG032, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=Avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,mode:instance
@test 'ID=DCTAG033, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=Min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,mode:instance
@test 'ID=DCTAG034, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=Max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern,mode:instance
@test 'ID=DCTAG035, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=Count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:instance,rahul:bisht
@test 'ID=DCTAG036, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, Data-filter=min max Count ' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min max)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER[@]}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER[@]}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#----------------------------------------------Data call by name with subject mode pattern all---------------------------


#bats test_tags=op:dcn,submode:pattern,mode:all
@test 'ID=DCTAG037, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=Avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:all
@test 'ID=DCTAG038, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=Min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:all
@test 'ID=DCTAG039, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=Max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:all
@test 'ID=DCTAG040, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=Count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,mode:all
@test 'ID=DCTAG041, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, Data-filter=max Count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------------------------- Data Call by name with Subject mode ALL--------------------------------------------------

#bats test_tags=tc:6,op:dcn,submode:all
@test 'ID=DCTAG042, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, Data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}"  --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test 'ID=DCTAG043, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, Data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}"  --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test 'ID=DCTAG044, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, Data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test 'ID=DCTAG045, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, Data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}
#-------------------------------------------Data Call by name with Subject mode ALLserver---------------------------
#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG046, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=avg ' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG047, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=min ' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG048, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=max ' { 
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG049, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=count ' { 
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG050, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, Data-filter=avg max ' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg max)
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#-------------------------------------------Data Call by name with Subject mode ALLinstance------------------------------------

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG051, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG052, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, data-filter=min' { 
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG053, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, data-filter=max' { 
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG054, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, data-filter=count' { 
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#-------------------------------------------Data Call by name with Subject mode ALL-----------------------------------
#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG055, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG056, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG057, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG058, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#------------------------------------------------uproll----------------
#bats test_tags=query:uproll,op:dcn
@test 'ID=DCTAG059, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=query:uproll,op:dcn
@test 'ID=DCTAG060, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=query:uproll,op:dcn
@test 'ID=DCTAG061, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=query:uproll,op:dcn
@test 'ID=DCTAG062, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DATA_MODE=UProll, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#-------------------------------------------------uprollfor pattern----------------tier-------------
#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG063, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG064, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG065, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG066, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DATA_MODE=UProll, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------------------------uprollserver pattern--------------
#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG067, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG068, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG069, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG070, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DATA_MODE=UProll, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#----------------------------------uproll payttern on instance----------------------

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG071, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG072, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\"" 
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG073, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG074, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DATA_MODE=UProll, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#--------------------------uproll all pattern ---------------------------------------------------

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG075, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG076, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG077, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
} 


#bats test_tags=op:dcn,submode:pattern
@test 'ID=DCTAG078, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DATA_MODE=UProll, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#------------------------------uproll---------------------------------------------------------

#bats test_tags=tc:6,op:dcn,submode:all
@test 'ID=DCTAG079, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test 'ID=DCTAG080, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test 'ID=DCTAG081, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test 'ID=DCTAG082, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DATA_MODE=UProll, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#------------------------------------------------------------uproll server------------


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG083, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG084, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}



#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG085, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG086, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DATA_MODE=UProll, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#----------------------------------------------------------------


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG087, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(avg)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG088, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(min)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG089, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(max)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG090, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DATA_MODE=UProll, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
   export DT_FILTER=(count)
   GRANULARITY=$((NFIDX + 1))
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#---------------------------------------------------uproll-------------

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG091, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll, data-filter=avg' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG092, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll, data-filter=min' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG093, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll, data-filter=max' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test 'ID=DCTAG094, OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DATA_MODE=UProll, data-filter=count' {
   tags=`sed 's/,/\n/g' .exp_tags |shuf -n 1`
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
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUB_PATTERN}\" --measure \"${MEASURE}\" --dt \"${DT_FILTER}\" --g ${NF_ARR[GRANULARITY]}s --tag_name \"$tags\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUB_PATTERN}" --measure "${MEASURE}" --dt "${DT_FILTER}" --g "${NF_ARR[GRANULARITY]}s" --tag_name "$tags"> ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

