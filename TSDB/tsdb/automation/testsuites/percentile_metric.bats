#!/home/cavisson/work/TSDB/tsdb/automation/thirdparty/bats-core/bin/bats

setup() {
  source ./testsuites/common
  common_setup
  source ./lib/tsdbRequests
  source $PERCENTILE_LIB/percentile_lib
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
  export RESPONSE_FILE=$PERCENTILE_REP/PER_$BATS_TEST_NUMBER.txt
}

get_detail(){
  NFIDX=`grep "Metric:graph_name_001 p22,45000,150" $METRIC_FILE |cut -d',' -f 2`
  GRANULARITY=$((NFIDX + 1))
  get_id=`grep "percentile-tier" $NS_WDIR/logs/TR$TESTIDX/tsdb/tsdb_metrics.txt | head -1 | cut -d',' -f1`
  st=$((`cat $NS_WDIR/logs/TR$TESTIDX/tsdb/redo/archive/.lav | cut -d'|' -f1` + 600))
  et=$(($st + 60))
}


#---------------------- Percentile metric ------------------------------------
#bats test_tags=op:dcn,level:1,filter:exact,id:1
@test '[PER001]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001' {
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001,45000,1" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER002]Hierarchy=Tier,Server, OP=Data Query, Metric=L1d Cache Memory(KB)' {
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_002,45000,2" OUTFILE=$RESPONSE_FILE
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER003]Hierarchy=Tier,Server, OP=Data Query, Metric=L1i Cache Memory(KB)' {
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_003,45000,3" OUTFILE=$RESPONSE_FILE
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER004]Hierarchy=Tier,Server, OP=Data Query, Metric=L2 Cache Memory(KB)' {
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_004,45000,4" OUTFILE=$RESPONSE_FILE
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER005]Hierarchy=Tier,Server, OP=Data Query, Metric=L3 Cache Memory(KB)' {
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:System Metrics>MGroup:CPU Stats>Metric:L3 Cache Memory(KB),10729,5" OUTFILE=$RESPONSE_FILE
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,data_filter:percentile
@test '[PER006]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001' {
   get_detail
   #run_query OP=dci ID=$get_id DT="percentile" ST=$st ET=$et OUTFILE=$RESPONSE_FILE
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001,45000,1" DT="percentile" ST=$st ET=$et OUTFILE=$RESPONSE_FILE
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER007]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p22' {
   get_detail
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p22,45000,150" ST=$st ET=$et OUTFILE=$RESPONSE_FILE
   check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_6.txt" "22nd" "$RESPONSE_FILE"
   check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
   check_graph_name_id "128" "22" "graph_name_001" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER008]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p36' {
   get_detail
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p36,45000,164" ST=$st ET=$et OUTFILE=$RESPONSE_FILE
   check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_6.txt" "36th" "$RESPONSE_FILE"
   check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
   check_graph_name_id "128" "36" "graph_name_001" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER009]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p45' {
   get_detail
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p45,45000,173" ST=$st ET=$et OUTFILE=$RESPONSE_FILE
   check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_6.txt" "45th" "$RESPONSE_FILE"
   check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
   check_graph_name_id "128" "45" "graph_name_001" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER010]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p52' {
   get_detail
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p52,45000,180" ST=$st ET=$et OUTFILE=$RESPONSE_FILE
   check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_6.txt" "52nd" "$RESPONSE_FILE"
   check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
   check_graph_name_id "128" "52" "graph_name_001" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER011]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p56' {
   get_detail
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p56,45000,184" ST=$st ET=$et OUTFILE=$RESPONSE_FILE
   check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_6.txt" "56th" "$RESPONSE_FILE"
   check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
   check_graph_name_id "128" "56" "graph_name_001" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER012]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p84' {
   get_detail
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p84,45000,212" ST=$st ET=$et OUTFILE=$RESPONSE_FILE
   check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_6.txt" "84th" "$RESPONSE_FILE"
   check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
   check_graph_name_id "128" "84" "graph_name_001" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[PER013]Hierarchy=Tier,Server, OP=Data Query, Metric=L3 Cache Memory(KB)' {
   get_detail
   cur_ts=`cat $LAV_PATH | cut -d "|" -f 3`
   e_ts=$(($cur_ts - ( $cur_ts % ${NF_ARR[GRANULARITY]})))
   s_ts=$(($e_ts - ${NF_ARR[GRANULARITY]}))
   run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001,45000,1"  DT="percentile" ST=$s_ts ET=$e_ts OUTFILE=$RESPONSE_FILE
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,Data_mode:Unroll
@test '[PER014]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p22, Live uproll' {
  get_detail
  cur_ts=`cat $LAV_PATH | cut -d "|" -f 3`
  e_ts=$(($cur_ts - ( $cur_ts % ${NF_ARR[GRANULARITY]})))
  s_ts=$(($e_ts - ${NF_ARR[GRANULARITY]}))
  run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p22,45000,150" ST=$s_ts ET=$e_ts VIEW_BY=${NF_ARR[GRANULARITY]}s OUTFILE=$RESPONSE_FILE
  check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_13.txt" "22nd" "$RESPONSE_FILE"
  check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
  check_graph_name_id "128" "22" "graph_name_001" "$RESPONSE_FILE"
  output=$(validate_output)
  assert_output "PASS"
} 

