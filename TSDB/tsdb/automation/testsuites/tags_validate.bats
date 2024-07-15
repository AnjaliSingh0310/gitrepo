#!/home/cavisson/work/TSDB/tsdb/automation/thirdparty/bats-core/bin/bats

setup() {
  source ./testsuites/common
  source ./lib/tsdbRequests
  common_setup
  source $TAGS_LIB/tags_lib
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
}

get_detail() { 
  RESPONSE_FILE=$TAGS_REP/$BATS_TEST_NUMBER.output
}

get_all_tags() {
   source ./testsuites/common
   if [ "$1" = " " ]; then
     grep "tags" $METRIC_FILE | cut -d '"' -f2 | uniq | tr "," "\n" | sort | uniq > total_tag_list
   else
     grep "tags.*$1" $METRIC_FILE | cut -d '"' -f2 | uniq | tr "," "\n" | sort | uniq > total_tag_list
   fi
}


bats test_tags=id:1,type:tag_list
@test '[TAG-001] Tag list call ' {
   get_all_tags
   get_detail
   run_query OP=tag_list OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"   
}

#tag list call with specific mg id
@test '[TAG-002] Tag list call, Specified mg id' {
   get_all_tags "MPStat Linux"
   get_detail
   run_query OP=tag_list OUTFILE=$RESPONSE_FILE ID=10010
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion "cm_mpstat.gdf")
   assert_output "PASS"
}

bats test_tags=id:2,type:tag_value
@test '[TAG-003] Tag value call , TAGNAME=httpConnection' {
   get_detail
   get_all_tags
   TAGNAME=httpConnection
   run_query OP=tag_value TAGNAME=httpConnection OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion)
   assert_output "PASS"
   
}

#bats test_tags=id:3,type:tag_value
@test '[TAG-004] Tag value call , TAGNAME=httpHost' {
   get_detail
   get_all_tags
   TAGNAME=httpHost
   run_query OP=tag_value TAGNAME=httpHost OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion)
   assert_output "PASS"
}

#bats test_tags=id:4,type:tag_value
@test '[TAG-005] Tag value call , TAGNAME=OS' {
   get_detail
   get_all_tags
   TAGNAME=OS
   run_query OP=tag_value TAGNAME=OS OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion)
   assert_output "PASS"   
}

#bats test_tags=id:5,type:tag_value
@test '[TAG-006] Tag value call , TAGNAME=Location' {
   get_detail
   get_all_tags
   TAGNAME=Location
   run_query OP=tag_value TAGNAME=Location OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion)
   assert_output "PASS"
}

#bats test_tags=id:6,type:tag_value
@test '[TAG-007] Tag value call , TAGNAME=Environment' {
   get_detail
   get_all_tags
   TAGNAME=Environment
   run_query OP=tag_value TAGNAME=Environment OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS" 
   output=$(tag_validtaion)
   assert_output "PASS"  
}

#bats test_tags=id:7,type:tag_value
@test '[TAG-008] Tag value call , TAGNAME=Time Zone' {
   get_detail
   get_all_tags
   TAGNAME="Time Zone"
   run_query OP=tag_value TAGNAME=Time\ \Zone OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion)
   assert_output "PASS"
}

#bats test_tags=id:8,type:tag_value
@test '[TAG-009] Tag value call , TAGNAME=Environ' {
   get_detail
   get_all_tags
   TAGNAME=Environ
   run_query OP=tag_value TAGNAME=Environ OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion)
   assert_output "PASS"

}

#bats test_tags=id:9,type:tag_value
@test '[TAG-010] Tag value call , TAGNAME=Team' {
   get_detail
   get_all_tags
   TAGNAME=Team
   run_query OP=tag_value TAGNAME=Team OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion)
   assert_output "PASS"
}


#bats test_tags=id:10,type:tag_value
@test '[TAG-011] Tag value call , TAGNAME=Company' {
   get_detail
   get_all_tags
   TAGNAME=Company
   run_query OP=tag_value TAGNAME=Company OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion)
   assert_output "PASS"
}


#bats test_tags=id:11,type:tag_value
@test '[TAG-012] Tag value call , TAGNAME=Type' {
   get_detail
   get_all_tags
   TAGNAME=Type
   run_query OP=tag_value TAGNAME=Type OUTFILE=$RESPONSE_FILE
   output=$(check_number_tags)
   assert_output "PASS"
   output=$(tag_validtaion)
   assert_output "PASS"
}
