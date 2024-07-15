#!/home/cavisson/work/TSDB/tsdb/automation/thirdparty/bats-core/bin/bats

setup() {
  source ./testsuites/common
  common_setup
  source ./lib/tsdbRequests
  source $NONBUSINESS_LIB/non_business_lib
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
  export RESPONSE_FILE=$NONBUSINESS_REP/NBH_$BATS_TEST_NUMBER.txt
}

get_detail(){
  st=1701168680
  SUBJECT="customer:Default>application:Default>Tier:cav-tier>Server:host-1>Processor:processor-1"
  SUBJECT_ALL="customer:Default>application:Default>Tier:all>Server:all>Processor:all"
  MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:IRQ CPU (%),10010,5"
}

#$1=NBH start time-Time at which we start nbh to be applied
#$2=partition count, for how many time nbh should be applied
#$3=valid sample, time upto which valid sample is present
#$4=nan sample, time upto which nan sample is present

create_nbh_filter(){
  nbh_et=$(($1 + ($3 + $4) * $2))    #nbh_st + (valid + nan_sample) * reps
  nbh_filter=""
  nbh_cur_time=$1
  while [ $nbh_cur_time -lt $nbh_et ];    #nbh_st < total_nbh_time
  do
     data_nan_st=$(($nbh_cur_time + $3))
     data_nan_et=$(($data_nan_st + $4))
     nbh_cur_time=$data_nan_et
     nbh_filter=nbh_filter+"$data_nan_st,"
     nbh_filter=nbh_filter+"$data_nan_et;"
  done
}


#---------------------- Non Business hour test cases for duration 1hr  ------------------------------------
#bats test_tags=op:dcn,level:1,filter:exact,id:1,test:1
@test '[NBH001]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   FREQ=10
   nbh_filter="1701169280,1701169880"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH002]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   FREQ=10
   nbh_filter="1701168690,1701169280"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH003]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from end time' {
   get_detail
   et=$(($st + 3000))
   time1=$(($et - 600))
   time2=$et
   FREQ=10
   nbh_filter="1701171090,1701171680"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact,id:7
@test '[NBH004]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 2 intervel time ' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   time3=$(($time2 + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701169290,1701169880;1701170490,1701171080"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH005]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   time3=$(($time2 + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701168690,1701169280;1701169890,1701170480"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH006]Tier:EXACT, OP=Data Query, Duration=1 hour, NBH time=10 min,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 3000))
   time1=$(($et - 600))
   time2=$et
   time3=$(($st + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701169290,1701169880;1701171090,1701171600"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH007]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   time3=$(($et - 600))
   time4=$et
   time5=$(($time2 + 300))
   time6=$(($time5 + 300))
   FREQ=10
   nbh_filter="1701168690,1701169280;1701169960,1701170830;1701171090,1701171680"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#---------------------- Non Business hour test cases for duration 4hr  ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact,id:2,test:1
@test '[NBH008]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour' {
   get_detail
   et=$(($st + 14000))
   time1=$(($st + 3600))
   time2=$(($time1 + 3600))
   FREQ=60
   nbh_filter="1701172320,1701175860"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH009]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour, NBH from start time' {
   get_detail
   et=$(($st + 14000))
   time1=$st
   time2=$(($time1 + 3600))
   FREQ=60
   nbh_filter="1701168720,1701172260"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0010]Tier:EXACT, OP=Data Query, Duration=4 hour, NBH time=1 hour,NBH from end time' {
   get_detail
   et=$(($st + 14000))
   time1=$(($et - 3600))
   time2=$et
   FREQ=60
   nbh_filter="1701179100,1701182340"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0011]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH use in 2 intervel time ' {
   get_detail
   et=$(($st + 14000))
   time1=$(($st + 3600))
   time2=$(($time1 + 3600))
   time3=$(($time2 + 1800))
   time4=$(($time3 + 3600))
   FREQ=60
   nbh_filter="1701172320,1701175860;1701177720,1701181260"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0012]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 14000))
   time1=$st
   time2=$(($time1 + 3600))
   time3=$(($time2 + 1800))
   time4=$(($time3 + 3600))
   FREQ=60
   nbh_filter="1701168720,1701172260;1701174120,1701177660"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0013]Tier:EXACT, OP=Data Query, Duration=4 hour, NBH time=1 hour,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 14000))
   time1=$(($et - 3600))
   time2=$et
   time3=$(($st + 600))
   time4=$(($time3 + 3600))
   FREQ=60
   nbh_filter="1701169320,1701172860;1701179100,1701182400"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0014]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 14000))
   time1=$st
   time2=$(($time1 + 3600))
   time3=$(($et - 3600))
   time4=$et
   time5=$(($time2 + 1800))
   time6=$(($time5 + 1800))
   FREQ=60
   nbh_filter="1701168720,1701171300;1701172380,1701174840;1701179700,1701182640"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#---------------------- Non Business hour test cases for duration 1 day  ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH0015]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour' {
   get_detail
   et=$(($st + 86400))
   time1=$(($st + 14400))
   time2=$(($time1 + 14400))
   FREQ=600
   nbh_filter="1701183600,1701197400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0016]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour, NBH from start time' {
   get_detail
   et=$(($st + 86400))
   time1=$st
   time2=$(($time1 + 14400))
   FREQ=600
   nbh_filter="1701169200,1701183000"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
} 

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0017]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH from end time' {
   get_detail
   et=$(($st + 86400))
   time1=$(($et - 14400))
   time2=$et
   FREQ=600
   nbh_filter="1701241200,1701255000"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0018]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH use in 2 intervel time ' {
   get_detail
   et=$(($st + 86400))
   time1=$(($st + 14400))
   time2=$(($time1 + 14400))
   time3=$(($time2 + 7200))
   time4=$(($time3 + 7200))
   FREQ=600
   nbh_filter="1701183600,1701197400;1701205200,1701211800"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:4
