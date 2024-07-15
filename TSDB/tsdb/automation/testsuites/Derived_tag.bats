#!/home/cavisson/work/TSDB/tsdb/automation/thirdparty/bats-core/bin/bats

setup() {
  source ./testsuites/common
  source ./lib/tsdbRequests
  source /home/cavisson/work/TSDB/tsdb/automation/testsuites/MetricDetails
  common_setup
  source $DERIVED_LIB/derived_lib
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""

}

get_detail() {
  SUBJECT="Tier:derived-tier>Server:derived-server-1"
  SUBJECT_ALL="Tier:all>Server:all"
  MEASURE="MGType:System Metrics>MGroup:Socket Statistics>Metric:Used Sockets,10107,1"
  RESPONSE_FILE=$DERIVED_REP/$BATS_TEST_NUMBER.output
}

change_mgroup() {
  if [ "${case}" == "all" ];then
     SUBJECT="customer:Default>application:Default>Tier:all>Server:all"
  else
     SUBJECT="customer:Default>application:Default>Tier:derived-tier>Server:derived-server-1"
  fi
  MGroup1=`echo $MEASURE | cut -d'>' -f2 | cut -d':' -f2`
  MEASURE="MGType:System Metrics>MGroup:Socket Statistics>Metric:TEST,1000009,1"
  MEASURE=`echo $MEASURE | sed "s/${MGroup1}/${MGroup}/g"`
}

create_open_merge() {
  MGroup1=`echo $MEASURE | cut -d'>' -f2 | cut -d':' -f2`
  MEASURE="MGType:System Metrics>MGroup:Socket Statistics,1000009,TEST:1"
  MEASURE=`echo $MEASURE | sed "s/${MGroup1}/${MGroup}/g"`
  if [ "${case}" == "all" ];then
     echo "${SUBJECT_ALL},${MEASURE}" > .tmp/$BATS_TEST_NUMBER.txt
  else
     echo "${SUBJECT},${MEASURE}" > .tmp/$BATS_TEST_NUMBER.txt
  fi
}

create_open_related() {
  MGroup1=`echo $MEASURE | cut -d'>' -f2 | cut -d':' -f2`
  MEASURE="MGType:System Metrics>MGroup:Socket Statistics>Metric:TEST,1000009,1"
  MEASURE=`echo $MEASURE | sed "s/${MGroup1}/${MGroup}/g"`
  echo "#open_related_file" > .tmp/$BATS_TEST_NUMBER.txt

  if [ "${case}" == "all" ];then
     echo "${SUBJECT_ALL},${MEASURE}" >> .tmp/$BATS_TEST_NUMBER.txt
     MEASURE="MGType:System Metrics>MGroup:Socket Statistics,1000009,TEST:1"
     MEASURE=`echo $MEASURE | sed "s/${MGroup1}/${MGroup}/g"`
     echo "${SUBJECT_ALL},${MEASURE}" >> .tmp/$BATS_TEST_NUMBER.txt
  else
     echo "${SUBJECT},${MEASURE}" >> .tmp/$BATS_TEST_NUMBER.txt
     MEASURE="MGType:System Metrics>MGroup:Socket Statistics,1000009,TEST:1"
     MEASURE=`echo $MEASURE | sed "s/${MGroup1}/${MGroup}/g"`
     echo "${SUBJECT},${MEASURE}" >> .tmp/$BATS_TEST_NUMBER.txt
  fi
}