#bats test_tags=op:dcn,level:1,filter:exact,Data_mode:Unroll
@test '[PER015]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p36, Live uproll' {
  get_detail
  cur_ts=`cat $LAV_PATH | cut -d "|" -f 3`
  e_ts=$(($cur_ts - ( $cur_ts % ${NF_ARR[GRANULARITY]})))
  s_ts=$(($e_ts - ${NF_ARR[GRANULARITY]}))
  run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p36,45000,164" ST=$s_ts ET=$e_ts VIEW_BY=${NF_ARR[GRANULARITY]}s OUTFILE=$RESPONSE_FILE
  check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_13.txt" "36th" "$RESPONSE_FILE"
  check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
  check_graph_name_id "128" "36" "graph_name_001" "$RESPONSE_FILE"
  output=$(validate_output)
  assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,Data_mode:Unroll
@test '[PER016]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p45, Live uproll' {
  get_detail
  cur_ts=`cat $LAV_PATH | cut -d "|" -f 3 `
  e_ts=$(($cur_ts - ( $cur_ts % ${NF_ARR[GRANULARITY]})))
  s_ts=$(($e_ts - ${NF_ARR[GRANULARITY]}))
  run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p45,45000,173" ST=$s_ts ET=$e_ts VIEW_BY=${NF_ARR[GRANULARITY]}s OUTFILE=$RESPONSE_FILE
  check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_13.txt" "45th" "$RESPONSE_FILE"
  check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
  check_graph_name_id "128" "45" "graph_name_001" "$RESPONSE_FILE"
  output=$(validate_output)
  assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,Data_mode:Unroll
@test '[PER017]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p52, Live uproll' {
  get_detail
  cur_ts=`cat $LAV_PATH | cut -d "|" -f 3 `
  e_ts=$(($cur_ts - ( $cur_ts % ${NF_ARR[GRANULARITY]})))
  s_ts=$(($e_ts - ${NF_ARR[GRANULARITY]}))
  run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p52,45000,180" ST=$s_ts ET=$e_ts VIEW_BY=${NF_ARR[GRANULARITY]}s OUTFILE=$RESPONSE_FILE
  check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_13.txt" "52nd" "$RESPONSE_FILE"
  check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
  check_graph_name_id "128" "52" "graph_name_001" "$RESPONSE_FILE"
  output=$(validate_output)
  assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,Data_mode:Unroll
@test '[PER018]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p56, Live uproll' {
  get_detail
  cur_ts=`cat $LAV_PATH | cut -d "|" -f 3 `
  e_ts=$(($cur_ts - ( $cur_ts % ${NF_ARR[GRANULARITY]})))
  s_ts=$(($e_ts - ${NF_ARR[GRANULARITY]}))
  run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p56,45000,184" ST=$s_ts ET=$e_ts VIEW_BY=${NF_ARR[GRANULARITY]}s OUTFILE=$RESPONSE_FILE
  check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_13.txt" "56th" "$RESPONSE_FILE"
  check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
  check_graph_name_id "128" "56" "graph_name_001" "$RESPONSE_FILE"
  output=$(validate_output)
  assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,Data_mode:Unroll
@test '[PER019]Hierarchy=Tier,Server, OP=Data Query, Metric=graph_name_001 p84, Live uproll' {
  get_detail
  cur_ts=`cat $LAV_PATH | cut -d "|" -f 3 `
  e_ts=$(($cur_ts - ( $cur_ts % ${NF_ARR[GRANULARITY]})))
  s_ts=$(($e_ts - ${NF_ARR[GRANULARITY]}))
  run_query OP=dcn SUBJECT="customer:Default>application:Default>tier:percentile-tier>host:percentile-server-1" MEASURE="MGType:group_type_001>MGroup:group_name_002>Metric:graph_name_001 p84,45000,212" ST=$s_ts ET=$e_ts VIEW_BY=${NF_ARR[GRANULARITY]}s OUTFILE=$RESPONSE_FILE
  check_percentile_data "$NS_WDIR/TSDB/tsdb/automation/responses/percentile/PER_13.txt" "84th" "$RESPONSE_FILE"
  check_name "percentile-tier>percentile-server-1" "$RESPONSE_FILE"
  check_graph_name_id "128" "84" "graph_name_001" "$RESPONSE_FILE"
  output=$(validate_output)
  assert_output "PASS"
}
