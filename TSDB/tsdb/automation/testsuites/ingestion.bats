#!/home/cavisson/bin/bats

#currently this file only working for tsdb_ingestion_test.conf,  if  we run tsdb_ingestion_all_metric.conf , need to change in code

setup() {
  source ./testsuites/common
  source ./testsuites/common_methods
  common_setup
  source $DATACALL_LIB/datacall_lib
  source $INGESTION_LIB/ingestion_lib
  export RESPONSE_FILE="$INGESTION_REP/ING_${BATS_TEST_NUMBER}".txt
  if [ $BATS_TEST_NUMBER -gt 0 ];then  
     get_metric
  fi
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
}

#----------------------------------------- Check subject regd ---------------------------------------------

@test '[TC-001] INGESTION = Subject_Registration' {
  
  extract_tier_name
  output=$(validate_ingestion_response "$ING_TIER_NAME" "$TIER_NAME" "$BATS_TEST_NUMBER")
  assert_output "PASS"
}

#-------------------------------------------- Query using DCN --------------------------------------

@test '[TC-002] INGESTION = validate_data_call(DCN)'  {
   
   automation_log "tsdb_admin --port ${TSDB_PORT} --op dcn --subject \"${SUBJECT}\" --measure \"${MEASURE}\""
   tsdb_admin --port ${TSDB_PORT} --op dcn --subject "${SUBJECT}" --measure "${MEASURE}" > ${RESPONSE_FILE} 2>/dev/null
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS" 
}

#---------------------------Check metric id is present in both tsdb_metric.txt and trace.log file ------------------

@test '[TC-003] INGESTION = validate_metric_id'  {

  automation_log "tsdb_admin --port ${TSDB_PORT} --op dci --id \"${METRIC_ID}\""
  tsdb_admin --port ${TSDB_PORT} --op dci --id "${METRIC_ID}"
  LOG_MT_LINE=$(search_in_file "$METRIC_ID" "$TRACE_LOG_FILE")
  automation_log "Log mt line = ${LOG_MT_LINE}"
  LOG_MT_ID=`echo "$LOG_MT_LINE" | grep -o 'metric_id = [0-9A-F]\{48\}' | awk '{print $3}'`
  output=$(validate_ingestion_response "$LOG_MT_ID" "$METRIC_ID" "$BATS_TEST_NUMBER")
  assert_output "PASS"
}

#-------------------------------------- Frequency validation in conf file and tsdb_metric.txt file ---------------

@test '[TC-004] INGESTION = validate_frequency'  {
  extract_tier_name
  ING_SCHEDULE_LINE=$(scedule_line_for_cur_tier "$TIER_NAME" "$ING_CONF_FILE")
  ING_FREQ_IDX=`echo "$ING_SCHEDULE_LINE" | cut -d'|' -f4`
  output=$(validate_ingestion_response "$ING_FREQ_IDX" "$FREQ" "$BATS_TEST_NUMBER")
  assert_output "PASS"
}

#------------------------------------Data type validation ---------------------------------------

@test '[TC-005] INGESTION = validate_data_type'  {

  LOG_MT_ID_LINE=$(search_in_file "$METRIC_ID" "$TRACE_LOG_FILE")
  automation_log "log line of datatype : ${LOG_MT_ID_LINE}"
  LOG_DATA_TYPE=`echo "$LOG_MT_ID_LINE" | grep -o 'data_type = [0-9]\+' | awk '{print $3}'`
  data_type_convert_num2str "$LOG_DATA_TYPE"
  automation_log "gdf id = ${GDF_ID}, ${GDF_PATH}" 
  ING_GDF_FILE=`grep -rnl $GDF_ID $GDF_PATH`
  GDF_GRAPH_LINE=`grep -i "$DATA_TYPE_STR" "$ING_GDF_FILE" | shuf -n 1`
  automation_log "type ${DATA_TYPE_STR} , file ${ING_GDF_FILE}"
  GDF_GRAPH_TYPE=`echo "$GDF_GRAPH_LINE" | cut -d'|' -f5`
  automation_log "graph_type =${GDF_GRAPH_TYPE} and mt_name = ${METRIC_NAME}"
  data_type_convert_str2num "$GDF_GRAPH_TYPE"
  output=$(validate_ingestion_response "$DATA_TYPE_NUM" "$LOG_DATA_TYPE" "$BATS_TEST_NUMBER")
  assert_output "PASS"
}