@test '[NBH0019]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 86400))
   time1=$st
   time2=$(($time1 + 14400))
   time3=$(($et - 28800))
   time4=$(($time3 + 14400))
   FREQ=600
   nbh_filter="1701169200,1701183000;1701226800,1701240600"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0020]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 86400))
   time1=$(($et -14400))
   time2=$et
   time3=$(($st + 14400))
   time4=$(($time3 + 14400))
   FREQ=600
   nbh_filter="1701183600,1701197400;1701241200,1701255000"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0021]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 86400))
   time1=$st
   time2=$(($time1 + 14400))
   time3=$(($et - 14400))
   time4=$et
   time5=$(($time2 + 14400))
   time6=$(($time5 + 14400))
   FREQ=600
   nbh_filter="1701169200,1701183000;1701207000,1701217800;1701241200,1701255000"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#---------------------- Non Business hour test cases for duration 7 day  ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH0022]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day' {
   get_detail
   et=$(($st + 604800))
   time1=$(($st + 86400))
   time2=$(($time1 + 86400))
   FREQ=3600
   nbh_filter="1701255600,1701338400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0023]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day, NBH from start time' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701252000"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0024]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from end time' {
   get_detail
   et=$(($st + 604800))
   time1=$(($et - 86400))
   time2=$et
   FREQ=3600
   nbh_filter="1701219600,1701252000"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0025]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH use in 2 intervel time ' {
   get_detail
   et=$(($st + 604800))
   time1=$(($st + 86400))
   time2=$(($time1 + 86400))
   time3=$(($et - 172800))
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701255600,1701338400;1701349200,1701428400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:4
@test '[NBH0026]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   time3=$(($et - 172800))
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701252000;1701349200,1701428400"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0027]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 604800))
   time1=$(($et - 86400))
   time2=$et
   time3=$st 
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701252000;1701651600,1701770400"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0028]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   time3=$(($et - 86400))
   time4=$et
   time5=$(($time2 + 28800))
   time6=$(($time5 + 28800))
   FREQ=3600
   nbh_filter="1701169200,1701252000;1701439200,1701532800;1701651600,1701770400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#---------------------- Non Business hour test cases for duration 30 day  ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0029]Tier:EXACT, OP=Data Query, Duration=30 day, NBH time=2 day ,NBH use in 4 interval time' {
   skip "Need long duration TR"
   get_detail
   et=$(($st + 2592000 ))
   time1=$(($st + 432000 ))
   time2=$(($time1 + 86400))
   time3=$(($time2 + 432000))
   time4=$(($time3 + 86400))
   time5=$(($time4 + 432000))
   time6=$(($time5 + 86400))
   time7=$(($time6 + 432000))
   time8=$(($time7 + 86400))
   FREQ=14400
   nbh_filter=";$time3,$time4;time5,time6;time7,time8"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#-------------------Non Business hour test cases for DT Filter ---------------------------

