#!/home/cavisson/bin/bats

polling_wait()	
{
   rule_id=$1
   poll_time=2s
   counter=0
   for ((i=1 ; i<=1; i++))
   #while(1)
   do
      counter=$(grep -c "Going to send Alert to TSDB for rule ${rule_id}" $Alert_file)
      if [ $counter -gt 0 ];
      then
          break
      else
          sleep $poll_time
      fi
   done
   automation_log "counter = $counter"
   if [ $counter -eq 0 ];
   then
       echo "Alert Not Generated yet"
   else
       echo "1"
   fi
}

set_json_path() {
   alert_type=$1
   filename=$2
   JSON_FILE="$NS_WDIR/TSDB/tsdb/automation/${alert_type}_condition/${filename}"
}

setup() {
   source ./testsuites/common
   common_setup
   if [ $BATS_TEST_NUMBER -eq 1 ];then
      rm -rf $LOG_FILE
   fi
   source $NS_WDIR/AlertManager/alert_manager.env
   #JSON_FILE="$NS_WDIR/automation/${JSON_PATH}"
   DELETE_FILE_PATH="$NS_WDIR/TSDB/tsdb/automation/threshold_delete_json"
   OUT_FILE="$NS_WDIR/TSDB/tsdb/automation/alert_responses/Alert_$BATS_TEST_NUMBER.json"
   TR_NUM=$(grep "^nde.testRunNum" $NS_WDIR/webapps/sys/config.ini | cut -d"=" -f2 | xargs)
   automation_log "TR=$TR_NUM"
   Alert_file="$NS_WDIR/logs/TR$TR_NUM/tsdb/logs/alert_trace.log.1"
   #Alert_file="$NS_WDIR/logs/TR2000/tsdb/logs/alert_trace.log.1"
   Rule_Id_JSON="$NS_WDIR/logs/TR$TR_NUM/tsdb/alerts/.tmp/debug"
   VAL_FILE="$NS_WDIR/TSDB/tsdb/automation/validation_responses/Validation_$BATS_TEST_NUMBER.txt"
   automation_log ""
   automation_log "TC - $BATS_TEST_DESCRIPTION"
   touch $LOG_FILE
}

teardown() {
  resp_id=`cat $OUT_FILE | cut -d',' -f3 | cut -d':' -f3`
  automation_log $resp_id
  delete_id=`cat $DELETE_FILE_PATH/delete_threshold_avg_above.json | grep "id" | head -1 | cut -d',' -f1 | cut -d':' -f2 | xargs`
  sed -i 's/$delete_id/$resp_id/' $DELETE_FILE_PATH/delete_threshold_avg_above.json
  curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/delete -H "Content-Type: application/json" -d @"${DELETE_FILE_PATH/delete_threshold_avg_above.json}" 
}