#-------------------------------------- tag and attribute validation ---------------------------------------------------

@test '[TC-006] INGESTION = validate_tag_attribute'  {
 # ING_TAG_METRIC_LINE=$(search_in_file "t:" "$ING_CONF_FILE")
  TAG_METRIC_LINE=`grep "Tier:Cav-Tier-1" $METRIC_FILE | grep "tags:" | shuf -n 1`
  TAG_FLD_LINE=`echo "$TAG_METRIC_LINE" | grep -o 'tags:"[^"]*"'`
  TAG_FLDS=${TAG_FLD_LINE:6:-1}
  output=$(validate_flds_response "$TAG_FLDS")
  assert_output "PASS"
}

#-------------------------------------- validation for percentile metric --------------------------------------------

@test '[TC-007] INGESTION = validate_percentile_metric'    {

  find_percentile_metric "cm_nd_bt.gdf" "$ING_CONF_FILE"
  automation_log "perc idx is $PERC_IDX"
  output=$(validate_ingestion_response "$PERC_IDX" "1" "$BATS_TEST_NUMBER")
  assert_output "PASS"
}

#-------------------------------------- validation for percentile preset metric --------------------------------------------

@test '[TC-008] INGESTION = validate_percentile_preset_metric'    {

  find_percentile_metric "cm_nd_bt.gdf" "$ING_CONF_FILE"
  automation_log "preset val is ${PERC_PRESET_VAL}"
  output=$(validate_flds_response "$PERC_PRESET_VAL")
  assert_output "PASS"
}

#-------------------------------------------- mg tag validation ---------------------------------------------------------

@test '[TC-009] INGESTION = validate_tag_mg'    {
  
  MG_TAG_LINE=$(search_in_file "Group" "$GDF_PATH/cm_mpstat.gdf")
  MG_TAG_FLD_ORG=`echo "$MG_TAG_LINE" | cut -d'|' -f12`
  MG_TAG_FLD=`echo "$MG_TAG_FLD_ORG" | tr '[:upper:]' '[:lower:]'`
  automation_log "tag fld ${MG_TAG_FLD} and org ${MG_TAG_FLD_ORG}"
  LOG_TAG_LINE=$(search_in_file "$MG_TAG_FLD" "$TRACE_LOG_FILE")
  automation_log "tag line ${LOG_TAG_LINE}"
  if [ ! "$LOG_TAG_LINE" ]; then
    LOG_TAG_LINE=$(search_in_file "$MG_TAG_FLD" "$PREV_TRACE_LOG_FILE")
  fi
  automation_log "tag line ${LOG_TAG_LINE}"
  LOG_TAG=`echo "$LOG_TAG_LINE" | grep -o 'technology=.*$' | cut -d'|' -f1`
  automation_log "LOG_tag = ${LOG_TAG}"
  LOG_TAG=`echo "$LOG_TAG" | grep -o "$MG_TAG_FLD"`
  automation_log "LOG_tag2 = ${LOG_TAG}"
  output=$(validate_ingestion_response "$MG_TAG_FLD" "$LOG_TAG" "$BATS_TEST_NUMBER")
  assert_output "PASS"
}


#------------------------------------------- Deleted metric ----------------------------------------------
@test '[TC-010] INGESTION = validate_Delete_metric_by_api'  {
  
  DEL_METRIC_LINE=`grep "Tier:Del-Tier" $METRIC_FILE | grep -v "^#" | shuf -n 1`
  DEL_METRIC_ID=`echo $DEL_METRIC_LINE | cut -d',' -f1`
  automation_log "tsdb_admin --port ${TSDB_PORT} --op dl-met --id \"${DEL_METRIC_ID}\""
  tsdb_admin --port "${TSDB_PORT}" --op dl-met --id "${DEL_METRIC_ID}"
  DEL_MT_ID_LINE=$(search_in_file "$DEL_METRIC_ID" "$DEL_METRIC_FILE")
  DEL_MT_ID=`echo "$DEL_MT_ID_LINE" | cut -d',' -f1`
  output=$(validate_ingestion_response "$DEL_MT_ID" "$DEL_METRIC_ID" "$BATS_TEST_NUMBER")
  assert_output "PASS"
}