#bats test_tags=op:dcn,level:1,filter:exact,dt:1
@test '[NBH0030]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min, DT=min,max' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   FREQ=10
   nbh_filter="1701169630,1701170310"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT="avg max"  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,dt:1
@test '[NBH0031]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time,DT=avg,count' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   FREQ=10
   nbh_filter="1701168690,1701169280"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="avg count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0032]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from end time,DT=avg,min' {
   get_detail
   et=$(($st + 3000))
   time1=$(($et - 600))
   time2=$et
   FREQ=10
   nbh_filter="1701168690,1701168750"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="avg min" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact,id:33
@test '[NBH0033]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 2 intervel time,DT=max,count ' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   time3=$(($time2 + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701168690,1701168750;1701169290,1701169880"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT="max count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0034]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time, NBH use in 2 intervel time, DT=min,count ' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   time3=$(($time2 + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701168690,1701169280;1701169890,1701170480"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0035]Tier:EXACT, OP=Data Query, Duration=1 hour, NBH time=10 min,NBH from end time, NBH use in 2 intervel time, DT=min,avg' {
   get_detail
   et=$(($st + 3000))
   time1=$(($et - 600))
   time2=$et
   time3=$(($st + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701168690,1701168750;1701169290,1701169880"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0036]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 3 intervel time, DT=min,avg' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   time3=$(($et - 600))
   time4=$et
   time5=$(($time2 + 300))
   time6=$(($time5 + 300))
   FREQ=10
   nbh_filter="1701168690,1701169280;1701171090,1701171680;1701170160,1701170500"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT="min avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:2
@test '[NBH0037]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour, DT=max,avg' {
   get_detail
   et=$(($st + 14000))
   time1=$(($st + 3600))
   time2=$(($time1 + 3600))
   FREQ=60
   nbh_filter="1701172320,1701175860"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT="max avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0038]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour, NBH from start time, DT=min,avg' {
   get_detail
   et=$(($st + 14000))
   time1=$st
   time2=$(($time1 + 3600))
   FREQ=60
   nbh_filter="1701168720,1701172260"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0039]Tier:EXACT, OP=Data Query, Duration=4 hour, NBH time=1 hour,NBH from end time, DT=avg, count' {
   get_detail
   et=$(($st + 14000))
   time1=$(($et - 3600))
   time2=$et
   FREQ=60
   nbh_filter="1701179100,1701182640"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="count avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0040]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH use in 3 intervel time, DT=avg,max' {
   get_detail
   et=$(($st + 86400))
   time1=$st
   time2=$(($time1 + 14400))
   time3=$(($et - 14400))
   time4=$et
   time5=$(($time2 + 14400))
   time6=$(($time5 + 14400))
   FREQ=600
   nbh_filter="1701169200,1701183000;1701241200,1701255000;1701189000,1701199800"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT="avg max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH0041]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day, DT=count,max' {
   get_detail
   et=$(($st + 604800))
   time1=$(($st + 86400))
   time2=$(($time1 + 86400))
   FREQ=3600
   nbh_filter="1701255600,1701428400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT="count max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0042]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day, NBH from start time, DT=min,max' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701428400"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0043]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from end time, DT=avg,count' {
   get_detail
   et=$(($st + 604800))
   time1=$(($et - 86400))
   time2=$et
   FREQ=3600
   nbh_filter="1701648000,1701770400"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="avg count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0044]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH use in 2 intervel time, DT=min,max,count ' {
   get_detail
   et=$(($st + 604800))
   time1=$(($st + 86400))
   time2=$(($time1 + 86400))
   time3=$(($et - 172800))
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701255600,1701428400;1701601200,1701770400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  DT="min max count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:4
@test '[NBH0045]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from start time, NBH use in 2 intervel time, DT=min,avg,max' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   time3=$(($et - 172800))
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701266400;1701597600,1701759600"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min avg max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0046]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from end time, NBH use in 2 intervel time, DT=count,max,min' {
   get_detail
   et=$(($st + 604800))
   time1=$(($et - 86400))
   time2=$et
   time3=$st
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701259200;1701651600,1701770400"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et  DT="count max min" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0047]Tier:EXACT, OP=Data Query, Duration=7 day, NBH time=1 day,NBH use in 3 intervel time, DT=avg,min,max' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   time3=$(($et - 86400))
   time4=$et
   time5=$(($time2 + 28800))
   time6=$(($time5 + 28800))
   FREQ=3600
   nbh_filter="1701169200,1701248400;1701327600,1701439200;1701648000,1701770400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT="avg min max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0048]Tier:EXACT, OP=Data Query, Duration=30 day, NBH time=2 day ,NBH use in 4 interval time, DT=min,max,count' {
   skip "Need long duration test"
   get_detail
   et=$(($st + 2592000 ))
   time1=$(($st + 432000 ))
   time2=$(($time1 + 86400))
   time3=$(($time2 + 432000))
   time4=$(($time3 + 86400))
   time5=$(($time4 + 432000))
   time6=$(($time5 + 86400))
   time7=$(($time6 + 432000))
   time8=$(($time7 + 86400))
   nbh_filter="$time1,$time2;$time3,$time4;time5,time6;time7,time8"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  DT="min,max,count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#---------------------- Non Business hour test cases for percentile   ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact,id:1
@test '[NBH0049]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min, DT=percentile' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   FREQ=10
   nbh_filter="$st,$et"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT=percentile NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact,id:2,test:1
@test '[NBH0050]Tier:EXACT, OP=Data Query, Duration=4 Hour , DT=percentile' {
   get_detail
   et=$(($st + 14000))
   FREQ=60
   nbh_filter="$st,$et"
   FREQ=60
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT=percentile NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH0051]Tier:EXACT, OP=Data Query, Duration=1 day ,DT=percentile' {
   get_detail
   et=$(($st + 86400))
   FREQ=600
   nbh_filter="$st,$et"
   FREQ=3600
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et  DT=percentile NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH0052]Tier:EXACT, OP=Data Query, Duration=7 day, DT=percentile' {
   get_detail
   et=$(($st + 604800))
   FREQ=3600
   nbh_filter="$st,$et"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et DT=percentile NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#---------------------- Non Business hour test cases for duration 1hr  ------------------------------------
#bats test_tags=op:dcn,level:1,filter:exact,id:1,test:1
@test '[NBH0053]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   FREQ=10
   nbh_filter="1701169280,1701169880"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0054]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   FREQ=10
   nbh_filter="1701168690,1701169280"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0055]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from end time' {
   get_detail
   et=$(($st + 3000))
   time1=$(($et - 600))
   time2=$et
   FREQ=10
   nbh_filter="1701171090,1701171680"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0056]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 2 intervel time ' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   time3=$(($time2 + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701169290,1701169880;1701170490,1701171080"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0057]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   time3=$(($time2 + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701168690,1701169280;1701169890,1701170480"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0058]Tier:ALL, OP=Data Query, Duration=1 hour, NBH time=10 min,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 3000))
   time1=$(($et - 600))
   time2=$et
   time3=$(($st + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701169290,1701169880;1701171090,1701171600"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH059]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   time3=$(($et - 600))
   time4=$et
   time5=$(($time2 + 300))
   time6=$(($time5 + 300))
   FREQ=10
   nbh_filter="1701168690,1701169280;1701169960,1701170830;1701171090,1701171680"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#---------------------- Non Business hour test cases for duration 4hr  ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact,id:2,test:1
@test '[NBH060]Tier:ALL, OP=Data Query, Duration=4 Hour, NBH time=1 hour' {
   get_detail
   et=$(($st + 14000))
   time1=$(($st + 3600))
   time2=$(($time1 + 3600))
   FREQ=60
   nbh_filter="1701172320,1701175860"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0061]Tier:ALL, OP=Data Query, Duration=4 Hour, NBH time=1 hour, NBH from start time' {
   get_detail
   et=$(($st + 14000))
   time1=$st
   time2=$(($time1 + 3600))
   FREQ=60
   nbh_filter="1701168720,1701172260"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0062]Tier:ALL, OP=Data Query, Duration=4 hour, NBH time=1 hour,NBH from end time' {
   get_detail
   et=$(($st + 14000))
   time1=$(($et - 3600))
   time2=$et
   FREQ=60
   nbh_filter="1701179100,1701182340"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0063]Tier:ALL, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH use in 2 intervel time ' {
   get_detail
   et=$(($st + 14000))
   time1=$(($st + 3600))
   time2=$(($time1 + 3600))
   time3=$(($time2 + 1800))
   time4=$(($time3 + 3600))
   FREQ=60
   nbh_filter="1701172320,1701175860;1701177720,1701181260"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0064]Tier:ALL, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 14000))
   time1=$st
   time2=$(($time1 + 3600))
   time3=$(($time2 + 1800))
   time4=$(($time3 + 3600))
   FREQ=60
   nbh_filter="1701168720,1701172260;1701174120,1701177660"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0065]Tier:ALL, OP=Data Query, Duration=4 hour, NBH time=1 hour,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 14000))
   time1=$(($et - 3600))
   time2=$et
   time3=$(($st + 600))
   time4=$(($time3 + 3600))
   FREQ=60
   nbh_filter="1701169320,1701172860;1701179100,1701182400"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0066]Tier:ALL, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 14000))
   time1=$st
   time2=$(($time1 + 3600))
   time3=$(($et - 3600))
   time4=$et
   time5=$(($time2 + 1800))
   time6=$(($time5 + 1800))
   FREQ=60
   nbh_filter="1701168720,1701172260;1701179100,1701182640"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#---------------------- Non Business hour test cases for duration 1 day  ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH0067]Tier:ALL, OP=Data Query, Duration=1 day, NBH time=4 hour' {
   get_detail
   et=$(($st + 86400))
   time1=$(($st + 14400))
   time2=$(($time1 + 14400))
   FREQ=600
   nbh_filter="1701183600,1701197400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0068]Tier:ALL, OP=Data Query, Duration=1 day, NBH time=4 hour, NBH from start time' {
   get_detail
   et=$(($st + 86400))
   time1=$st
   time2=$(($time1 + 14400))
   FREQ=600
   nbh_filter="1701169200,1701183000"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
} 

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0069]Tier:ALL, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH from end time' {
   get_detail
   et=$(($st + 86400))
   time1=$(($et - 14400))
   time2=$et
   FREQ=600
   nbh_filter="1701241200,1701255000"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0070]Tier:ALL, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH use in 2 intervel time ' {
   get_detail
   et=$(($st + 86400))
   time1=$(($st + 14400))
   time2=$(($time1 + 14400))
   time3=$(($time2 + 7200))
   time4=$(($time3 + 7200))
   FREQ=600
   nbh_filter="1701183600,1701197400;1701205200,1701211800"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:4