#bats test_tags=TC:001
@test '[AL-001]Threshold Condition=Average Above' {
   set_json_path threshold threshold_avg_above.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id" 
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   automation_log "threshold_value=$threshold_value"
   automation_log "Print=grep Going to send Alert to TSDB for rule $rule_id $Alert_file"
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   automation_log "$cmd"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:002
@test '[AL-002]Threshold Condition=Average Above or Equal To' {
   set_json_path threshold threshold_avg_above_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:003
@test '[AL-003]Threshold Condition=Average Below' {
   set_json_path threshold threshold_avg_below.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"  
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:004
@test '[AL-004]Threshold Condition=Average below or Equal To' {
   set_json_path threshold threshold_avg_below_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:005
@test '[AL-005]Threshold Condition=Sum of Every Above' {
   set_json_path threshold threshold_SOE_above.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:006
@test '[AL-006]Threshold Condition=Sum of Every Above or Equal To' {
   set_json_path threshold threshold_SOE_above_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:007
@test '[AL-007]Threshold Condition=Sum of Every Below' {
   set_json_path threshold threshold_SOE_below.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:008
@test '[AL-008]Threshold Condition=Sum of Every Below or Equal To' {
   set_json_path threshold threshold_SOE_below_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:009
@test '[AL-009]Threshold Condition=Maximum Above' {
   set_json_path threshold threshold_max_above.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:010
@test '[AL-010]Threshold Condition=Maximum Above or Equal To' {
   set_json_path threshold threshold_max_above_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:011
@test '[AL-011]Threshold Condition=Maximum Below' {
   set_json_path threshold threshold_max_below.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK" 
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:012
@test '[AL-012]Threshold Condition=Maximum Below or Equal To' {
   set_json_path threshold threshold_max_below_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:013
@test '[AL-013]Threshold Condition=Minimum Above' {
   set_json_path threshold threshold_min_above.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:014
@test '[AL-014]Threshold Condition=Minimum Above or Equal To' {
   set_json_path threshold threshold_min_above_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:015
@test '[AL-015]Threshold Condition=Minimum Below' {
   set_json_path threshold threshold_min_below.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:016
@test '[AL-016]Threshold Condition=Minimum Below or Equal To' {
   set_json_path threshold threshold_min_below_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:017
@test '[AL-017]Threshold Condition=Atleast one Above' {
   set_json_path threshold threshold_ALO_above.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:018
@test '[AL-018]Threshold Condition=Atleast one Above or Equal To' {
   set_json_path threshold threshold_ALO_above_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:019
@test '[AL-019]Threshold Condition=Atleast one Below' {
   set_json_path threshold threshold_ALO_below.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:020
@test '[AL-020]Threshold Condition=AAtleast one Below or Equal To' {
   set_json_path threshold threshold_ALO_below_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:021
@test '[AL-021]Threshold Condition=Every Above' {
   set_json_path threshold threshold_every_above.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:022
@test '[AL-022]Threshold Condition=Every Above or Equal To' {
   set_json_path threshold threshold_every_above_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:023
@test '[AL-023]Threshold Condition=Every Below' {
   set_json_path threshold threshold_every_below.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}

#bats test_tags=TC:024
@test '[AL-024]Threshold Condition=Every Below or Equal To' {
   set_json_path threshold threshold_every_below_or_equal_to.json
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   threshold_value=`jq '.rules[] | .attributes | .severity[] | .conditionList[] | .thresholdType | .fThreshold' ${JSON_FILE}`
   cmd="grep \"Going to send Alert to TSDB for rule ${rule_id}\" $Alert_file -A 18 | head -19 > $VAL_FILE"
   output=$(polling_wait ${rule_id})
   automation_log "$output"
   assert_output "1"
   eval $cmd
}
#bats test_tags=TC:
#@test '[AL-]Threshold Condition=Average Above' {
#  set_json_path threshold sample1.json
#  DATA_TYPE=0
#  OPERATOR=0
#  WINDOW_TYPE=1
#  cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE | sed "s/\$WINDO  W_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
#  curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
#  rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
#  assert_equal "$rep_status" "OK"
#  rule_id=`jq '.rules[0].id' $OUT_FILE`
#  
#    rule_id=$(./get_rule_id.sh)
#    automation_log "rule_id=$rule_id"
#    mv "$JSON_FILE" "$rule_{rule_id}.JSON"
#    JSON_FILE="${rule_id}_JSON"
#
#    ./rule_processing.sh "$JSON_FILE" "$rule_id" "$Alert_file" "$VAL_FILE"
#
#}

#bats test_tags=TC:026
 @test '[AL-026]Threshold Condition=Average Above' {
   set_json_path threshold sample1.json
   DATA_TYPE=0
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:027
@test '[AL-027]Threshold Condition=Average Above or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=0
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:028
@test '[AL-028]Threshold Condition=Average Below' {
   set_json_path threshold sample1.json
   DATA_TYPE=0
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:029
@test '[AL-029]Threshold Condition=Average Below or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=0
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:030
@test '[AL-030]Threshold Condition=Sum of Every Above' {
   set_json_path threshold sample1.json
   DATA_TYPE=1
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:031
@test '[AL-031]Threshold Condition=Sum of Every Above or Equal To' {
   #set_json_path threshold sample1.json
   DATA_TYPE=1
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:032
@test '[AL-032]Threshold Condition=Sum of Every Below' {
   set_json_path threshold sample1.json
   DATA_TYPE=1
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:033
@test '[AL-033]Threshold Condition=Sum of Every Below or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=1
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:034
@test '[AL-034]Threshold Condition=Maximum Above' {
   set_json_path threshold sample1.json
   DATA_TYPE=2
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:035
@test '[AL-035]Threshold Condition=Maximum Above or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=2
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:036
@test '[AL-036]Threshold Condition=Maximum Below' {
   set_json_path threshold sample1.json
   DATA_TYPE=2
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:037
@test '[AL-037]Threshold Condition=Maximum Below or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=2
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:038
@test '[AL-038]Threshold Condition=Minimum Above' {
   set_json_path threshold sample1.json
   DATA_TYPE=3
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:039
@test '[AL-039]Threshold Condition=Minimum Above or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=3
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:040
@test '[AL-040]Threshold Condition=Minimum Below' {
   set_json_path threshold sample1.json
   DATA_TYPE=3
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:041
@test '[AL-041]Threshold Condition=Minimum Below or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=3
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:042
@test '[AL-042]Threshold Condition=Atleast Above' {
   set_json_path threshold sample1.json
   DATA_TYPE=4
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:043
@test '[AL-043]Threshold Condition=Atleast Above or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=4
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:044
@test '[AL-044]Threshold Condition=Atleast Below' {
   set_json_path threshold sample1.json
   DATA_TYPE=4
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:045
@test '[AL-045]Threshold Condition=Atleast Below or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=4
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:046
@test '[AL-046]Threshold Condition=Every Above' {
   set_json_path threshold sample1.json
   DATA_TYPE=5
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:047
@test '[AL-047]Threshold Condition=Every Above or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=5
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:048
@test '[AL-048]Threshold Condition=Every Below' {
   set_json_path threshold sample1.json
   DATA_TYPE=5
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:049
@test '[AL-049]Threshold Condition=Every Below or Equal To' {
   set_json_path threshold sample1.json
   DATA_TYPE=5
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/threshold_condition/threshold_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/threshold_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/threshold_condition/$rule_{rule_id}.JSON
}

#=======================================================================================================================================================
#------------------------------------------------------------------------------------------------------------------------------------------------------


#bats test_tags=TC:050
 @test '[AL-050]Change Condition=Average Above' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=0
   CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:051
@test '[AL-051]Change Condition=Average Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:052
@test '[AL-052]Change Condition=Average Below' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=2
   CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE;
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:053
@test '[AL-053]Change Condition=Average Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:054
@test '[AL-054]Change Condition=Sum of Every Above' {
   set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:055
@test '[AL-055]Change Condition=Sum of Every Above or Equal To' {
   #set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:056
@test '[AL-056]Change Condition=Sum of Every Below' {
   set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:057
@test '[AL-057]Change Condition=Sum of Every Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:058
@test '[AL-058]Change Condition=Maximum Above' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:059
@test '[AL-059]Change Condition=Maximum Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:060
@test '[AL-060]Change Condition=Maximum Below' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:061
@test '[AL-061]Change Condition=Maximum Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:062
@test '[AL-062]Change Condition=Minimum Above' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:063
@test '[AL-063]Change Condition=Minimum Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:064
@test '[AL-064]Change Condition=Minimum Below' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:065
@test '[AL-065]Change Condition=Minimum Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:066
@test '[AL-066]Change Condition=Atleast Above' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:067
@test '[AL-067]Change Condition=Atleast Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:068
@test '[AL-068]Change Condition=Atleast Below' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:069
@test '[AL-069]Change Condition=Atleast Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:070
@test '[AL-070]Change Condition=Every Above' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:071
@test '[AL-071]Change Condition=Every Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:072
@test '[AL-072]Change Condition=Every Below' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:073
@test '[AL-073]Change Condition=Every Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=0
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#=======================================================================================================================================================
#------------------------------------------------------------------------------------------------------------------------------------------------------

#bats test_tags=TC:074
 @test '[AL-074]Change Condition=Average Above' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=0
   CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:075
@test '[AL-075]Change Condition=Average Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:076
@test '[AL-076]Change Condition=Average Below' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=2
   CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE;
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:077
@test '[AL-077]Change Condition=Average Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:078
@test '[AL-078]Change Condition=Sum of Every Above' {
   set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:079
@test '[AL-079]Change Condition=Sum of Every Above or Equal To' {
   #set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:080
@test '[AL-080]Change Condition=Sum of Every Below' {
   set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:081
@test '[AL-081]Change Condition=Sum of Every Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:082
@test '[AL-082]Change Condition=Maximum Above' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:083
@test '[AL-083]Change Condition=Maximum Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:084
@test '[AL-084]Change Condition=Maximum Below' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:085
@test '[AL-085]Change Condition=Maximum Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:086
@test '[AL-086]Change Condition=Minimum Above' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:087
@test '[AL-087]Change Condition=Minimum Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:088
@test '[AL-088]Change Condition=Minimum Below' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:089
@test '[AL-089]Change Condition=Minimum Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:090
@test '[AL-090]Change Condition=Atleast Above' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:091
@test '[AL-091]Change Condition=Atleast Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:092
@test '[AL-092]Change Condition=Atleast Below' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:093
@test '[AL-093]Change Condition=Atleast Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:094
@test '[AL-094]Change Condition=Every Above' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=0
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:095
@test '[AL-095]Change Condition=Every Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=1
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:096
@test '[AL-096]Change Condition=Every Below' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=2
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:097
@test '[AL-097]Change Condition=Every Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=3
	 CHANGE=0
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#============================================
#------------------------------------------------------------------------------------------------------------------------------------------------


#bats test_tags=TC:098
 @test '[AL-098]Change Condition=Average Above' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=0
   CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:099
@test '[AL-099]Change Condition=Average Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=1
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:100
@test '[AL-100]Change Condition=Average Below' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=2
   CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE;
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:101
@test '[AL-101]Change Condition=Average Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=0
   OPERATOR=3
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:102
@test '[AL-102]Change Condition=Sum of Every Above' {
   set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=0
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:103
@test '[AL-103]Change Condition=Sum of Every Above or Equal To' {
   #set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=1
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:104
@test '[AL-104]Change Condition=Sum of Every Below' {
   set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=2
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:105
@test '[AL-105]Change Condition=Sum of Every Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=1
   OPERATOR=3
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:106
@test '[AL-106]Change Condition=Maximum Above' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=0
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:107
@test '[AL-107]Change Condition=Maximum Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=1
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:108
@test '[AL-108]Change Condition=Maximum Below' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=2
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:109
@test '[AL-109]Change Condition=Maximum Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=2
   OPERATOR=3
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:110
@test '[AL-110]Change Condition=Minimum Above' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=0
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:111
@test '[AL-111]Change Condition=Minimum Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=1
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:112
@test '[AL-112]Change Condition=Minimum Below' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=2
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:113
@test '[AL-113]Change Condition=Minimum Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=3
   OPERATOR=3
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:114
@test '[AL-114]Change Condition=Atleast Above' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=0
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:115
@test '[AL-115]Change Condition=Atleast Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=1
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:116
@test '[AL-116]Change Condition=Atleast Below' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=2
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:117
@test '[AL-117]Change Condition=Atleast Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=4
   OPERATOR=3
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:118
@test '[AL-118]Change Condition=Every Above' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=0
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:119
@test '[AL-119]Change Condition=Every Above or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=1
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:120
@test '[AL-120]Change Condition=Every Below' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=2
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:121
@test '[AL-121]Change Condition=Every Below or Equal To' {
   set_json_path change sample1.json
   DATA_TYPE=5
   OPERATOR=3
	 CHANGE=1
   WINDOW_TYPE=1
   cat $PWD/change_condition/change_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
	 cat $JSON_FILE | sed "s/\$CHANGE/$CHANGE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/change_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/change_condition/$rule_{rule_id}.JSON
}


#=======================================================================================================================================================
#--------------------------------------Anomaly----------------------------------------------------------------------------------------------------------------

#bats test_tags=TC:122
@test '[AL-122]Anomaly Condition=Atleast Above' {
   set_json_path anomaly sample1.json
   DATA_TYPE=4
   OPERATOR=0
   WINDOW_TYPE=0
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:123
@test '[AL-123]Anomaly Condition=Atleast Below' {
   set_json_path anomaly sample1.json
   DATA_TYPE=4
   OPERATOR=2
   WINDOW_TYPE=0
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:124
@test '[AL-124]Anomaly Condition=Atleast Above or Below' {
   set_json_path anomaly sample1.json
   DATA_TYPE=4
   OPERATOR=4
   WINDOW_TYPE=0
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:125
@test '[AL-125]Anomaly Condition=Every Above' {
   set_json_path anomaly sample1.json
   DATA_TYPE=5
   OPERATOR=0
   WINDOW_TYPE=0
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:126
@test '[AL-126]Anomaly Condition=Every Below' {
   set_json_path anomaly sample1.json
   DATA_TYPE=5
   OPERATOR=2
   WINDOW_TYPE=0
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:127
@test '[AL-127]Anomaly Condition=Every Above or Below' {
   set_json_path anomaly sample1.json
   DATA_TYPE=5
   OPERATOR=4
   WINDOW_TYPE=0
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:128
@test '[AL-128]Anomaly Condition=Atleast Above' {
   set_json_path anomaly sample1.json
   DATA_TYPE=4
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:129
@test '[AL-129]Anomaly Condition=Atleast Below' {
   set_json_path anomaly sample1.json
   DATA_TYPE=4
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:130
@test '[AL-130]Anomaly Condition=Atleast Above or Below' {
   set_json_path anomaly sample1.json
   DATA_TYPE=4
   OPERATOR=4
   WINDOW_TYPE=1
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:131
@test '[AL-131]Anomaly Condition=Every Above' {
   set_json_path anomaly sample1.json
   DATA_TYPE=5
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:132
@test '[AL-132]Anomaly Condition=Every Below' {
   set_json_path anomaly sample1.json
   DATA_TYPE=5
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:133
@test '[AL-133]Anomaly Condition=Every Above or Below' {
   set_json_path anomaly sample1.json
   DATA_TYPE=5
   OPERATOR=4
   WINDOW_TYPE=1
   cat $PWD/anomaly_condition/anomaly_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/anomaly_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/anomaly_condition/$rule_{rule_id}.JSON
}

#=======================================================================================================================================================
#-----------------------------Outlier-------------------------------------------------------------------------------------------------------------------------

#bats test_tags=TC:134
@test '[AL-134]Outlier Condition=Atleast one' {
   set_json_path outlier sample1.json
   DATA_TYPE=4
   WINDOW_TYPE=0
   cat $PWD/outlier_condition/outlier_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/outlier_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/outlier_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:135
@test '[AL-135]Outlier Condition=Every' {
   set_json_path outlier sample1.json
   DATA_TYPE=5
   WINDOW_TYPE=0
   cat $PWD/outlier_condition/outlier_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/outlier_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/outlier_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:136
@test '[AL-136]Outlier Condition=Atleast one' {
   set_json_path outlier sample1.json
   DATA_TYPE=4
   WINDOW_TYPE=1
   cat $PWD/outlier_condition/outlier_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/outlier_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/outlier_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:137
@test '[AL-137]Outlier Condition=Every' {
   set_json_path outlier sample1.json
   DATA_TYPE=5
   WINDOW_TYPE=1
   cat $PWD/outlier_condition/outlier_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/outlier_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/outlier_condition/$rule_{rule_id}.JSON
}

#=======================================================================================================================================================
#-----------------------------forecast-------------------------------------------------------------------------------------------------------------------------

#bats test_tags=TC:138
 @test '[AL-138]Forecast Condition=Average Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=0
   OPERATOR=0
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:139
@test '[AL-139]Forecast Condition=Average Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=0
   OPERATOR=1
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:140
@test '[AL-140]Forecast Condition=Average Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=0
   OPERATOR=2
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:141
@test '[AL-141]Forecast Condition=Average Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=0
   OPERATOR=3
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:142
@test '[AL-142]Forecast Condition=Sum of Every Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=1
   OPERATOR=0
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:143
@test '[AL-143]Forecast Condition=Sum of Every Above or Equal To' {
   #set_json_path forecast sample1.json
   DATA_TYPE=1
   OPERATOR=1
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:144
@test '[AL-144]Forecast Condition=Sum of Every Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=1
   OPERATOR=2
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:145
@test '[AL-145]Forecast Condition=Sum of Every Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=1
   OPERATOR=3
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:146
@test '[AL-146]Forecast Condition=Maximum Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=2
   OPERATOR=0
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:147
@test '[AL-147]Forecast Condition=Maximum Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=2
   OPERATOR=1
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:148
@test '[AL-148]Forecast Condition=Maximum Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=2
   OPERATOR=2
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:149
@test '[AL-149]Forecast Condition=Maximum Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=2
   OPERATOR=3
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:150
@test '[AL-150]Forecast Condition=Minimum Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=3
   OPERATOR=0
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:151
@test '[AL-151]Forecast Condition=Minimum Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=3
   OPERATOR=1
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:152
@test '[AL-152]Forecast Condition=Minimum Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=3
   OPERATOR=2
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:153
@test '[AL-153]Forecast Condition=Minimum Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=3
   OPERATOR=3
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:154
@test '[AL-154]Forecast Condition=Atleast Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=4
   OPERATOR=0
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:155
@test '[AL-155]Forecast Condition=Atleast Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=4
   OPERATOR=1
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:156
@test '[AL-156]Forecast Condition=Atleast Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=4
   OPERATOR=2
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:157
@test '[AL-157]Forecast Condition=Atleast Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=4
   OPERATOR=3
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:158
@test '[AL-158]Forecast Condition=Every Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=5
   OPERATOR=0
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:159
@test '[AL-159]Forecast Condition=Every Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=5
   OPERATOR=1
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:160
@test '[AL-160]Forecast Condition=Every Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=5
   OPERATOR=2
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:161
@test '[AL-161]Forecast Condition=Every Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=5
   OPERATOR=3
   WINDOW_TYPE=0
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:162
 @test '[AL-162]Forecast Condition=Average Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=0
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:163
@test '[AL-163]Forecast Condition=Average Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=0
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:164
@test '[AL-164]Forecast Condition=Average Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=0
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:165
@test '[AL-165]Forecast Condition=Average Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=0
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:166
@test '[AL-166]Forecast Condition=Sum of Every Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=1
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:167
@test '[AL-167]Forecast Condition=Sum of Every Above or Equal To' {
   #set_json_path forecast sample1.json
   DATA_TYPE=1
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:168
@test '[AL-168]Forecast Condition=Sum of Every Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=1
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:169
@test '[AL-169]Forecast Condition=Sum of Every Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=1
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:170
@test '[AL-170]Forecast Condition=Maximum Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=2
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:171
@test '[AL-171]Forecast Condition=Maximum Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=2
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:172
@test '[AL-172]Forecast Condition=Maximum Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=2
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:173
@test '[AL-173]Forecast Condition=Maximum Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=2
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:174
@test '[AL-174]Forecast Condition=Minimum Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=3
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:175
@test '[AL-175]Forecast Condition=Minimum Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=3
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:176
@test '[AL-176]Forecast Condition=Minimum Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=3
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:177
@test '[AL-177]Forecast Condition=Minimum Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=3
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:178
@test '[AL-178]Forecast Condition=Atleast Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=4
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:179
@test '[AL-179]Forecast Condition=Atleast Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=4
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:180
@test '[AL-180]Forecast Condition=Atleast Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=4
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:181
@test '[AL-181]Forecast Condition=Atleast Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=4
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:182
@test '[AL-182]Forecast Condition=Every Above' {
   set_json_path forecast sample1.json
   DATA_TYPE=5
   OPERATOR=0
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:183
@test '[AL-183]Forecast Condition=Every Above or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=5
   OPERATOR=1
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:184
@test '[AL-184]Forecast Condition=Every Below' {
   set_json_path forecast sample1.json
   DATA_TYPE=5
   OPERATOR=2
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:185
@test '[AL-185]Forecast Condition=Every Below or Equal To' {
   set_json_path forecast sample1.json
   DATA_TYPE=5
   OPERATOR=3
   WINDOW_TYPE=1
   cat $PWD/forecast_condition/forecast_common.json | sed "s/\$DATA_TYPE/$DATA_TYPE/g" > $JSON_FILE
   cat $JSON_FILE | sed "s/\$OPERATOR/$OPERATOR/g" > $JSON_FILE;
   cat $JSON_FILE | sed "s/\$WINDOW_TYPE/$WINDOW_TYPE/g" > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/forecast_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/forecast_condition/$rule_{rule_id}.JSON
}


#bats test_tags=TC:186
@test '[AL-186] Simple subject with tier one sever all instance all' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/simple_t1.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:187
@test '[AL-187] Simple case with tier one sever one instance all' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/simple_t1_s1.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:188
@test '[AL-188] Simple case with tier one sever one instance one' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/simple_t1_s1_i1.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:189
@test '[AL-189] Simple subject with tier one instance one' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/simple_t1_i1.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:190
@test '[AL-190] Composite Critical compare c1 or c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_critical_c1_or_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:191
@test '[AL-191] Composite Critical compare c1 and c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_critical_c1_and_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:192
@test '[AL-192] Composite Major compare c1 and c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_major_c1_and_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:193
@test '[AL-193] Composite Major compare c1 or c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_major_c1_or_c2.json > $JSON_FILE 
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:194
@test '[AL-194] Composite Minor compare c1 and c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_minor_c1_and_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:195
@test '[AL-195] Composite Minor compare c1 or c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_minor_c1_or_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:196
@test '[AL-196] Composite Critical compare c1 and c2 with tier one' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_critical_c1_and_c2_t1.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:197
@test '[AL-197] Composite Critical compare c1 or c2 with tier one' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_critical_c1_or_c2_t1.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:198
@test '[AL-198] Composite Critical compare C1 && C2 || C3, Major: C1 || C2 ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_critical_c1_and_c2_or_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:199
@test '[AL-199] Composite Critical C1 && C2 || C3, Major: C1 || C2, Minor: C1 && C2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_cri_maj_min_c1_c2_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:200
@test '[AL-200] Composite case Major: C1 && C2, Minor: C1 || C2 ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_maj_min_c1_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:201
@test '[AL-201] Composite Critical: C1 || C2 || C4 with different subject ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_critical_c1_c2_c3_diff_sub.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:202
@test '[AL-202] Composite case Critical: C1 && C2 || C3, Major: C1 || C2 && C3, Minor: C1 && C2 || C3' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_crit_maj_min_c1_c2_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:203
@test '[AL-203] Composite case Major: C1 || C2 && C3, ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_major_c1_or_c2_and_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:204
@test '[AL-204] Composite case Minor: C1 || C2 && C3, ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/composite_minor_c1_or_c2_and_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:205
@test '[AL-205] Fix Composite Critical compare c1 or c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_critical_c1_or_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:206
@test '[AL-206] Fix Composite Critical compare c1 and c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_critical_c1_and_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:207
@test '[AL-207] Fix Composite Major compare c1 and c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_major_c1_and_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:208
@test '[AL-208] Fix Composite Major compare c1 or c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_major_c1_or_c2.json > $JSON_FILE 
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:209
@test '[AL-209] Fix Composite Minor compare c1 and c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_minor_c1_and_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}
#bats test_tags=TC:210
@test '[AL-210] Fix Composite Minor compare c1 or c2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_minor_c1_or_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:211
@test '[AL-211] Fix Composite Critical compare c1 and c2 with tier one' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_critical_c1_and_c2_t1.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:212
@test '[AL-212] Fix Composite Critical compare c1 or c2 with tier one' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_critical_c1_or_c2_t1.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:213
@test '[AL-213] Fix Composite Critical compare C1 && C2 || C3, Major: C1 || C2 ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_critical_c1_and_c2_or_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:214
@test '[AL-214] Fix Composite Critical C1 && C2 || C3, Major: C1 || C2, Minor: C1 && C2' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_cri_maj_min_c1_c2_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:215
@test '[AL-215] Fix Composite case Major: C1 && C2, Minor: C1 || C2 ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_maj_min_c1_c2.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:216
@test '[AL-216] Fix Composite Critical: C1 || C2 || C4 with different subject ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_critical_c1_c2_c3_diff_sub.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:217
@test '[AL-217] Fix Composite case Critical: C1 && C2 || C3, Major: C1 || C2 && C3, Minor: C1 && C2 || C3' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_crit_maj_min_c1_c2_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:218
@test '[AL-218] Fix Composite case Major: C1 || C2 && C3, ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_major_c1_or_c2_and_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}

#bats test_tags=TC:219
@test '[AL-219] Fix Composite case Minor: C1 || C2 && C3, ' {
   set_json_path subject sample1.json
   cat $PWD/subject_condition/fix_composite_minor_c1_or_c2_and_c3.json > $JSON_FILE
   curl -X POST http://127.0.0.1:$ALERT_MANAGER_PORT/alert/rule/add -H "Content-Type: application/json" -d @"${JSON_FILE}" > $OUT_FILE
   rep_status=$(jq '.status.msg' $OUT_FILE | cut -d'"' -f2)
   assert_equal "$rep_status" "OK"
   rule_id=`jq '.rules[0].id' $OUT_FILE`
   automation_log "rule_id=$rule_id"
   mv "$JSON_FILE" "$PWD/subject_condition/$rule_{rule_id}.JSON"
   JSON_FILE=$PWD/subject_condition/$rule_{rule_id}.JSON
}
