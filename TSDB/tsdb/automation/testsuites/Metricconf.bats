#!/home/cavisson/bin/bats

#get_metric() {
 #  if [ $TAG_FLAG -eq 1 ];then
  #   automation_log "1....TAG_FLAG=$TAG_FLAG"
   #  METRIC_LINE=`grep "Tier:datacall-tier" $METRIC_FILE | grep "tags:" | shuf -n 1`
   #else
 #    METRIC_LINE=`grep "Tier:datacall-tier" $METRIC_FILE |grep -v "tags"| shuf -n 1`
  # fi
   
  # METRIC_ID=`echo $METRIC_LINE | cut -d',' -f1` 
  # NFIDX=`echo $METRIC_LINE | cut -d',' -f2`
   #TAGS=`echo $METRIC_LINE | cut -d'"' -f2`
  # SUBJECT=`echo $METRIC_LINE | cut -d"," -f3`
   #if [ $TAG_FLAG -eq 1 ];then
    #  MEASURE=`echo $METRIC_LINE | rev | cut -d',' -f2-4|rev`
  # else
   #MEASURE=`echo $METRIC_LINE | cut -d"," -f4-6`
   #fi
   #MEASURE=`echo $METRIC_LINE | rev | cut -d"," -f2-4 | rev`
 #  echo "export METRIC_LINE='$METRIC_LINE'" > ${MT_DETAIL_FILE}
 #  echo "export METRIC_ID=$METRIC_ID" >> ${MT_DETAIL_FILE}
 #  echo "export NFIDX=$NFIDX" >> ${MT_DETAIL_FILE}
 #  echo "export SUBJECT='$SUBJECT'" >> ${MT_DETAIL_FILE}
 #  echo "export MEASURE='$MEASURE'" >> ${MT_DETAIL_FILE}
  #echo "export TAGS='$TAGS'" >> ${MT_DETAIL_FILE}
#}

setup() {
  source ./testsuites/common
  common_setup
  source $DATACALL_LIB/Metricconf_lib
  source $TSDB_REQ
  source ./testsuites/MetricDetails
  automation_log "SUBJECT=$SUBJECT"
  export RESPONSE_FILE="$METRIC_CONF/MC_${BATS_TEST_NUMBER}".txt
#  if [ $BATS_TEST_NUMBER -eq 1 ];then
   #  if [ $MODE -eq 1 ] ;then
    #    export MT_DETAIL_FILE="MetricDetails.conf"
    # else
 #       get_metric
     #fi
  #fi
  
#  source ${MT_DETAIL_FILE}
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
  export DT_FILTER=()
}


#------------------------------------------------ Data call by Name ----------------------------------------------------------------

#bats test_tags=op:dcn,test:first,r:a
@test '[MC001]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" 
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_name
   output=$(validate_response)
   assert_output "PASS" 
}

#bats test_tags=op:dcn,test:first
@test '[MC002]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC003]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, ROLL_UP_BY' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" 
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first,unit:id
@test '[MC004]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, UNIT' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
#   unit_id
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,test:first,sub:tag
@test '[MC005]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC006]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, TRANS_OP=' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC007]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, ROLL_UP_BY' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC008]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_name
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC009]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, UNIT' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" UNIT="$UNIT"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0010]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, TRANS_OP' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0011]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" SUB_TAGS="$SUB_TAGS" 
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0012]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0013]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, ROLL_UP_BY, UNIT' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0014]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, ROLL_UP_BY, TRANS_OP' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0015]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, ROLL_UP_BY, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0016]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" 
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0017]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0018]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0019]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, UNIT, TRANS_OP' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" UNIT="$UNIT" TRANS_OP="$TRANS_OP" 
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0020]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, UNIT, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0021]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, TRANS_OP, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0022]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0023]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, ROLL_UP_BY, UNIT' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0024]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, ROLL_UP_BY, TRANS_OP' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0025]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, ROLL_UP_BY, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0026]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0027]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0028]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, DECIMAL_PLACES' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0029]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0030]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, TRANS_OP' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0031]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, ROLL_UP_BY' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0032]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0033]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, DECIMAL_PLACES' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0034]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, TRANS_OP, SUB_TAGS, UNIT' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_tags 
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0035]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, TRANS_OP, SUB_TAGS, ROLL_UP_BY' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0036]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, TRANS_OP, SUB_TAGS, DECIMAL_PLACES, ' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Exact"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0037]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0038]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, UNIT' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" UNIT="$UNIT" 
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0039]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0040]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,test:first
@test '[MC0041]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Exact, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP, SUB_TAGS' {
    
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUBJECT" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Exact"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}