@test '[NBH0071]Tier:ALL, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 86400))
   time1=$st
   time2=$(($time1 + 14400))
   time3=$(($et - 28800))
   time4=$(($time3 + 14400))
   FREQ=600
   nbh_filter="1701169200,1701183000;1701226800,1701240600"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0072]Tier:ALL, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 86400))
   time1=$(($et -14400))
   time2=$et
   time3=$(($st + 14400))
   time4=$(($time3 + 14400))
   FREQ=600
   nbh_filter="1701183600,1701197400;1701241200,1701255000"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0073]Tier:ALL, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 86400))
   time1=$st
   time2=$(($time1 + 14400))
   time3=$(($et - 14400))
   time4=$et
   time5=$(($time2 + 14400))
   time6=$(($time5 + 14400))
   FREQ=600
   nbh_filter="1701169200,1701183000;1701207000,1701217800;1701241200,1701255000"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#---------------------- Non Business hour test cases for duration 7 day  ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH0074]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day' {
   get_detail
   et=$(($st + 604800))
   time1=$(($st + 86400))
   time2=$(($time1 + 86400))
   FREQ=3600
   nbh_filter="1701255600,1701338400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0075]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day, NBH from start time' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701252000"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0076]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from end time' {
   get_detail
   et=$(($st + 604800))
   time1=$(($et - 86400))
   time2=$et
   FREQ=3600
   nbh_filter="1701219600,1701252000"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0077]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH use in 2 intervel time ' {
   get_detail
   et=$(($st + 604800))
   time1=$(($st + 86400))
   time2=$(($time1 + 86400))
   time3=$(($et - 172800))
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701255600,1701338400;1701349200,1701428400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:4
@test '[NBH0078]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   time3=$(($et - 172800))
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701252000;1701349200,1701428400"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0079]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 604800))
   time1=$(($et - 86400))
   time2=$et
   time3=$st 
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701252000;1701651600,1701770400"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0080]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   time3=$(($et - 86400))
   time4=$et
   time5=$(($time2 + 28800))
   time6=$(($time5 + 28800))
   FREQ=3600
   nbh_filter="1701169200,1701252000;1701439200,1701532800;1701651600,1701770400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#---------------------- Non Business hour test cases for duration 30 day  ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0081]Tier:ALL, OP=Data Query, Duration=30 day, NBH time=2 day ,NBH use in 4 interval time' {
   skip "Need long duration TR"
   get_detail
   et=$(($st + 2592000 ))
   time1=$(($st + 432000 ))
   time2=$(($time1 + 86400))
   time3=$(($time2 + 432000))
   time4=$(($time3 + 86400))
   time5=$(($time4 + 432000))
   time6=$(($time5 + 86400))
   time7=$(($time6 + 432000))
   time8=$(($time7 + 86400))
   FREQ=14400
   nbh_filter=";$time3,$time4;time5,time6;time7,time8"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#-------------------Non Business hour test cases for DT Filter ---------------------------

