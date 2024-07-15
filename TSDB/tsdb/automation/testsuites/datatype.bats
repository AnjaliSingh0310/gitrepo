#!./bats/bin/bats

get_metric() {
   grep "Datatype Testing" $METRIC_FILE > ${DATACALL_TEMP}/datatype_measure.tmp
   NFIDX=`cat ${DATACALL_TEMP}/datatype_measure.tmp | cut -d',' -f2 | uniq`
   SUBJECT=`cat ${DATACALL_TEMP}/datatype_measure.tmp | cut -d"," -f3 | uniq`
   echo "export NFIDX=$NFIDX" > ${MT_DETAIL_FILE}
   echo "export SUBJECT='$SUBJECT'" >> ${MT_DETAIL_FILE}
   cat ${DATACALL_TEMP}/datatype_measure.tmp | cut -d"," -f4-6 > ${DATACALL_TEMP}/all_measure.tmp
   i=1 
   while read -r line;
   do
      echo "export MEASURE_$i=\"$line\"" >> ${MT_DETAIL_FILE}
      i=$((i+1))
   done < ${DATACALL_TEMP}/all_measure.tmp
}



setup() {
  source ./testsuites/common
  common_setup
  source $DATACALL_LIB/datacall_lib
  source $DATACALL_LIB/data_type_validation
  export RESPONSE_FILE="${DATA_REP}/DC_${BATS_TEST_NUMBER}".txt
  if [ $BATS_TEST_NUMBER -eq 1 ];then
     get_metric
  fi
  source ${MT_DETAIL_FILE}
  export TP=10
}



#------------------------------------------------ Data call by Name ----------------------------------------------------------------

#bats test_tags=op:dcn,t:1
@test "[DT001]DATA_TYPE=Sample No Formula, OP=DCN, TP=L10m, DATA_MODE=live" {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_1}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_1}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT002]DATA_TYPE=Sample PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_2}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_2}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT003]DATA_TYPE=Sample PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_3}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_3}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT004]DATA_TYPE=Sample_1B No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_4}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_4}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT005]DATA_TYPE=Sample_1B PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_5}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_5}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT006]DATA_TYPE=Sample_1B PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_6}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_6}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT007]DATA_TYPE=Sample_2B_100 No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_7}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_7}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT008]DATA_TYPE=Sample_2B_100 PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_8}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_8}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT009]DATA_TYPE=Sample_2B_100 PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_9}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_9}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT010]DATA_TYPE=Sample_4B No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_10}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_10}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT011]DATA_TYPE=Sample_4B PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_11}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_11}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT012]DATA_TYPE=Sample_4B PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_12}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_12}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT013]DATA_TYPE=Sample_4B_1000 No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_13}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_13}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT014]DATA_TYPE=Sample_4B_1000 PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_14}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_14}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT015]DATA_TYPE=Sample_4B_1000 PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_15}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_15}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT016]DATA_TYPE=Sample_2B_100_Count_4B No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_16}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_16}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT017]DATA_TYPE=Sample_2B_100_Count_4B PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_17}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_17}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT018]DATA_TYPE=Sample_2B_100_Count_4B PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_18}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_18}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT019]DATA_TYPE=Rate No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_19}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_19}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT020]DATA_TYPE=Rate PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_20}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_20}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT021]DATA_TYPE=Rate PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_21}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_21}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT022]DATA_TYPE=Rate_4B_1000 No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_22}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_22}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT023]DATA_TYPE=Rate_4B_1000 PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_23}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_23}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT024]DATA_TYPE=Rate_4B_1000 PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_24}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_24}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn,t:25
@test '[DT025]DATA_TYPE=Cummulative No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   skip "wrong ingestion is happening"
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_25}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_25}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn,t:25
@test '[DT026]DATA_TYPE=Cummulative PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   skip "wrong ingestion is happening"
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_26}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_26}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn,t:25
@test '[DT027]DATA_TYPE=Cummulative PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   skip "wrong ingestion is happening"
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_27}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_27}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT028]DATA_TYPE=Times No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_28}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_28}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT029]DATA_TYPE=Times PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_29}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_29}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT030]DATA_TYPE=Times PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_30}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_30}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT031]DATA_TYPE=Times_4B_10 No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_31}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_31}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT032]DATA_TYPE=Times_4B_10 PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_32}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_32}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT033]DATA_TYPE=Times_4B_10 PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_33}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_33}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT034]DATA_TYPE=Times_4B_1000 No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_34}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_34}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT035]DATA_TYPE=Times_4B_1000 PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_35}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_35}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT036]DATA_TYPE=Times_4B_1000 PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_36}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_36}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT037]DATA_TYPE=TimesStd No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_37}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_37}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT038]DATA_TYPE=TimesStd PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_38}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_38}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT039]DATA_TYPE=TimesStd PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_39}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_39}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT040]DATA_TYPE=TimesStd_4B_1000 No Formula, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_40}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_40}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}

#bats test_tags=op:dcn
@test '[DT041]DATA_TYPE=TimesStd_4B_1000 PS, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_41}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_41}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
#bats test_tags=op:dcn
@test '[DT042]DATA_TYPE=TimesStd_4B_1000 PM, OP=DCN, TP=L10m, DATA_MODE=live' {
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE_42}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE_42}" > ${RESPONSE_FILE} 2>/dev/null
   set_exp_sf_sc
   extract_actual_output
   output=$(validate_data_type)
   assert_output "PASS"
}