#--------------------------------- Data Call by name with Subjectmode Pattern ---------------------------------------------------------------------

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0042]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0043]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0044]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, ROLL_UP_BY' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0045]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0046]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0047]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0048]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, ROLL_UP_BY' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0049]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0050]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0051]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0052]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0053]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0054]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, ROLL_UP_BY, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0055]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, ROLL_UP_BY, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0056]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, ROLL_UP_BY, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0057]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0058]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0059]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS=' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0060]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, UNIT, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0061]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, UNIT, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0062]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, TRANS_OP, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0063]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0064]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, ROLL_UP_BY, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0065]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, ROLL_UP_BY, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0066]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, ROLL_UP_BY, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0067]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0068]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0069]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, DECIMAL_PLACES' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0070]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0071]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0072]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, ROLL_UP_BY' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0073]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0074]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, DECIMAL_PLACES' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0075]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, TRANS_OP, SUB_TAGS, UNIT' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0076]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, TRANS_OP, SUB_TAGS, ROLL_UP_BY' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0077]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, TRANS_OP, SUB_TAGS, DECIMAL_PLACES' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0078]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0079]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0080]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0081]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"0
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern,test:second
@test '[MC0082]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=tier, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:datacall-tier-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}



#bats test_tags=op:dcn,submode:pattern
@test '[MC0083]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0084]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0085]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, ROLL_UP_BY' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0086]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0087]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0088]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0089]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, ROLL_UP_BY' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0090]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, ' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0091]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0092]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0093]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0094]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0095]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, ROLL_UP_BY, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0096]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, ROLL_UP_BY, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0097]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, ROLL_UP_BY, SUB_TAGS, ' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0098]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0099]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0100]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0101]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, UNIT, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0102]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, UNIT, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0103]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, TRANS_OP, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0104]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0105]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, ROLL_UP_BY, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0106]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, ROLL_UP_BY, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0107]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, ROLL_UP_BY, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0108]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0109]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0110]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, DECIMAL_PLACES' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0111]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0112]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0113]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, ROLL_UP_BY' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0114]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0115]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, DECIMAL_PLACES' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0116]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, TRANS_OP, SUB_TAGS, UNIT' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0117]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, TRANS_OP, SUB_TAGS, ROLL_UP_BY' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0118]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, TRANS_OP, SUB_TAGS, DECIMAL_PLACES' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0119]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0120]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0121]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0122]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0123]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, SUB_NAME, TRANS_OP, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:datacall-server-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0124]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0125]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" 
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0126]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, ROLL_UP_BY' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0127]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0128]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0129]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0130]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, ROLL_UP_BY' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0131]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0132]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0133]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0134]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0135]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0136]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, ROLL_UP_BY, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0137]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, ROLL_UP_BY, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0138]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, ROLL_UP_BY, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0139]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0140]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0141]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0142]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, MEASURE, UNIT, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0143]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, UNIT, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0144]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, TRANS_OP, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0145]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0146]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, ROLL_UP_BY, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0147]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, ROLL_UP_BY, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0148]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, ROLL_UP_BY, SUB_TAGS, ' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0149]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0150]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0151]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, DECIMAL_PLACES' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0152]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0153]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0154]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, ROLL_UP_BY' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0155]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0156]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, DECIMAL_PLACES' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0157]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, TRANS_OP, SUB_TAGS, UNIT' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0158]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, TRANS_OP, SUB_TAGS, ROLL_UP_BY' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0159]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, TRANS_OP, SUB_TAGS, DECIMAL_PLACES' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0160]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0161]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0162]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0163]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0164]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d':' -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:Processor-*/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0165]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:patterni
@test '[MC0166]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0167]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, ROLL_UP_BY' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0168]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0169]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0170]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0171]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, ROLL_UP_BY' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0172]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0173]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0174]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0175]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0176]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0177]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, ROLL_UP_BY, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0178]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, ROLL_UP_BY, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0179]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, ROLL_UP_BY, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0180]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0181]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0182]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0183]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, UNIT, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0184]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, UNIT, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0185]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, TRANS_OP, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" 
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0186]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0187]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, ROLL_UP_BY, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0188]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, ROLL_UP_BY, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0189]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, ROLL_UP_BY, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags 
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0190]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0191]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0192]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, DECIMAL_PLACES' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0193]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0194]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0195]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, ROLL_UP_BY' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0196]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0197]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, DECIMAL_PLACES' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0198]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, TRANS_OP, SUB_TAGS, UNIT' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0199]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, TRANS_OP, SUB_TAGS, ROLL_UP_BY' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0200]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, TRANS_OP, SUB_TAGS, DECIMAL_PLACES' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "Pattern"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0201]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0202]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0203]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:pattern
@test '[MC0204]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=Pattern, PatternOn=all, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "Pattern"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}