#bats test_tags=op:dcn,level:1,filter:exact,id:1
@test '[NBH0082]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min, DT=min,max' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   FREQ=10
   nbh_filter="1701168690,1701168750"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  DT="min max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0083]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time,DT=avg,count' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   FREQ=10
   nbh_filter="1701168690,1701169280"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="avg count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0084]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from end time,DT=avg,min' {
   get_detail
   et=$(($st + 3000))
   time1=$(($et - 600))
   time2=$et
   FREQ=10
   nbh_filter="1701168690,1701168750"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="avg min" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0085]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 2 intervel time,DT=max,count ' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   time3=$(($time2 + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701168690,1701168750;1701169290,1701169880"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et DT="max count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0086]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time, NBH use in 2 intervel time, DT=min,count ' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   time3=$(($time2 + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701168690,1701169280;1701169890,1701170480"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0087]Tier:ALL, OP=Data Query, Duration=1 hour, NBH time=10 min,NBH from end time, NBH use in 2 intervel time, DT=min,avg' {
   get_detail
   et=$(($st + 3000))
   time1=$(($et - 600))
   time2=$et
   time3=$(($st + 600))
   time4=$(($time3 + 600))
   FREQ=10
   nbh_filter="1701168690,1701168750;1701169290,1701169880"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0088]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 3 intervel time, DT=min,avg' {
   get_detail
   et=$(($st + 3000))
   time1=$st
   time2=$(($time1 + 600))
   time3=$(($et - 600))
   time4=$et
   time5=$(($time2 + 300))
   time6=$(($time5 + 300))
   FREQ=10
   nbh_filter="1701168690,1701169280;1701171090,1701171680;1701170160,1701170500"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et DT="min avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:2
@test '[NBH0089]Tier:ALL, OP=Data Query, Duration=4 Hour, NBH time=1 hour, DT=max,avg' {
   get_detail
   et=$(($st + 14000))
   time1=$(($st + 3600))
   time2=$(($time1 + 3600))
   FREQ=60
   nbh_filter="1701172320,1701175860"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et DT="max avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0090]Tier:ALL, OP=Data Query, Duration=4 Hour, NBH time=1 hour, NBH from start time, DT=min,avg' {
   get_detail
   et=$(($st + 14000))
   time1=$st
   time2=$(($time1 + 3600))
   FREQ=60
   nbh_filter="1701168720,1701172260"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0091]Tier:ALL, OP=Data Query, Duration=4 hour, NBH time=1 hour,NBH from end time, DT=avg, count' {
   get_detail
   et=$(($st + 14000))
   time1=$(($et - 3600))
   time2=$et
   FREQ=60
   nbh_filter="1701179100,1701182640"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="count avg" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0092]Tier:ALL, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH use in 3 intervel time, DT=avg,max' {
   get_detail
   et=$(($st + 86400))
   time1=$st
   time2=$(($time1 + 14400))
   time3=$(($et - 14400))
   time4=$et
   time5=$(($time2 + 14400))
   time6=$(($time5 + 14400))
   FREQ=600
   nbh_filter="1701169200,1701183000;1701241200,1701255000;1701189000,1701199800"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et DT="avg max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH0093]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day, DT=count,max' {
   get_detail
   et=$(($st + 604800))
   time1=$(($st + 86400))
   time2=$(($time1 + 86400))
   FREQ=3600
   nbh_filter="1701255600,1701428400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et DT="count max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0094]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day, NBH from start time, DT=min,max' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701428400"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0095]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from end time, DT=avg,count' {
   get_detail
   et=$(($st + 604800))
   time1=$(($et - 86400))
   time2=$et
   FREQ=3600
   nbh_filter="1701648000,1701770400"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="avg count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0096]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH use in 2 intervel time, DT=min,max,count ' {
   get_detail
   et=$(($st + 604800))
   time1=$(($st + 86400))
   time2=$(($time1 + 86400))
   time3=$(($et - 172800))
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701255600,1701428400;1701601200,1701770400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  DT="min max count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:4
@test '[NBH0097]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from start time, NBH use in 2 intervel time, DT=min,avg,max' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   time3=$(($et - 172800))
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701266400;1701597600,1701759600"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et DT="min avg max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0098]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day ,NBH from end time, NBH use in 2 intervel time, DT=count,max,min' {
   get_detail
   et=$(($st + 604800))
   time1=$(($et - 86400))
   time2=$et
   time3=$st
   time4=$(($time3 + 86400))
   FREQ=3600
   nbh_filter="1701169200,1701259200;1701651600,1701770400"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}"  ST=$st ET=$et  DT="count max min" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH0099]Tier:ALL, OP=Data Query, Duration=7 day, NBH time=1 day,NBH use in 3 intervel time, DT=avg,min,max' {
   get_detail
   et=$(($st + 604800))
   time1=$st
   time2=$(($time1 + 86400))
   time3=$(($et - 86400))
   time4=$et
   time5=$(($time2 + 28800))
   time6=$(($time5 + 28800))
   FREQ=3600
   nbh_filter="1701169200,1701248400;1701327600,1701439200;1701648000,1701770400"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et DT="avg min max" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact
