#!./bats/bin/bats

generate_token()
{
   python3 ${GENERIC_LIB}/generate_token.py
}

set_req_inputs()
{
   export IP_PORT=$(python3 $GENERIC_LIB/get_ip_port.py)
   if [ $BATS_TEST_NUMBER -eq 1 ];then
      generate_token
      grep "Tier:" ${METRIC_FILE} | cut -d',' -f3 | cut -d'>' -f3- | sort | uniq >${ALL_SUBJECT}
      grep "Tier:$TIER" ${METRIC_FILE} | cut -d',' -f3-6 | cut -d'>' -f3- | sort | uniq >${TREE_INFO_FILE}
       
   fi
   export TOKEN=$(cat .token)
   export STIME=$(($(cat $TR_PATH/tsdb/.tsdb_stime) * 1000))
   export ETIME=$(($(date +%s) * 1000))
   export PRESET="SPECIFIED_TIME_${STIME}_${ETIME}"
   export R_HEADER="Content-Type: application/json"
}

setup() {
   source ./testsuites/common
   common_setup
   export ALL_SUBJECT=${TREECALL_TEMP}/all_subjects.txt
   export INIT_TREE=${TREECALL_TEMP}/init_tree.json
   export TREE_INFO_FILE=${TREECALL_TEMP}/tree_info
   export TIER="metadata_tree-tier"
   set_req_inputs
   export RESPONSE_FILE=${TREE_REP}/tree_rep_${BATS_TEST_NUMBER}.json
   source ${TREECALL_LIB}/tree_validations
   automation_log "" 
   automation_log "${BATS_TEST_DESCRIPTION}"
}
#bats test_tags=hi:tier,tc:1,test:1
@test '[TC001]TestDesc=Validate treeCall initialization' {
   python3 $TREECALL_LIB/tree_init.py
   output=$(jq '.status.msg' ${INIT_TREE} | cut -d'"' -f2)
   assert_output "OK"
}
#bats test_tags=hi:tier,tc:1
@test '[TC002]TestDesc=Check all tiers present' {
   python3 $TREECALL_LIB/get_all_tiers.py
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   expected_tiers="$(grep "Tier:" ${METRIC_FILE} | cut -d',' -f3 | cut -d'>' -f3 | cut -d':' -f2 | sort | uniq | xargs)"
   actual_tiers="$(jq '.tree[0].children[].name' ${RESPONSE_FILE} | cut -d'"' -f2 | sort | xargs)"
   automation_log "EXP_TIERS=${expected_tiers[@]}"
   automation_log "ACT_TIERS=${actual_tiers[@]}"
   assert_equal "${expected_tiers[@]}" "${actual_tiers[@]}"
}
#bats test_tags=hi:tier,tc:1
@test '[TC003]CheckNode=Tier>MetricGroups, TestDesc=Check all metric groups of a tier present' {
   export HI_LEVEL=1
   python3 $TREECALL_LIB/expand_mgroup.py
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   get_exp_mgroups
   get_act_mgroups
   assert_equal "${EXP_MG_IDS[@]}" "${ACT_MG_IDS[@]}"
}
#bats test_tags=hi:tier,tc:1
@test '[TC004]CheckNode=Tier>MetrcGroup>Graphs, TestDesc=Check all graphs are present for each metric group of a tier' {
   export HI_LEVEL=1
   python3 $TREECALL_LIB/expand_mgroup.py
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   output=$(validate_graphs)
   assert_output "PASS"
}
#bats test_tags=hi:tier_server,tc:1
@test '[TC005]CheckNode=Tier>Server, TestDesc=Check all servers are coming for a tier' {
   export HI_LEVEL=1
   python3 $TREECALL_LIB/expand_subject.py
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   output=$(validate_servers)
   assert_output "PASS"
}
#bats test_tags=hi:tier_server
@test '[TC006]CheckNode=Tier>Server>MetricGroups, TestDesc=Check all metric groups of a server are coming' {
   export HI_LEVEL=2
   python3 $TREECALL_LIB/expand_mgroup.py 2>/dev/null
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   get_exp_mgroups
   get_act_mgroups
   assert_equal "${EXP_MG_IDS[@]}" "${ACT_MG_IDS[@]}" 
}
#bats test_tags=hi:tier_server
@test '[TC007]CheckNode=Tier>Server>Tags, TestDesc=Check all tags of a server are coming' {
   export HI_LEVEL=2
   python3 $TREECALL_LIB/expand_mgroup.py 2>/dev/null
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   output=$(tag_validation)
   assert_output "PASS"
}
@test '[TC008]CheckNode=Tier>Server>MetricGroup>Graphs, TestDesc=Check all graphs are present for each Metric Group of a server' {
   export HI_LEVEL=2
   python3 $TREECALL_LIB/expand_mgroup.py 2>/dev/null
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   output=$(validate_graphs)
   assert_output "PASS"
}
@test '[TC009]CheckNode=Tier>Server>Subjects, TestDesc=Check all subjects are coming for a server' {
   export HI_LEVEL=2
   python3 $TREECALL_LIB/expand_subject.py
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   output=$(validate_lvl3_subjects)
   assert_output "PASS"
} 
@test '[TC010]CheckNode=Tier>Server>Subject, TestDesc=Check all instances of a server subject are coming' {
   export HI_LEVEL=2
   python3 $TREECALL_LIB/expand_subject.py
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   output=$(validate_lvl3_instances)
   assert_output "PASS"
}
@test '[TC011]CheckNode=Tier>Server>Subject>MetricGroups, TestDesc=Check all metric groups of a server subject instance are coming' {
   export HI_LEVEL=3
   python3 $TREECALL_LIB/expand_mgroup.py
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   get_exp_mgroups
   get_act_mgroups
   assert_equal "${EXP_MG_IDS[@]}" "${ACT_MG_IDS[@]}"
}
@test '[TC012]CheckNode=Tier>Server>Subject>MetricGroup>Graphs, TestDesc=Check all graphs are present for each Metric Group' {
   export HI_LEVEL=3
   python3 $TREECALL_LIB/expand_mgroup.py
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   output=$(validate_graphs)
   assert_output "PASS"
}
#bats test_tags=hi:tier_server_instance
@test '[TC013]CheckNode=Tier>Server>instance>Tags, TestDesc=Check all tags at  instance level  are coming' {
   export HI_LEVEL=3
   python3 $TREECALL_LIB/expand_mgroup.py 2>/dev/null
   output=$(jq '.status.msg' ${RESPONSE_FILE} | cut -d'"' -f2)
   assert_output "OK"
   output=$(tag_validation)
   assert_output "PASS"
}