#----------------------------------------------------- Data Call by name with Subject mode ALL--------------------------------------------------

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0205]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0206]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL_PLACES' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0207]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0208]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0209]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0210]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, DECIMAL_PLACES' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0211]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0212]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0213]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0214]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL_PLACES, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0215]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL_PLACES, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" TRANS_OP="$TRANS_OP" 
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0216]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL_PLACES, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0217]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, UNIT, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0218]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, UNIT, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0219]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL="$DECIMAL" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" 
   set_dcn_expected_values "10" "ALL" 
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0220]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL, ROLL_UP_BY, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL="$DECIMAL" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0221]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL, ROLL_UP_BY, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL="$DECIMAL" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP" 
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0222]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL, ROLL_UP_BY, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL="$DECIMAL" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT" 
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0223]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL, ROLL_UP_BY, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL="$DECIMAL" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0224]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, DECIMAL, ROLL_UP_BY, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL="$DECIMAL" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0225]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0226]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0227]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPESUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0228]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0229]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, SUB_TAGS' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0230]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, UNIT, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" UNIT="$UNIT" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0231]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, TRANS_OP, SUB_TAGS, DECIMAL' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" DECIMAL="$DECIMAL"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0232]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" 
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0233]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, TRANS_OP, SUB_TAGS, UNIT' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0234]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, TRANS_OP, SUB_TAGS, UNIT, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0235]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, TRANS_OP, SUB_TAGS, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=tc:6,op:dcn,submode:all
@test '[MC0236]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=tier, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, ROLL_UP_BY, DECIMAL' {
    
   TIER=`echo $SUBJECT | cut -d'>' -f3`
   TIER_1=`echo $TIER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$TIER/${TIER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" ROLL_UP_BY="$ROLL_UP_BY" DECIMAL="$DECIMAL"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[MC0237]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0238]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0239]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, ROLL_UP_BY' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0240]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0241]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0242]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0243]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, ROLL_UP_BY' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0244]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0245]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, UNIT' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0246]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0247]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_TAGS="$SUB_TAGS" 
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0248]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0249]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, ROLL_UP_BY, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0250]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, ROLL_UP_BY, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0251]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, ROLL_UP_BY, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0252]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0253]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0254]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0255]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, UNIT, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0256]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, UNIT, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0257]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, TRANS_OP, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0258]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0259]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0260]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, ROLL_UP_BY, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0261]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, ROLL_UP_BY, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0262]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, ROLL_UP_BY, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0263]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0264]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0265]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, DECIMAL_PLACES' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0266]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0267]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0268]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, ROLL_UP_BY' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0269]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS" 
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0270]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, DECIMAL_PLACES' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0271]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, TRANS_OP, SUB_TAGS, UNIT' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0272]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, TRANS_OP, SUB_TAGS, ROLL_UP_BY' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0273]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, TRANS_OP, SUB_TAGS, DECIMAL_PLACES' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0274]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0275]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, UNIT' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0276]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0277]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0278]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=server, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP, SUB_TAGS' {
    
   SERVER=`echo $SUBJECT | cut -d'>' -f4`
   SERVER_1=`echo $SERVER | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$SERVER/${SERVER_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[MC0279]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0280]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0281]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0282]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, ROLL_UP_BY' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0283]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0284]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0285]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0286]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, ROLL_UP_BY' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0287]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0288]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0289]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0290]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0291]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0292]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, ROLL_UP_BY, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0293]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, ROLL_UP_BY, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0294]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, ROLL_UP_BY, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0295]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0296]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0297]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0298]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, UNIT, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0299]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, UNIT, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0300]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, TRANS_OP, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0301]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0302]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, ROLL_UP_BY, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0303]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, ROLL_UP_BY, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0304]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, ROLL_UP_BY, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0305]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}