#bats test_tags=id:1,type:dm
@test '[DER001]DM Without Tag Attr group BY' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="WO_TAG_ATTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   automation_log "Der - $DERIVED_METRIC_NAME"
   DMG_NAME="WO_TAG_ATTR"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE" 
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:2,type:dm
@test '[DER002]DM Without Tag Attr group By and tag_filter' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="WO_TAG_ATTR_TAG_FILTER" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="WO_TAG_ATTR_TAG_FILTER"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:3,type:dm
@test '[DER003]DM With One Tag Attr group By' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_ATTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="ONE_TAG_ATTR"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:4,type:dm
@test '[DER004]DM With With multiple tag attr in group by from same Metric group (Environ,Shift)' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_TAG_ATTR_SM_MG" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,Shift" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="MUL_TAG_ATTR_SM_MG"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:5,type:dm
@test '[DER005]DM With multiple same tag Attr group by from different Metric group (Team,Loc) present in both MG' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_SM_TAG_ATTR_DF_MG" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Team,Loc" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="MUL_SM_TAG_ATTR_DF_MG"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:6,type:dm
@test '[DER006]DM With invalid group by on tag' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="INV_TAG_ATTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Home" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:7,type:dm
@test '[DER007]DM With Multiple tags from different metric group (Environ,OS)' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_TAG_ATTR_DF_MG" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,OS" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:8,type:dm
@test '[DER008]DM With tag filter(Shift) and group by(Environ) of Same MG' {
   get_detail
   tag_filter="Shift=Day"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="TAG_ATTR_SM_MG_TAG_FILTER" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="TAG_ATTR_SM_MG_TAG_FILTER"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:9,type:dm
@test '[DER009]DM With tag filter(OS) and group by(Environ) different MG' {
   get_detail
   tag_filter="OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_FILTER_TAG_ATTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:10,type:dm
@test '[DER010]DM With invalid tag filter and invalid group by' {
   get_detail
   tag_filter="Type=first"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="INV_TAG_FILTER_TAG_ATTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Env" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:11,type:dm
@test '[DER011]DM With one tag_filter(Team=TSDB) and multiple group by(Environ,Shift) by From Same MG' {
   get_detail
   tag_filter="Team=TSDB"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_FILTER_MUL_TAG_ATTR_SM_MG" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,Shift" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="ONE_TAG_FILTER_MUL_TAG_ATTR_SM_MG"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:12,type:dm
@test '[DER012]DM With one tag_filter(OS=Windows) and multiple group by(Environ,Shift) by From different MG' {
   get_detail
   tag_filter="OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_FLTR_MUL_TAG_ATTR_DF_MG" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,Shift" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:13,type:dm
@test '[DER013]DM With one tag_filter(OS=Windows) and different MG multiple group by (Environ,OS) by From different MG' {
   get_detail
   tag_filter="OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_FLTR_DF_MG_TAG_ATTR_DF_MG" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,OS" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:14,type:dm
@test '[DER014]DM Without tag filter' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="WO_TAG_FLTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,OS" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:15,type:dm
@test '[DER015]DM With only tag filter' {
   get_detail
   tag_filter="OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="TAG_FLTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="TAG_FLTR"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:16,type:dm
@test '[DER016]DM With Single Tag filter' {
   get_detail
   tag_filter="Environ=QA"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="SIN_TAG_FLTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="SIN_TAG_FLTR"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:17,type:dm
@test '[DER017]DM With Multiple tag filter' {
   get_detail
   tag_filter="Environ=QA,OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_TAG_FLTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="MUL_TAG_FLTR"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:18,type:dm
@test '[DER018]DM With Multiple invalid tag filter' {
   get_detail
   tag_filter="Work=Cavisson,Time=IST"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_INV_TAG_FLTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="MUL_INV_TAG_FLTR"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:19,type:dm
@test '[DER019]DM With valid tag name and invalid tag filter value' {
   get_detail
   tag_filter="Environ=Dev"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="VAL_TAG_ATTR_INV_TAG_FLTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:20,type:dm
@test '[DER020]DM With invalid tag name and invalid tag filter value' {
   get_detail
   tag_filter="Work=Cavisson"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="INV_TAG_FLTR_TAG_ATTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="INV_TAG_FLTR_TAG_ATTR"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:21,type:dm
@test '[DER021]DM With invalid tag name and valid tag filter value' {
   get_detail
   tag_filter="Home=QA"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="INV_TAG_ATTR_VAL_TAG_FLTR" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="INV_TAG_ATTR_VAL_TAG_FLTR"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:22,type:dm,case:all
@test '[DER022]DM Without Tag Attr group BY,case:all' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="WO_TAG_ATTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="WO_TAG_ATTR_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:23,type:dm,case:all
@test '[DER023]DM Without Tag Attr group By and tag_filter,case:all' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="WO_TAG_ATTR_TAG_FILTER_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="WO_TAG_ATTR_TAG_FILTER_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:24,type:dm,case:all
@test '[DER024]DM With One Tag Attr group By,case:all' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_ATTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="ONE_TAG_ATTR_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:25,type:dm,case:all
@test '[DER025]DM With With multiple tag attr in group by from same Metric group (Environ,Shift),case:all' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_TAG_ATTR_SM_MG_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,Shift" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="MUL_TAG_ATTR_SM_MG_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:26,type:dm,case:all
@test '[DER026]DM With multiple same tag Attr group by from different Metric group (Team,Loc) present in both MG,case:all' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_SM_TAG_ATTR_DF_MG_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Team,Loc" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="MUL_SM_TAG_ATTR_DF_MG_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   NAME="TEST"
   check_name "$NAME" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:27,type:dm,case:all
@test '[DER027]DM With invalid group by on tag,case:all' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="INV_TAG_ATTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Home" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:28,type:dm,case:all
@test '[DER028]DM With Multiple tags from different metric group (Environ,OS),case:all' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_TAG_ATTR_DF_MG_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,OS" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:29,type:dm,case:all
@test '[DER029]DM With tag filter(Shift) and group by(Environ) of Same MG,case:all' {
   get_detail
   tag_filter="Shift=Day"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="TAG_ATTR_SM_MG_TAG_FILTER_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="TAG_ATTR_SM_MG_TAG_FILTER_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:30,type:dm,case:all
@test '[DER030]DM With tag filter(OS) and group by(Environ) different MG,case:all' {
   get_detail
   tag_filter="OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_FILTER_TAG_ATTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:31,type:dm,case:all
@test '[DER031]DM With invalid tag filter and invalid group by,case:all' {
   get_detail
   tag_filter="Type=first"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="INV_TAG_FILTER_TAG_ATTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Env" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:32,type:dm,case:all
@test '[DER032]DM With one tag_filter(Team=TSDB) and multiple group by(Environ,Shift) by From Same MG,case:all' {
   get_detail
   tag_filter="Team=TSDB"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_FILTER_MUL_TAG_ATTR_SM_MG_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,Shift" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="ONE_TAG_FILTER_MUL_TAG_ATTR_SM_MG_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:33,type:dm,case:all
@test '[DER033]DM With one tag_filter(OS=Windows) and multiple group by(Environ,Shift) by From different MG,case:all' {
   get_detail
   tag_filter="OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_FLTR_MUL_TAG_ATTR_DF_MG_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,Shift" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:34,type:dm,case:all
@test '[DER034]DM With one tag_filter(OS=Windows) and different MG multiple group by (Environ,OS) by From different MG,case:all' {
   get_detail
   tag_filter="OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="ONE_TAG_FLTR_DF_MG_TAG_ATTR_DF_MG_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,OS" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:35,type:dm,case:all
@test '[DER035]DM Without tag filter,case:all' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="WO_TAG_FLTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" TAG_ATT_GRP_BY="Environ,OS" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:36,type:dm,case:all
@test '[DER036]DM With only tag filter,case:all' {
   get_detail
   tag_filter="OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="TAG_FLTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="TAG_FLTR_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:37,type:dm,case:all
@test '[DER037]DM With Single Tag filter,case:all' {
   get_detail
   tag_filter="Environ=QA"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="SIN_TAG_FLTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="SIN_TAG_FLTR_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:38,type:dm,case:all
@test '[DER038]DM With Multiple tag filter,case:all' {
   get_detail
   tag_filter="Environ=QA,OS=Windows"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_TAG_FLTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="MUL_TAG_FLTR_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:39,type:dm,case:all
@test '[DER039]DM With Multiple invalid tag filter,case:all' {
   get_detail
   tag_filter="Work=Cavisson,Time=IST"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="MUL_INV_TAG_FLTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="MUL_INV_TAG_FLTR_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:40,type:dm,case:all
@test '[DER040]DM With valid tag name and invalid tag filter value,case:all' {
   get_detail
   tag_filter="Environ=Dev"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="VAL_TAG_ATTR_INV_TAG_FLTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="VAL_TAG_ATTR_INV_TAG_FLTR_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:41,type:dm,case:all
@test '[DER041]DM With invalid tag name and invalid tag filter value,case:all' {
   get_detail
   tag_filter="Work=Cavisson"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="INV_TAG_FLTR_TAG_ATTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="INV_TAG_FLTR_TAG_ATTR_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:42,type:dm,case:all
@test '[DER042]DM With invalid tag name and valid tag filter value,case:all' {
   get_detail
   tag_filter="Home=QA"
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="INV_TAG_ATTR_VAL_TAG_FLTR_ALL" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" TAG_NAME="Home=QA" OUTFILE=$RESPONSE_FILE
   DMG_NAME="INV_TAG_ATTR_VAL_TAG_FLTR_ALL"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:43,type:dm,case:all1
@test '[DER043]DM With subject pattern all, diff tag on both subject' {
   get_detail
   run_query OP=dc NUM_DERIVED_METRIC=1 DMG_NAME="WITH_DF_TAG_BOTH_SUB" ID=1 GROUP_DESC="my_derived" DERIVED_METRIC_NAME="TEST" DERIVED_METRIC_DESC="Test_for_derived_metric" FORMULA="NA" AGG_TYPE=1 AGG_BY=0 D_LEVEL="Tier,Server" NUM_VARIABLE=1 VAR_EXP=2 AGG_FN=0 UNARY_FN_CNT=0  VAR_NAME="A" GCTX_LEN=1 SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="WITH_DF_TAG_BOTH_SUB"
   check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
   D_LEVEL="Tier>Server"
   check_level "$D_LEVEL" "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=id:44,type:dm,case:all1,test:1
@test '[DCN044]Datacall With Derived Metric' {
  get_detail
  case=all
  MGroup=WITH_DF_TAG_BOTH_SUB
  change_mgroup
  run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="WITH_DF_TAG_BOTH_SUB"
  check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
  output=$(validate_output)
  assert_output "PASS"
}

#bats test_tags=id:45,type:dm,case:all1,test:1
@test '[DCN045]Datacall With Derived Metric' {
  get_detail
  case=all
  MGroup=WITH_DF_TAG_BOTH_SUB
  change_mgroup
  tag_filter='Environ=Dev'
  automation_log "tag=${tag_filter}"
  run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="WITH_DF_TAG_BOTH_SUB"
  check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
  output=$(validate_output)
  assert_output "PASS"
}

#bats test_tags=id:46,type:dm,case:all1,test:1
@test '[DCN046]Datacall With Derived Metric' {
  get_detail
  case=all
  MGroup=WITH_DF_TAG_BOTH_SUB
  change_mgroup
  tag_filter="Environ=Client"
  run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" TAG_NAME="${tag_filter}" OUTFILE=$RESPONSE_FILE
   DMG_NAME="WITH_DF_TAG_BOTH_SUB"
  check_mgroup "$DMG_NAME" "$RESPONSE_FILE"
  output=$(validate_output)
  assert_output "PASS"
}


#bats test_tags=id:47,type:dsl
@test '[DER047]Subject list With correct derived MG name' {
   get_detail
   run_query OP=dsl MG_NAME="TAG_ATTR_SM_MG_TAG_FILTER" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:48,type:dsl
@test '[DER048]Subject list With incorrect derived MG name' {
   get_detail
   run_query OP=dsl MG_NAME="TAG_ATTR" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:49,type:dsl
@test '[DER049]Subject list With correct derived MG name' {
   get_detail
   run_query OP=dsl MG_NAME="TAG_ATTR_SM_MG_TAG_FILTER_ALL" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:50,type:dsl
@test '[DER050]Subject list With incorrect derived MG name' {
   get_detail
   run_query OP=dsl MG_NAME="TAG_ATTR" OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:51
@test '[DCN051]Datacall With Derived Metric' {
  get_detail
  MGroup=WO_TAG_ATTR
  change_mgroup
  run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" OUTFILE=$RESPONSE_FILE
}




#bats test_tags=id:52,op:mom
@test '[MOM052]Metadata Open Merge With Derived Metric, Version-2, MGroup=WO_TAG_ATTR_ALL' {
  get_detail
  case=all
  MGroup=WO_TAG_ATTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:53,op:mom
@test '[MOM053]Metadata Open Merge With Derived Metric, Version-1, MGroup=WO_TAG_ATTR_TAG_FILTER_ALL' {
  get_detail
  case=all
  MGroup=WO_TAG_ATTR_TAG_FILTER_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:54,op:mom
@test '[MOM054]Metadata Open Merge With Derived Metric, Version-2, MGroup=WO_TAG_ATTR_TAG_FILTER_ALL' {
  get_detail
  case=all
  MGroup=WO_TAG_ATTR_TAG_FILTER_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:55,op:mom
@test '[MOM055]Metadata Open Merge With Derived Metric, Version-1, MGroup=ONE_TAG_ATTR_ALL' {
  get_detail
  case=all
  MGroup=ONE_TAG_ATTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:56,op:mom
@test '[MOM056]Metadata Open Merge With Derived Metric, Version-2, MGroup=ONE_TAG_ATTR_ALL' {
  get_detail
  case=all
  MGroup=ONE_TAG_ATTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:57,op:mom
@test '[MOM057]Metadata Open Merge With Derived Metric, Version-1, MGroup=MUL_TAG_ATTR_SM_MG_ALL' {
  get_detail
  case=all
  MGroup=MUL_TAG_ATTR_SM_MG_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:58,op:mom
@test '[MOM058]Metadata Open Merge With Derived Metric, Version-2, MGroup=MUL_TAG_ATTR_SM_MG_ALL' {
  get_detail
  case=all
  MGroup=MUL_TAG_ATTR_SM_MG_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:59,op:mom
@test '[MOM059]Metadata Open Merge With Derived Metric, Version-1, MGroup=MUL_SM_TAG_ATTR_DF_MG_ALL' {
  get_detail
  case=all
  MGroup=MUL_SM_TAG_ATTR_DF_MG_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:60,op:mom
@test '[MOM060]Metadata Open Merge With Derived Metric, Version-2, MGroup=MUL_SM_TAG_ATTR_DF_MG_ALL' {
  get_detail
  case=all
  MGroup=MUL_SM_TAG_ATTR_DF_MG_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:61,op:mom
@test '[MOM061]Metadata Open Merge With Derived Metric, Version-1, MGroup=TAG_ATTR_SM_MG_TAG_FILTER_ALL' {
  get_detail
  case=all
  MGroup=TAG_ATTR_SM_MG_TAG_FILTER_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:62,op:mom
@test '[MOM062]Metadata Open Merge With Derived Metric, Version-2, MGroup=TAG_ATTR_SM_MG_TAG_FILTER_ALL' {
  get_detail
  case=all
  MGroup=TAG_ATTR_SM_MG_TAG_FILTER_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:63,op:mom
@test '[MOM063]Metadata Open Merge With Derived Metric, Version-1, MGroup=ONE_TAG_FILTER_MUL_TAG_ATTR_SM_MG_ALL' {
  get_detail
  case=all
  MGroup=ONE_TAG_FILTER_MUL_TAG_ATTR_SM_MG_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:64,op:mom
@test '[MOM064]Metadata Open Merge With Derived Metric, Version-2, MGroup=ONE_TAG_FILTER_MUL_TAG_ATTR_SM_MG_ALL' {
  get_detail
  case=all
  MGroup=ONE_TAG_FILTER_MUL_TAG_ATTR_SM_MG_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:65,op:mom
@test '[MOM065]Metadata Open Merge With Derived Metric, Version-1, MGroup=TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:66,op:mom
@test '[MOM066]Metadata Open Merge With Derived Metric, Version-2, MGroup=TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:67,op:mom
@test '[MOM067]Metadata Open Merge With Derived Metric, Version-1, MGroup=SIN_TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=SIN_TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:68,op:mom
@test '[MOM068]Metadata Open Merge With Derived Metric, Version-2, MGroup=SIN_TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=SIN_TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:69,op:mom
@test '[MOM069]Metadata Open Merge With Derived Metric, Version-1, MGroup=MUL_TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=MUL_TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:70,op:mom
@test '[MOM070]Metadata Open Merge With Derived Metric, Version-2, MGroup=MUL_TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=MUL_TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:71,op:mom
@test '[MOM071]Metadata Open Merge With Derived Metric, Version-1, MGroup=MUL_INV_TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=MUL_INV_TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:72,op:mom
@test '[MOM072]Metadata Open Merge With Derived Metric, Version-2, MGroup=MUL_INV_TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=MUL_INV_TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:73,op:mom
@test '[MOM073]Metadata Open Merge With Derived Metric, Version-1, MGroup=INV_TAG_FLTR_TAG_ATTR_ALL' {
  get_detail
  case=all
  MGroup=INV_TAG_FLTR_TAG_ATTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:74,op:mom
@test '[MOM074]Metadata Open Merge With Derived Metric, Version-2, MGroup=INV_TAG_FLTR_TAG_ATTR_ALL' {
  get_detail
  case=all
  MGroup=INV_TAG_FLTR_TAG_ATTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:75,op:mom
@test '[MOM075]Metadata Open Merge With Derived Metric, Version-1, MGroup=INV_TAG_ATTR_VAL_TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=INV_TAG_ATTR_VAL_TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=1 OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:76,op:mom
@test '[MOM076]Metadata Open Merge With Derived Metric, Version-2, MGroup=INV_TAG_ATTR_VAL_TAG_FLTR_ALL' {
  get_detail
  case=all
  MGroup=INV_TAG_ATTR_VAL_TAG_FLTR_ALL
  create_open_merge
  run_query OP=mom INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt VERSION=2 OUTFILE=$RESPONSE_FILE
}








#bats test_tags=id:77,op:mor
@test '[MOR077]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=WO_TAG_ATTR_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:78,op:mor
@test '[MOR078]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=WO_TAG_ATTR_TAG_FILTER_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:79,op:mor
@test '[MOR079]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=ONE_TAG_ATTR_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:80,op:mor
@test '[MOR080]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=MUL_TAG_ATTR_SM_MG_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:81,op:mor
@test '[MOR081]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=MUL_SM_TAG_ATTR_DF_MG_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:82,op:mor
@test '[MOR082]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=TAG_ATTR_SM_MG_TAG_FILTER_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:83,op:mor
@test '[MOR083]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=ONE_TAG_FILTER_MUL_TAG_ATTR_SM_MG_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:84,op:mor
@test '[MOR084]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=TAG_FLTR_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:85,op:mor
@test '[MOR085]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=SIN_TAG_FLTR_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:86,op:mor
@test '[MOR086]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=MUL_TAG_FLTR_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:87,op:mor
@test '[MOR087]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=MUL_INV_TAG_FLTR_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:88,op:mor
@test '[MOR088]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=INV_TAG_FLTR_TAG_ATTR_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}

#bats test_tags=id:89,op:mor
@test '[MOR089]Metadata Open Related With Derived Metric' {
  get_detail
  case=all
  MGroup=INV_TAG_ATTR_VAL_TAG_FLTR_ALL
  create_open_related
  run_query OP=mor INPFILE=$NS_WDIR/TSDB/tsdb/automation/.tmp/$BATS_TEST_NUMBER.txt OUTFILE=$RESPONSE_FILE
}