@test '[NBH00100]Tier:ALL, OP=Data Query, Duration=30 day, NBH time=2 day ,NBH use in 4 interval time, DT=min,max,count' {
   skip "Need long duration test"
   get_detail
   et=$(($st + 2592000 ))
   time1=$(($st + 432000 ))
   time2=$(($time1 + 86400))
   time3=$(($time2 + 432000))
   time4=$(($time3 + 86400))
   time5=$(($time4 + 432000))
   time6=$(($time5 + 86400))
   time7=$(($time6 + 432000))
   time8=$(($time7 + 86400))
   nbh_filter="$time1,$time2;$time3,$time4;time5,time6;time7,time8"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  DT="min,max,count" NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#---------------------- Non Business hour test cases for percentile   ------------------------------------

#bats test_tags=op:dcn,level:1,filter:exact,id:1
@test '[NBH00101]Tier:ALL, OP=Data Query, Duration=1 Hour, NBH time=10 min, DT=percentile' {
   get_detail
   et=$(($st + 3000))
   time1=$(($st + 600))
   time2=$(($time1 + 600))
   nbh_filter="$st,$et"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et DT=percentile NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact,id:2,test:1
@test '[NBH00102]Tier:ALL, OP=Data Query, Duration=4 Hour , DT=percentile' {
   get_detail
   et=$(($st + 14000))
   FREQ=60
   nbh_filter="$st,$et"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et DT=percentile NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH00103]Tier:ALL, OP=Data Query, Duration=1 day ,DT=percentile' {
   get_detail
   et=$(($st + 86400))
   FREQ=600
   nbh_filter="$st,$et"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et  DT=percentile NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact,id:3
@test '[NBH00104]Tier:ALL, OP=Data Query, Duration=7 day, DT=percentile' {
   get_detail
   et=$(($st + 604800))
   FREQ=3600
   nbh_filter="$st,$et"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT_ALL}" MEASURE="${MEASURE}" ST=$st ET=$et DT=percentile NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#-------------------------------------------rollup by-----------------------
#
#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00105]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time, NBH use in 2 intervel time, g=60' {
   get_detail
   et=$(($st + 3000))
   FREQ=60
   nbh_filter="1701168690,1701169280;1701169890,1701170480"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et VIEW_BY=1m NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00106]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 3 intervel time, g=60' {
   get_detail
   et=$(($st + 3000))
   FREQ=60
   nbh_filter="1701168690,1701169280;1701169960,1701170830;1701171090,1701171680"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et VIEW_BY=1m  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00107]Tier:EXACT, OP=Data Query, Duration=1 hour, NBH time=10 min,NBH from end time, NBH use in 2 intervel time, g=60' {
   get_detail
   et=$(($st + 3000))
   FREQ=60
   nbh_filter="1701169290,1701169880;1701171090,1701171600"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et VIEW_BY=1m NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00108]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH from start time, NBH use in 2 intervel time, g=600' {
   get_detail
   et=$(($st + 14000))
   FREQ=600
   nbh_filter="1701168720,1701172260;1701174120,1701177660"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et VIEW_BY=10m NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00109]Tier:EXACT, OP=Data Query, Duration=4 hour, NBH time=1 hour,NBH from end time, NBH use in 2 intervel time, g=600' {
   get_detail
   et=$(($st + 14000))
   FREQ=600
   nbh_filter="1701169320,1701172860;1701179100,1701182400"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et VIEW_BY=10m NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00110]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH use in 3 intervel time, g=600' {
   get_detail
   et=$(($st + 14000))
   FREQ=600
   nbh_filter="1701168720,1701171300;1701172380,1701174840;1701179700,1701182640"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et VIEW_BY=10m  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#bats test_tags=op:dcn,level:1,filter:exact,id:4,abhi:1