#bats test_tags=op:dcn,submode:all
@test '[MC0306]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0307]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, DECIMAL_PLACES' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0308]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0309]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0310]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, ROLL_UP_BY' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0311]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0312]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, DECIMAL_PLACES' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0313]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, TRANS_OP, SUB_TAGS, UNIT' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0314]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, TRANS_OP, SUB_TAGS, ROLL_UP_BY' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0315]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, TRANS_OP, SUB_TAGS, DECIMAL_PLACES' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0316]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0317]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, UNIT' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0318]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0319]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0320]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=all, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP, SUB_TAGS' {
    
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
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0321]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0322]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0323]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, ROLL_UP_BY, ROLL_UP_BY' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0324]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0325]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0326]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0327]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, ROLL_UP_BY' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0328]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0329]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0330]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0331]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" SUB_TAGS="$SUB_TAGS"
      set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0332]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0333]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, ROLL_UP_BY, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0334]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, ROLL_UP_BY, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0335]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, ROLL_UP_BY, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0336]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0337]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0338]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0339]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, UNIT, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0340]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, UNIT, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0341]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, TRANS_OP, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0342]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0343]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, ROLL_UP_BY, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0345]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, ROLL_UP_BY, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0346]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, ROLL_UP_BY, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0347]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0348]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, SUB_TAGS' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0349]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, DECIMAL_PLACES' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0350]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, ROLL_UP_BY, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" ROLL_UP_BY="$ROLL_UP_BY" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[MC0351]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0352]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, ROLL_UP_BY' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[MC0353]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, SUB_TAGS' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE"  SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all,rahul:bisht
@test '[MC0354]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE, UNIT, DECIMAL_PLACES' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" UNIT="$UNIT" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[MC0355]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, TRANS_OP, SUB_TAGS, UNIT' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0356]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, TRANS_OP, SUB_TAGS, ROLL_UP_BY' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" ROLL_UP_BY="$ROLL_UP_BY"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0357]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, TRANS_OP, SUB_TAGS, DECIMAL_PLACES' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" DECIMAL_PLACES="$DECIMAL_PLACES"
   set_dcn_expected_values "10" "ALL"
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all
@test '[MC0358]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, TRANS_OP, SUB_TAGS, SUB_NAME, AGGR_TYPE, AGG_SUB_TYPE' {
    
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS" SUB_NAME="$SUB_NAME" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[MC0359]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, UNIT' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" UNIT="$UNIT"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[MC0360]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, SUB_TAGS' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}


#bats test_tags=op:dcn,submode:all
@test '[MC0361]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   output=$(validate_response)
   assert_output "PASS"
}

#bats test_tags=op:dcn,submode:all,test:last1
@test '[MC0362]OP=DCN, TP=L10m, MDM=Normal, SUB_MODE=ALL, ALLOn=instance, DECIMAL_PLACES, ROLL_UP_BY, AGGR_TYPE, AGG_SUB_TYPE, SUB_NAME, TRANS_OP, SUB_TAGS' {
   INSTANCE=`echo $SUBJECT | cut -d'>' -f5`
   INSTANCE_1=`echo $INSTANCE | cut -d":" -f1`
   export SUB_PATTERN=`echo $SUBJECT | sed "s/$INSTANCE/${INSTANCE_1}:ALL/g"`
   run_query OP=dcn TP_TYPE=preset DURATION=10 OUTFILE=$RESPONSE_FILE SUBJECT="$SUB_PATTERN" MEASURE="$MEASURE" DECIMAL_PLACES="$DECIMAL_PLACES" ROLL_UP_BY="$ROLL_UP_BY" AGGR_TYPE="$AGGR_TYPE" AGG_SUB_TYPE="$AGG_SUB_TYPE" SUB_NAME="$SUB_NAME" TRANS_OP="$TRANS_OP" SUB_TAGS="$SUB_TAGS"
   set_dcn_expected_values "10" "ALL"
   sub_name
   extract_actual_output
   sub_tags
   output=$(validate_response)
   assert_output "PASS"
}





























