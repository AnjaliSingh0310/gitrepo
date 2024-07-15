#!/home/cavisson/work/TSDB/tsdb/automation/thirdparty/bats-core/bin/bats

setup() {
  source ./testsuites/common
  common_setup
  export RESPONSE_FILE="$REDO_REP/REDO_${BATS_TEST_NUMBER}".txt
  export INIT_TREE=${REDO_TEMP}/init_tree.json
  source $REDO_LIB/redo_lib
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
}

#-----------------------------tsdb rar execution test cases-------------------------

@test "[RAR001] Check if tsdb_rar is running" {
    check_rar_running
    output=$(validate_redo_response "${BATS_TEST_NUMBER}")
    assert_output "PASS"
}


@test "[RAR002] Check if tsdb_rar process invokes tsdb_ddsw process" {
    if check_rar_running; then
       check_ddsw_running
       output=$(validate_redo_response "${BATS_TEST_NUMBER}")
       assert_output "PASS"
    else
       skip "tsdb_rar is not running."
    fi
}


@test "[RAR003] Check if tsdb_ddsw process recovers if it goes down" {
    skip "RAR get killed on DDSW goes down"
    check_ddsw_recovered
    output=$(validate_redo_response "${BATS_TEST_NUMBER}")
    assert_output "PASS"
}


@test "[RAR004] If recovery from snapshot than rar and ddsw should not run" {
    recovery_by_snapshot_or_ddsw
    output=$(validate_redo_response "${BATS_TEST_NUMBER}")
    assert_output "PASS"
}

#--------------------------------ddsw testcases---------------------------------------

@test "[RAR005] Check if tsdb_heartbeat field is updating in .lav files" {
    local file="$LAV_PATH"  
    local field_index=3

    if [ -e "$file" ]; then
        # If the file exists, check if tsdb_heartbeat field is updating
        check_tsdb_heartbeat_update "$file" "$field_index"
        automation_log "tsdb_heartbeat field is updating in $file"
    else
        # If the file does not exist, skip the test
        automation_log "File $file does not exist"
    fi
    output=$(validate_redo_response "${BATS_TEST_NUMBER}")
    assert_output "PASS"
}

@test "[RAR006] Check .lrv file updating." {
    local file="$LAV_PATH/../.lrv"
    check_ddsw_running
    if [ -e "$file" ]; then
       ddsw_pid_in_file=$(cat "$file" | cut -d"|" -f 5)
       ddsw_pid=$(pgrep -f "tsdb_ddsw -t $TESTIDX")
       if [ "$ddsw_pid_in_file" -eq "$ddsw_pid" ]; then
          result=0
       else
          result=1
       fi
    else
        automation_log "File $file does not exist"
    fi
    output=$(validate_redo_response "${BATS_TEST_NUMBER}")
    assert_output "PASS"
}


#----------------------------------recovery test cases-------------------------------

@test "[RAR007] Check if recovery done or not" {
    search_in_file "TSDB_RECOVERY_SUMMARY: overall_time_taken =" "$TRACE_LOG_FILE"
    automation_log "tsdb_admin --port ${TSDB_PORT} --op tci "
    tsdb_admin --port ${TSDB_PORT} --op tci > ${RESPONSE_FILE} 2>/dev/null
    output=$(validate_redo_response "${BATS_TEST_NUMBER}")
    assert_output "PASS"
}

#-----------------------------incomplete transaction test cases----------------------

#Incomplete transaction should not stuck the process.
@test "[RAR008] Incomplete tranction" {
     local file="$TSDB_WDIR/redo/incomplete_logs"
     local file_1="$LAV_PATH"
     if [ -e "$file" ]; then
        #check process working smoothly or not.
        if [ -e "$file_1" ]; then
           check_tsdb_heartbeat_update "$file" "3"
           automation_log "tsdb_heartbeat field is updating in $file"
        else
           automation_log "File $file_1 does not exist"
        fi
     else
        automation_log "File $file does not exist, means no incomplete txn."
     fi
     output=$(validate_redo_response "${BATS_TEST_NUMBER}")
     assert_output "PASS"
}