#-------------------------------------- Inactive/Exclude graph state validator in group call -------------------------------
@test '[TC-011] INGESTION = validate_inactive_or_exclude_graph in mgn call'   {

  automation_log "gdf id = ${GDF_ID}, ${GDF_PATH}"
  ING_GDF_FILE=`grep -rnl $GDF_ID $GDF_PATH`
  graph_state_validate "$ING_GDF_FILE"
  if [ $GDF_ID == 10245 ]; then    #for adding extra percentile metric in case of BT
    let "tot_metric=tot_metric+5"
  fi
  tsdb_admin --port "${TSDB_PORT}" --op mgn --id "$GDF_ID" > ${RESPONSE_FILE} 2>/dev/null   
  resp_tot_metric_line=`grep -o 'Total Metrics: [0-9]\+' $RESPONSE_FILE`
  resp_tot_metric=`echo "$resp_tot_metric_line" | cut -d':' -f2 | sed 's/^[[:space:]]*\([0-9]\)/\1/'`
  output=$(validate_ingestion_response "$tot_metric" "$resp_tot_metric")
  assert_output "PASS"
}

#-------------------------------------- Inactive/Exclude graph state validator in graph call -------------------------------
@test '[TC-012] INGESTION = validate_inactive_or_exclude_graph in mn call'   {

  automation_log "gdf id = ${GDF_ID}, ${GDF_PATH}"
  ING_GDF_FILE=`grep -rnl $GDF_ID $GDF_PATH`
  graph_state_validate "$ING_GDF_FILE"
  if [ $GDF_ID == 10245 ]; then    #for adding extra percentile metric in case of BT
    let "tot_metric=tot_metric+5"
  fi
  automation_log "totmetric = ${tot_metric} file - ${ING_GDF_FILE}"
  tsdb_admin --port "${TSDB_PORT}" --op mn --id "$GDF_ID" --version 2 > ${RESPONSE_FILE} 2>/dev/null   
  resp_tot_metric_line=`grep -o 'Total Metrics: [0-9]\+' $RESPONSE_FILE`
  resp_tot_metric=`echo "$resp_tot_metric_line" | cut -d':' -f2 | sed 's/^[[:space:]]*\([0-9]\)/\1/'`
  output=$(validate_ingestion_response "$tot_metric" "$resp_tot_metric")
  assert_output "PASS"
}

#----------------------------------- NaN ingested in case of Exclude graph state ---------------------------------------------

@test '[TC-013] INGESTION = validate_exclude_graph_datacall_query'   {
  
 ING_GDF_FILE=`grep -rnl $GDF_ID $GDF_PATH`
 graph_state_validate "$ING_GDF_FILE"
 if [ !$mt_name ]; then
   output=$(validate_flds_response "$mt_name")
   assert_output "PASS"
 else
  mt_line=$(search_in_file "$mt_name" "$METRIC_FILE")
  automation_log "mt_name - ${mt_name} and mt_line - ${mt_line}"
  mt_id=`echo "$mt_line" | cut -d',' -f1`
  automation_log "mt_id - ${mt_id}"
  automation_log "tsdb_admin --port ${TSDB_PORT} --op dci --id ${mt_id}"
  tsdb_admin --port "${TSDB_PORT}" --op dci --id "${mt_id}" > ${RESPONSE_FILE} 2>/dev/null
  resp_data_summary=$(search_in_file "Data summary" "$RESPONSE_FILE")
  automation_log "data summary - ${resp_data_summary} resp file = ${RESPONSE_FILE}"
  count=`echo "$resp_data_summary" | grep -oP 'count: \K(nan|[\d.]+)'`
  count=`echo $count | cut -d" " -f1`
  automation_log "count = ${count}"
  if [ $count == 0 ]; then
   NAN=0
  else
   NAN="nan"
  fi
  output=$(validate_ingestion_response "$count" "$NAN")
  assert_output "PASS"
 fi
}










