#!/home/cavisson/work/TSDB/tsdb/automation/thirdparty/bats-core/bin/bats
setup() {
         source ./testsuites/common
         common_setup
         source ./lib/tsdbRequests
	 source ${GROUP_LIB}/group_lib
         export RESPONSE_FILE=$GROUP_REP/MG_$BATS_TEST_NUMBER.txt
     }
@test "[TC-01],Check Tags in request is present on gdf file" {
       run_query OP=mgn TAG_NAME="product=netocean" KEY="req" FLAG=6 OUTFILE=$RESPONSE_FILE 
       TAG_NAME="product=netocean"
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_1.txt"
       output=$(validate_results "$TAG_NAME"  "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_1.txt")
       assert_output "PASS"
    }

@test "[TC-02],Query without tags in request is present on gdf file" {
       run_query OP=mgn KEY="req" FLAG=5 OUTFILE=$RESPONSE_FILE 
       KEY="req"
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_2.txt"
       output=$(check_without_tag_name "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_2.txt" "$KEY")
       assert_output "PASS"
    }

@test "[TC-03],Query with tags present on gdf file" {
       run_query OP=mgn KEY="req" TAG_NAME="product=netocean" FLAG=6 OUTFILE=$RESPONSE_FILE 
       KEY="req"
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_3.txt"
       output=$(check_with_tag_name "$TAG_NAME" "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_3.txt" "$KEY")
       assert_output "PASS"
    }

@test "[TC-04],Query with keyword " {
       run_query OP=mgn KEY="req" FLAG=5 OUTFILE=$RESPONSE_FILE 
       KEY="req"
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_4.txt"
       output=$(check_with_tag_name "$TAG_NAME" "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_4.txt" "$KEY")
       assert_output "PASS"
    }

@test "[TC-05],Query with wrong keyword" {
       run_query OP=mgn TAG_NAME="product=netocean" KEY="net" FLAG=6 OUTFILE=$RESPONSE_FILE 
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_5.txt"
       output=$(check_no_group_found "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_5.txt")
       assert_output "PASS"
    }

@test "[TC-05],Query with wrong tag_name" {
       run_query OP=mgn TAG_NAME="product=neto" KEY="req" FLAG=6 OUTFILE=$RESPONSE_FILE 
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_5.txt"
       output=$(check_no_group_found "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_5.txt")
       assert_output "PASS"
    }

@test "[TC-06],Check Tags in request is present on gdf file" {
       run_query OP=mgn TAG_NAME="product=netocean" KEY="req" FLAG=6 OUTFILE=$RESPONSE_FILE 
       TAG_NAME="product=netocean"
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_6.txt"
       output=$(validate_results "$TAG_NAME"  "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_6.txt")
       assert_output "PASS"
    }

@test "[TC-07],Check Tags in request is present on gdf file" {
       run_query OP=mgn TAG_NAME="product=netocean" KEY="req" FLAG=6 OUTFILE=$RESPONSE_FILE 
       TAG_NAME="product=netocean"
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_7.txt"
       output=$(validate_results "$TAG_NAME"  "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_7.txt")
       assert_output "PASS"
    }

@test "[TC-08],Check Tags in request is present on gdf file" {
       run_query OP=mgn TAG_NAME="product=netocean" KEY="req" FLAG=6 OUTFILE=$RESPONSE_FILE 
       TAG_NAME="product=netocean"
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_8.txt"
       output=$(validate_results "$TAG_NAME"  "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_8.txt")
       assert_output "PASS"
    }

@test "[TC-09],Check Tags in request is present on gdf file" {
       run_query OP=mgn TAG_NAME="product=netocean" KEY="req" FLAG=6 OUTFILE=$RESPONSE_FILE 
       TAG_NAME="product=netocean"
       response="$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_9.txt"
       output=$(validate_results "$TAG_NAME"  "$NS_WDIR/TSDB/tsdb/automation/responses/group/MG_9.txt")
       assert_output "PASS"
    }

