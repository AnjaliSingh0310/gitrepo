#!/home/cavisson/work/TSDB/tsdb/automation/thirdparty/bats-core/bin/bats

@test "[TC-1]Subject:Default>Default>datacall-tier-1>datacall-server-3>Processor-2, Metric:User CPU Busy (Pct)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:User CPU Busy (Pct),10010,1"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" "MGType:System Metrics>MGroup:MPStat Linux>Metric:User CPU Busy (Pct),10010,1" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-2]Subject:Default>Default>datacall-tier-1>datacall-server-3>Processor-2, Metric:Nice CPU Busy (Pct)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:Nice CPU Busy (Pct),10010,2"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" "MGType:System Metrics>MGroup:MPStat Linux>Metric:Nice CPU Busy (Pct),10010,2" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-3]Subject:Default>Default>datacall-tier-1>datacall-server-3>Processor-2, Metric:System CPU Busy (Pct)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:System CPU Busy (Pct),10010,3"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" "MGType:System Metrics>MGroup:MPStat Linux>Metric:System CPU Busy (Pct),10010,3" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-4]Subject:Default>Default>datacall-tier-1>datacall-server-3>Processor-2, Metric:IOWait CPU (Pct)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:IOWait CPU (Pct),10010,4"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" "MGType:System Metrics>MGroup:MPStat Linux>Metric:IOWait CPU (Pct),10010,4" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-5]Subject:Default>Default>datacall-tier-1>datacall-server-3>Processor-2, Metric:IRQ CPU (Pct)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:IRQ CPU (Pct),10010,5"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" "MGType:System Metrics>MGroup:MPStat Linux>Metric:IRQ CPU (Pct),10010,5" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-6]Subject:Default>Default>datacall-tier-1>datacall-server-3>Processor-2, Metric:Soft IRQ CPU (Pct)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:Soft IRQ CPU (Pct),10010,6"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" "MGType:System Metrics>MGroup:MPStat Linux>Metric:Soft IRQ CPU (Pct),10010,6" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-7]Subject:Default>Default>datacall-tier-1>datacall-server-3>Processor-2, Metric:Steal CPU (Pct)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:Steal CPU (Pct),10010,7"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" "MGType:System Metrics>MGroup:MPStat Linux>Metric:Steal CPU (Pct),10010,7" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-8]Subject:Default>Default>datacall-tier-1>datacall-server-3>Processor-2, Metric:Guest CPU (Pct)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:Guest CPU (Pct),10010,8"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" "MGType:System Metrics>MGroup:MPStat Linux>Metric:Guest CPU (Pct),10010,8" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-9]Subject:Default>Default>datacall-tier-1>datacall-server-3>Processor-2, Metric:Idle CPU (Pct)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" MEASURE="MGType:System Metrics>MGroup:MPStat Linux>Metric:Idle CPU (Pct),10010,9"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datacall-tier-1>Server:datacall-server-3>Processor:Processor-2" "MGType:System Metrics>MGroup:MPStat Linux>Metric:Idle CPU (Pct),10010,9" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-10]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample No Formula,10005,1"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample No Formula,10005,1" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-11]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample PS,10005,2"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample PS,10005,2" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-12]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample PM,10005,3"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample PM,10005,3" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-13]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_1B No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_1B No Formula,10005,4"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_1B No Formula,10005,4" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-14]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_1B PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_1B PS,10005,5"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_1B PS,10005,5" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-15]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_1B PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_1B PM,10005,6"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_1B PM,10005,6" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-16]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_2B_100 No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100 No Formula,10005,7"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100 No Formula,10005,7" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-17]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_2B_100 PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100 PS,10005,8"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100 PS,10005,8" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-18]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_2B_100 PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100 PM,10005,9"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100 PM,10005,9" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-19]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_4B No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B No Formula,10005,10"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B No Formula,10005,10" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-20]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_4B PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B PS,10005,11"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B PS,10005,11" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-21]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_4B PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B PM,10005,12"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B PM,10005,12" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-22]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_4B_1000 No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B_1000 No Formula,10005,13"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B_1000 No Formula,10005,13" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-23]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_4B_1000 PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B_1000 PS,10005,14"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B_1000 PS,10005,14" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-24]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_4B_1000 PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B_1000 PM,10005,15"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_4B_1000 PM,10005,15" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-25]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_2B_100_Count_4B No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100_Count_4B No Formula,10005,16"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100_Count_4B No Formula,10005,16" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-26]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_2B_100_Count_4B PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100_Count_4B PS,10005,17"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100_Count_4B PS,10005,17" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-27]Subject:Default>Default>datatype-tier>datatype-server, Metric:Sample_2B_100_Count_4B PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100_Count_4B PM,10005,18"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Sample_2B_100_Count_4B PM,10005,18" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-28]Subject:Default>Default>datatype-tier>datatype-server, Metric:Rate No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate No Formula,10005,19"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate No Formula,10005,19" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-29]Subject:Default>Default>datatype-tier>datatype-server, Metric:Rate PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate PS,10005,20"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate PS,10005,20" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-30]Subject:Default>Default>datatype-tier>datatype-server, Metric:Rate PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate PM,10005,21"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate PM,10005,21" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-31]Subject:Default>Default>datatype-tier>datatype-server, Metric:Rate_4B_1000 No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate_4B_1000 No Formula,10005,22"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate_4B_1000 No Formula,10005,22" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-32]Subject:Default>Default>datatype-tier>datatype-server, Metric:Rate_4B_1000 PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate_4B_1000 PS,10005,23"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate_4B_1000 PS,10005,23" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-33]Subject:Default>Default>datatype-tier>datatype-server, Metric:Rate_4B_1000 PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate_4B_1000 PM,10005,24"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Rate_4B_1000 PM,10005,24" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-34]Subject:Default>Default>datatype-tier>datatype-server, Metric:Cummulative No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Cummulative No Formula,10005,25"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Cummulative No Formula,10005,25" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-35]Subject:Default>Default>datatype-tier>datatype-server, Metric:Cummulative PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Cummulative PS,10005,26"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Cummulative PS,10005,26" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-36]Subject:Default>Default>datatype-tier>datatype-server, Metric:Cummulative PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Cummulative PM,10005,27"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Cummulative PM,10005,27" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-37]Subject:Default>Default>datatype-tier>datatype-server, Metric:Times No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times No Formula,10005,28"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times No Formula,10005,28" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-38]Subject:Default>Default>datatype-tier>datatype-server, Metric:Times PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times PS,10005,29"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times PS,10005,29" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-39]Subject:Default>Default>datatype-tier>datatype-server, Metric:Times PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times PM,10005,30"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times PM,10005,30" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-40]Subject:Default>Default>datatype-tier>datatype-server, Metric:Times_4B_10 No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_10 No Formula,10005,31"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_10 No Formula,10005,31" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-41]Subject:Default>Default>datatype-tier>datatype-server, Metric:Times_4B_10 PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_10 PS,10005,32"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_10 PS,10005,32" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-42]Subject:Default>Default>datatype-tier>datatype-server, Metric:Times_4B_10 PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_10 PM,10005,33"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_10 PM,10005,33" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-43]Subject:Default>Default>datatype-tier>datatype-server, Metric:Times_4B_1000 No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_1000 No Formula,10005,34"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_1000 No Formula,10005,34" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-44]Subject:Default>Default>datatype-tier>datatype-server, Metric:Times_4B_1000 PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_1000 PS,10005,35"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_1000 PS,10005,35" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-45]Subject:Default>Default>datatype-tier>datatype-server, Metric:Times_4B_1000 PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_1000 PM,10005,36"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:Times_4B_1000 PM,10005,36" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-46]Subject:Default>Default>datatype-tier>datatype-server, Metric:TimesStd No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd No Formula,10005,37"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd No Formula,10005,37" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-47]Subject:Default>Default>datatype-tier>datatype-server, Metric:TimesStd PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd PS,10005,38"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd PS,10005,38" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-48]Subject:Default>Default>datatype-tier>datatype-server, Metric:TimesStd PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd PM,10005,39"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd PM,10005,39" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-49]Subject:Default>Default>datatype-tier>datatype-server, Metric:TimesStd_4B_1000 No Formula" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd_4B_1000 No Formula,10005,40"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd_4B_1000 No Formula,10005,40" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-50]Subject:Default>Default>datatype-tier>datatype-server, Metric:TimesStd_4B_1000 PS" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd_4B_1000 PS,10005,41"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd_4B_1000 PS,10005,41" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-51]Subject:Default>Default>datatype-tier>datatype-server, Metric:TimesStd_4B_1000 PM" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" MEASURE="MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd_4B_1000 PM,10005,42"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:datatype-tier>Server:datatype-server" "MGType:Application Metrics>MGroup:Datatype Testing>Metric:TimesStd_4B_1000 PM,10005,42" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-52]Subject:Default>Default>metadata_tree-tier, Metric:Number Of Servers" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:metadata_tree-tier" MEASURE="MGType:System Metrics>MGroup:Tier Info Stats>Metric:Number Of Servers,10550,1"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:metadata_tree-tier" "MGType:System Metrics>MGroup:Tier Info Stats>Metric:Number Of Servers,10550,1" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-53]Subject:Default>Default>metadata_tree-tier>metadata_tree-server-2, Metric:Number Of CPU Cores" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" MEASURE="MGType:System Metrics>MGroup:CPU Stats>Metric:Number Of CPU Cores,10729,1"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" "MGType:System Metrics>MGroup:CPU Stats>Metric:Number Of CPU Cores,10729,1" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-54]Subject:Default>Default>metadata_tree-tier>metadata_tree-server-2, Metric:L1d Cache Memory(KB)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" MEASURE="MGType:System Metrics>MGroup:CPU Stats>Metric:L1d Cache Memory(KB),10729,2"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" "MGType:System Metrics>MGroup:CPU Stats>Metric:L1d Cache Memory(KB),10729,2" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-55]Subject:Default>Default>metadata_tree-tier>metadata_tree-server-2, Metric:L1i Cache Memory(KB)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" MEASURE="MGType:System Metrics>MGroup:CPU Stats>Metric:L1i Cache Memory(KB),10729,3"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" "MGType:System Metrics>MGroup:CPU Stats>Metric:L1i Cache Memory(KB),10729,3" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-56]Subject:Default>Default>metadata_tree-tier>metadata_tree-server-2, Metric:L2 Cache Memory(KB)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" MEASURE="MGType:System Metrics>MGroup:CPU Stats>Metric:L2 Cache Memory(KB),10729,4"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" "MGType:System Metrics>MGroup:CPU Stats>Metric:L2 Cache Memory(KB),10729,4" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-57]Subject:Default>Default>metadata_tree-tier>metadata_tree-server-2, Metric:L3 Cache Memory(KB)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" MEASURE="MGType:System Metrics>MGroup:CPU Stats>Metric:L3 Cache Memory(KB),10729,5"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2" "MGType:System Metrics>MGroup:CPU Stats>Metric:L3 Cache Memory(KB),10729,5" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-58]Subject:Default>Default>metadata_tree-tier>metadata_tree-server-2>file-1, Metric:Time Since Last File Update (Sec)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2>File:file-1" MEASURE="MGType:Application Metrics>MGroup:File Stats>Metric:Time Since Last File Update (Sec),10572,1"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2>File:file-1" "MGType:Application Metrics>MGroup:File Stats>Metric:Time Since Last File Update (Sec),10572,1" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-59]Subject:Default>Default>metadata_tree-tier>metadata_tree-server-2>file-1, Metric:File Size (Bytes)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2>File:file-1" MEASURE="MGType:Application Metrics>MGroup:File Stats>Metric:File Size (Bytes),10572,2"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:metadata_tree-tier>Server:metadata_tree-server-2>File:file-1" "MGType:Application Metrics>MGroup:File Stats>Metric:File Size (Bytes),10572,2" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-60]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Requests per sec" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Requests per sec,10245,1"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Requests per sec,10245,1" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-61]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Average Response Time (ms)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Response Time (ms),10245,2"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Response Time (ms),10245,2" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-62]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Average Request Size" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Request Size,10245,3"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Request Size,10245,3" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-63]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Errors/sec" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Errors/sec,10245,4"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Errors/sec,10245,4" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-64]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Normal Average Response Time (ms)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Normal Average Response Time (ms),10245,5"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Normal Average Response Time (ms),10245,5" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-65]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Slow Average Response Time (ms)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Slow Average Response Time (ms),10245,6"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Slow Average Response Time (ms),10245,6" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-66]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Very Slow Average Response Time (ms)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Very Slow Average Response Time (ms),10245,7"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Very Slow Average Response Time (ms),10245,7" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-67]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Error Average Response Time (ms)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Error Average Response Time (ms),10245,8"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Error Average Response Time (ms),10245,8" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-68]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Percent Slow and Very Slow Transactions" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Percent Slow and Very Slow Transactions,10245,9"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Percent Slow and Very Slow Transactions,10245,9" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-69]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Average Cpu Time (ms)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Cpu Time (ms),10245,10"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Cpu Time (ms),10245,10" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-70]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Average Wait Time (ms)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Wait Time (ms),10245,11"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Wait Time (ms),10245,11" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-71]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Average Sync Time (ms)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Sync Time (ms),10245,12"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Sync Time (ms),10245,12" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

@test "[TC-72]Subject:Default>Default>business-tier-2>business-server-1>business-instance-2>business-transaction-2, Metric:Average Queue Time (ms)" {
       run_query OP=dcn TP_TYPE=preset DURATION=5 OUTFILE=$RESPONSE_FILE SUBJECT="customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" MEASURE="MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Queue Time (ms),10245,13"
       assert_equal "X$(grep 'Error Code:' $RESPONSE_FILE | awk -F',' '{print $NF}' | xargs)" "X"
       set_values "customer:Default>application:Default>Tier:business-tier-2>Server:business-server-1>Instance:business-instance-2>Business Transactions:business-transaction-2" "MGType:Application Metrics>MGroup:Business Transactions>Metric:Average Queue Time (ms),10245,13" "1"
       set_dcn_expected_values "5" "Exact"
       extract_actual_output
       output=$(validate_response)
       assert_output "PASS"
    }

setup() {
         source ./testsuites/common
         common_setup
         source ./lib/tsdbRequests
         source $DATACALL_LIB/datacall_lib_noc
         export GDF_CONF_FILE=GDF.conf
         export RESPONSE_FILE=$DATA_REP/DC_$BATS_TEST_NUMBER.txt
         }
