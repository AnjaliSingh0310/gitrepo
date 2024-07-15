#!/home/cavisson/bin/bats

set_req_inputs()
{
   export IP_PORT=$(hostname -I | awk '{print $1}')
   export ALL_SUBJECT=${HIERARCHY_TEMP}/all_subjects.txt
   if [ ${BATS_TEST_NUMBER} -eq 1 ];then
	python3 ${GENERIC_LIB}/generate_token.py
	grep "Tier:" ${METRIC_FILE} | cut -d',' -f3 | cut -d'>' -f3- | sort | uniq >${ALL_SUBJECT}
   fi
   export TOKEN=$(cat .token)
   export STIME=$(($(cat ${TR_PATH}/tsdb/.tsdb_stime) * 1000))
   export ETIME=$(($(date +%s) * 1000))
   export PRESET="SPECIFIED_TIME_${STIME}_${ETIME}"
   export TIER="metadata_tree-tier"
   export SUB_LVL=0
   export SUB_MODE="0:0:0" 
}

setup() {
    source ./testsuites/common
    common_setup
    export RESPONSE_FILE=${HIERARCHY_REP}/hi_${BATS_TEST_NUMBER}.json
    set_req_inputs
    automation_log "${BATS_TEST_DESCRIPTION}\n"
}
#bats test_tags=tc:sublvl3
@test '[HI001]Test=Hierarchy call with level -1' {
    export HI_CALL_MODE=0
    export EXPAND_LEVEL="-1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:1
@test '[HI002]Test=Hierarchy call upto level1' {
    export HI_CALL_MODE=0
    export EXPAND_LEVEL=1
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}

#bats test_tags=tc:2
@test '[HI003]Test=Hierarchy call upto level2' {
    export HI_CALL_MODE=0
    export EXPAND_LEVEL=2
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:3
@test '[HI004]Test=Hierarchy call upto level3' {
    skip "Unsupported"
    export HI_CALL_MODE=0
    export EXPAND_LEVEL=3
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI005]Test=Hierarchy call for a specific tier upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=1
    export SUB_MODE="1:0:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI006]Test=Hierarchy call for all tiers upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=1
    export SUB_MODE="2:0:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI007]Test=Hierarchy call for tiers with given pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=1
    export SUB_MODE="4:0:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI008]Test=Hierarchy call for a specific tier upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=1
    export SUB_MODE="1:0:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI009]Test=Hierarchy call for all tiers upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=1
    export SUB_MODE="2:0:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI010]Test=Hierarchy call for tiers with given pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=1
    export SUB_MODE="4:0:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI011]Test=Hierarchy call for a specific tier upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=1
    export SUB_MODE="1:0:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI012]Test=Hierarchy call for all tiers upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=1
    export SUB_MODE="2:0:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI013]Test=Hierarchy call for tiers with given pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=1
    export SUB_MODE="4:0:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI014]Test=Hierarchy call for a specific tier and server upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=2
    export SUB_MODE="1:1:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI015]Test=Hierarchy call for specific server from all tiers upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=2
    export SUB_MODE="2:1:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI016]Test=Hierarchy call for specific server from tiers with given pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=2
    export SUB_MODE="4:1:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI017]Test=Hierarchy call for a specific tier and server upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=2
    export SUB_MODE="1:1:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI018]Test=Hierarchy call for specific server from all tiers upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=2
    export SUB_MODE="2:1:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI019]Test=Hierarchy call for specific server from tiers with given pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=2
    export SUB_MODE="4:1:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI020]Test=Hierarchy call for a specific tier and server upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=2
    export SUB_MODE="1:1:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI021]Test=Hierarchy call for specific server from all tiers upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=2
    export SUB_MODE="2:1:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI022]Test=Hierarchy call for specific server from tiers with given pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=2
    export SUB_MODE="4:1:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI023]Test=Hierarchy call for all servers of a specific tier upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=2
    export SUB_MODE="1:2:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI024]Test=Hierarchy call for all servers from all tiers upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=2
    export SUB_MODE="2:2:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI025]Test=Hierarchy call for all servers from tiers with given pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=2
    export SUB_MODE="4:2:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI026]Test=Hierarchy call for all servers of a specific tier upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=2
    export SUB_MODE="1:2:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject,tc:24
@test '[HI027]Test=Hierarchy call for all servers from all tiers upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=2
    export SUB_MODE="2:2:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI028]Test=Hierarchy call for all servers from tiers with given pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=2
    export SUB_MODE="4:2:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI029]Test=Hierarchy call for all servers of a specific tier upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=2
    export SUB_MODE="1:2:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject,tc:24
@test '[HI030]Test=Hierarchy call for all servers from all tiers upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=2
    export SUB_MODE="2:2:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI031]Test=Hierarchy call for all servers from tiers with given pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=2
    export SUB_MODE="4:2:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI032]Test=Hierarchy call for a specific tier and server with pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=2
    export SUB_MODE="1:4:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI033]Test=Hierarchy call for server with pattern from all tiers upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=2
    export SUB_MODE="2:4:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI034]Test=Hierarchy call for server with pattern from tiers with given pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=2
    export SUB_MODE="4:4:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI035]Test=Hierarchy call for a specific tier and server with pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=2
    export SUB_MODE="1:4:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI036]Test=Hierarchy call for server with pattern from all tiers upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=2
    export SUB_MODE="2:4:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI037]Test=Hierarchy call for server with pattern from tiers with given pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=2
    export SUB_MODE="4:4:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI038]Test=Hierarchy call for a specific tier and server with pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=2
    export SUB_MODE="1:4:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI039]Test=Hierarchy call for server with pattern from all tiers upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=2  
    export SUB_MODE="2:4:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:hi_subject
@test '[HI040]Test=Hierarchy call for server with pattern from tiers with given pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=2
    export SUB_MODE="4:4:0"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI041]Test=Hierarchy call for subject tier:specific>server:specific>lvl3_subject:specific upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="1:1:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI042]Test=Hierarchy call for subject tier:specific>server:specific>lvl3_subject:all upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="1:1:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI043]Test=Hierarchy call for subject tier:specific>server:specific>lvl3_subject:pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="1:1:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI044]Test=Hierarchy call for subject tier:all>server:specific>lvl3_subject:specific upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="2:1:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI045]Test=Hierarchy call for subject tier:all>server:specific>lvl3_subject:all upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="2:1:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI046]Test=Hierarchy call for subject tier:all>server:specific>lvl3_subject:pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="2:1:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI047]Test=Hierarchy call for subject tier:pattern>server:specific>lvl3_subject:specific upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="4:1:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI048]Test=Hierarchy call for subject tier:pattern>server:specific>lvl3_subject:all upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="4:1:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI049]Test=Hierarchy call for subject tier:pattern>server:specific>lvl3_subject:pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="4:1:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI050]Test=Hierarchy call for subject tier:specific>server:all>lvl3_subject:specific upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="1:2:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI051]Test=Hierarchy call for subject tier:specific>server:all>lvl3_subject:all upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="1:2:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI052]Test=Hierarchy call for subject tier:specific>server:all>lvl3_subject:pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="1:2:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI053]Test=Hierarchy call for subject tier:all>server:all>lvl3_subject:specific upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="2:2:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI054]Test=Hierarchy call for subject tier:all>server:all>lvl3_subject:all upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="2:2:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI055]Test=Hierarchy call for subject tier:all>server:all>lvl3_subject:pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="2:2:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI056]Test=Hierarchy call for subject tier:pattern>server:all>lvl3_subject:specific upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="4:2:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI057]Test=Hierarchy call for subject tier:pattern>server:all>lvl3_subject:all upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="4:2:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI058]Test=Hierarchy call for subject tier:pattern>server:all>lvl3_subject:pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="4:2:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI059]Test=Hierarchy call for subject tier:specific>server:pattern>lvl3_subject:specific upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="1:4:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI060]Test=Hierarchy call for subject tier:specific>server:pattern>lvl3_subject:all upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="1:4:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI061]Test=Hierarchy call for subject tier:specific>server:pattern>lvl3_subject:pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="1:4:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI062]Test=Hierarchy call for subject tier:all>server:pattern>lvl3_subject:specific upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="2:4:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI063]Test=Hierarchy call for subject tier:all>server:pattern>lvl3_subject:all upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="2:4:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI064]Test=Hierarchy call for subject tier:all>server:pattern>lvl3_subject:pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="2:4:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI065]Test=Hierarchy call for subject tier:pattern>server:pattern>lvl3_subject:specific upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="4:4:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI066]Test=Hierarchy call for subject tier:pattern>server:pattern>lvl3_subject:all upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="4:4:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI067]Test=Hierarchy call for subject tier:pattern>server:pattern>lvl3_subject:pattern upto level1' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=1
    export SUB_LVL=3
    export SUB_MODE="4:4:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI068]Test=Hierarchy call for subject tier:specific>server:specific>lvl3_subject:specific upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="1:1:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI069]Test=Hierarchy call for subject tier:specific>server:specific>lvl3_subject:all upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="1:1:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI070]Test=Hierarchy call for subject tier:specific>server:specific>lvl3_subject:pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="1:1:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI071]Test=Hierarchy call for subject tier:all>server:specific>lvl3_subject:specific upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="2:1:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI072]Test=Hierarchy call for subject tier:all>server:specific>lvl3_subject:all upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="2:1:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI073]Test=Hierarchy call for subject tier:all>server:specific>lvl3_subject:pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="2:1:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI074]Test=Hierarchy call for subject tier:pattern>server:specific>lvl3_subject:specific upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="4:1:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI075]Test=Hierarchy call for subject tier:pattern>server:specific>lvl3_subject:all upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="4:1:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI076]Test=Hierarchy call for subject tier:pattern>server:specific>lvl3_subject:pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="4:1:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI077]Test=Hierarchy call for subject tier:specific>server:all>lvl3_subject:specific upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="1:2:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI078]Test=Hierarchy call for subject tier:specific>server:all>lvl3_subject:all upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="1:2:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI079]Test=Hierarchy call for subject tier:specific>server:all>lvl3_subject:pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="1:2:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI080]Test=Hierarchy call for subject tier:all>server:all>lvl3_subject:specific upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="2:2:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI081]Test=Hierarchy call for subject tier:all>server:all>lvl3_subject:all upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="2:2:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI082]Test=Hierarchy call for subject tier:all>server:all>lvl3_subject:pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="2:2:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI083]Test=Hierarchy call for subject tier:pattern>server:all>lvl3_subject:specific upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="4:2:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI084]Test=Hierarchy call for subject tier:pattern>server:all>lvl3_subject:all upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="4:2:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI085]Test=Hierarchy call for subject tier:pattern>server:all>lvl3_subject:pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="4:2:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI086]Test=Hierarchy call for subject tier:specific>server:pattern>lvl3_subject:specific upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="1:4:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI087]Test=Hierarchy call for subject tier:specific>server:pattern>lvl3_subject:all upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="1:4:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI088]Test=Hierarchy call for subject tier:specific>server:pattern>lvl3_subject:pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="1:4:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI089]Test=Hierarchy call for subject tier:all>server:pattern>lvl3_subject:specific upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="2:4:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI090]Test=Hierarchy call for subject tier:all>server:pattern>lvl3_subject:all upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="2:4:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI091]Test=Hierarchy call for subject tier:all>server:pattern>lvl3_subject:pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="2:4:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI092]Test=Hierarchy call for subject tier:pattern>server:pattern>lvl3_subject:specific upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="4:4:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI093]Test=Hierarchy call for subject tier:pattern>server:pattern>lvl3_subject:all upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="4:4:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI094]Test=Hierarchy call for subject tier:pattern>server:pattern>lvl3_subject:pattern upto level2' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=2
    export SUB_LVL=3
    export SUB_MODE="4:4:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI095]Test=Hierarchy call for subject tier:specific>server:specific>lvl3_subject:specific upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="1:1:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI096]Test=Hierarchy call for subject tier:specific>server:specific>lvl3_subject:all upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="1:1:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI097]Test=Hierarchy call for subject tier:specific>server:specific>lvl3_subject:pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="1:1:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI098]Test=Hierarchy call for subject tier:all>server:specific>lvl3_subject:specific upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="2:1:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI099]Test=Hierarchy call for subject tier:all>server:specific>lvl3_subject:all upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="2:1:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI100]Test=Hierarchy call for subject tier:all>server:specific>lvl3_subject:pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="2:1:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI101]Test=Hierarchy call for subject tier:pattern>server:specific>lvl3_subject:specific upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="4:1:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI102]Test=Hierarchy call for subject tier:pattern>server:specific>lvl3_subject:all upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="4:1:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI103]Test=Hierarchy call for subject tier:pattern>server:specific>lvl3_subject:pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="4:1:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI104]Test=Hierarchy call for subject tier:specific>server:all>lvl3_subject:specific upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="1:2:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI105]Test=Hierarchy call for subject tier:specific>server:all>lvl3_subject:all upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="1:2:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI106]Test=Hierarchy call for subject tier:specific>server:all>lvl3_subject:pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="1:2:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI107]Test=Hierarchy call for subject tier:all>server:all>lvl3_subject:specific upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="2:2:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI108]Test=Hierarchy call for subject tier:all>server:all>lvl3_subject:all upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="2:2:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI109]Test=Hierarchy call for subject tier:all>server:all>lvl3_subject:pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="2:2:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI110]Test=Hierarchy call for subject tier:pattern>server:all>lvl3_subject:specific upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="4:2:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI111]Test=Hierarchy call for subject tier:pattern>server:all>lvl3_subject:all upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="4:2:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI112]Test=Hierarchy call for subject tier:pattern>server:all>lvl3_subject:pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="4:2:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI113]Test=Hierarchy call for subject tier:specific>server:pattern>lvl3_subject:specific upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="1:4:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI114]Test=Hierarchy call for subject tier:specific>server:pattern>lvl3_subject:all upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="1:4:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI115]Test=Hierarchy call for subject tier:specific>server:pattern>lvl3_subject:pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="1:4:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI116]Test=Hierarchy call for subject tier:all>server:pattern>lvl3_subject:specific upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="2:4:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI117]Test=Hierarchy call for subject tier:all>server:pattern>lvl3_subject:all upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="2:4:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI118]Test=Hierarchy call for subject tier:all>server:pattern>lvl3_subject:pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="2:4:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI119]Test=Hierarchy call for subject tier:pattern>server:pattern>lvl3_subject:specific upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="4:4:1"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI120]Test=Hierarchy call for subject tier:pattern>server:pattern>lvl3_subject:all upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="4:4:2"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
#bats test_tags=tc:sublvl3
@test '[HI121]Test=Hierarchy call for subject tier:pattern>server:pattern>lvl3_subject:pattern upto level3' {
    export HI_CALL_MODE=1
    export EXPAND_LEVEL=3
    export SUB_LVL=3
    export SUB_MODE="4:4:4"
    python3 ${HIERARCHY_LIB}/get_hierarchy.py
    output=$(python3 ${HIERARCHY_LIB}/validate_hierarchy.py)
    assert_output "PASS"
}