@test '[NBH00111]Tier:EXACT, OP=Data Query, Duration=3 day, NBH time=4 hour,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 259200))
   FREQ=3600
   nbh_filter="1701194400,1701270000;1701302400,1701360000"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  VIEW_BY=60m ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00112]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 345600))
   FREQ=3600
   nbh_filter="1701169200,1701252000;1701468000,1701511200"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" VIEW_BY=60m ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}



#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00113]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 345600))
   FREQ=3600
   nbh_filter="1701183600,1701237600;1701291600,1701367200;1701478800,1701511200"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" VIEW_BY=60m ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}


#-------------------------------------------rollup by 2-----------------------
#
#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00114]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH from start time, NBH use in 2 intervel time, g=60' {
   get_detail
   et=$(($st + 3000))
   FREQ=60
   nbh_filter="1701168720,1701169680;1701169500,1701170640"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et VIEW_BY=1m NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00115]Tier:EXACT, OP=Data Query, Duration=1 Hour, NBH time=10 min,NBH use in 3 intervel time, g=60' {
   get_detail
   et=$(($st + 3000))
   FREQ=60
   nbh_filter="1701168780,1701169800;1701169620,1701170760;1701170580,1701171300"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et VIEW_BY=1m  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00116]Tier:EXACT, OP=Data Query, Duration=1 hour, NBH time=10 min,NBH from end time, NBH use in 2 intervel time, g=60' {
   get_detail
   et=$(($st + 3000))
   FREQ=60
   nbh_filter="1701168780,1701170040;1701169920,1701171120"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et VIEW_BY=1m NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00117]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH from start time, NBH use in 2 intervel time, g=600' {
   get_detail
   et=$(($st + 14000))
   FREQ=600
   nbh_filter="1701169200,1701176400;1701175200,1701181800"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et VIEW_BY=10m NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00118]Tier:EXACT, OP=Data Query, Duration=4 hour, NBH time=1 hour,NBH from end time, NBH use in 2 intervel time, g=600' {
   get_detail
   et=$(($st + 14000))
   FREQ=600
   nbh_filter="1701169200,1701175800;1701174000,1701181800"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  ST=$st ET=$et VIEW_BY=10m NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00119]Tier:EXACT, OP=Data Query, Duration=4 Hour, NBH time=1 hour,NBH use in 3 intervel time, g=600' {
   get_detail
   et=$(($st + 14000))
   FREQ=600
   nbh_filter="1701169200,1701173400;1701172200,1701178200;1701177000,1701181800"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" ST=$st ET=$et VIEW_BY=10m  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,id:4,abhi:1
@test '[NBH00120]Tier:EXACT, OP=Data Query, Duration=3 day, NBH time=4 hour,NBH from start time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 259200))
   FREQ=3600
   nbh_filter="1701172800,1701230400;1701219600,1701302400"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}"  VIEW_BY=60m ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00121]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH from end time, NBH use in 2 intervel time' {
   get_detail
   et=$(($st + 345600))
   FREQ=3600
   nbh_filter="1701169200,1701230400;1701223200,1701273600"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" VIEW_BY=60m ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}



#bats test_tags=op:dcn,level:1,filter:exact,abhi:1
@test '[NBH00122]Tier:EXACT, OP=Data Query, Duration=1 day, NBH time=4 hour,NBH use in 3 intervel time' {
   get_detail
   et=$(($st + 345600))
   FREQ=3600
   nbh_filter="1701169200,1701201600;1701190800,1701230400;1701219600,1701277200"
   automation_log "nbh_filter=$nbh_filter"
   run_query OP=dcn SUBJECT="${SUBJECT}" MEASURE="${MEASURE}" VIEW_BY=60m ST=$st ET=$et  NON_BUSINESS_HOUR="\"1;${nbh_filter}\"" OUTFILE=$RESPONSE_FILE
   automation_log "$OUTFILE"
   automation_log "$RESPONSE_FILE"
   output=$(validate_output)
   assert_output "PASS"
}






















