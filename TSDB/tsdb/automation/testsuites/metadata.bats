#!/home/cavisson/work/TSDB/tsdb/automation/thirdparty/bats-core/bin/bats

setup() {
  source ./testsuites/common
  common_setup
  automation_log ""
  automation_log "TC - $BATS_TEST_DESCRIPTION"
  export ERR_MSG=""
  source $METADATA_LIB/metadata_lib
}

get_metric_detail() {
  if [ $HIER_LEVEL -eq 1 ];then
     export GDF_FILE=cm_server_count.gdf
     HIER=`grep "^Group" $NS_WDIR/sys/$GDF_FILE | cut -d"|" -f3`
     automation_log "OP=$OP"
  elif [ $HIER_LEVEL -eq 2 ];then
     export GDF_FILE=cm_cpu_stats.gdf
     HIER=`grep "^Group" $NS_WDIR/sys/$GDF_FILE | cut -d"|" -f3`
  elif [ $HIER_LEVEL -eq 3 ];then 
     export GDF_FILE=cm_stats_file.gdf
     HIER=`grep "^Group" $NS_WDIR/sys/$GDF_FILE | cut -d"|" -f3`
  elif [ $HIER_LEVEL -eq 4 ];then
     export GDF_FILE=cm_nd_bt.gdf
     HIER=`grep "^Group" $NS_WDIR/sys/$GDF_FILE | cut -d"|" -f3` 
  fi
     if [ $TAG_FLAG -eq 1 ];then
       METRIC_LINE=`grep $HIER $METRIC_FILE | grep "tags" | shuf -n 1`
       METRIC_ID=`echo $METRIC_LINE | cut -d',' -f1`
       NFIDX=`echo $METRIC_LINE | cut -d',' -f2`
       SUBJECT=`echo $METRIC_LINE | cut -d"," -f3`
       TAGS=`echo $METRIC_LINE | cut -d',' -f4- | rev | cut -d',' -f5- | rev`
       MEASURE=`echo $METRIC_LINE | cut -d"," -f4- | rev | cut -d',' -f2-4 | rev`
       echo "export METRIC_LINE='$METRIC_LINE'" > ${MT_DETAIL_FILE}
       echo "export METRIC_ID=$METRIC_ID" >> ${MT_DETAIL_FILE}
       echo "export NFIDX=$NFIDX" >> ${MT_DETAIL_FILE}
       echo "export SUBJECT='$SUBJECT'" >> ${MT_DETAIL_FILE}
       echo "export MEASURE='$MEASURE'" >> ${MT_DETAIL_FILE}
       echo "export TAGS='$TAGS'" >> ${MT_DETAIL_FILE}
     else
       METRIC_LINE=`grep $HIER $METRIC_FILE | grep -v "tags" | shuf -n 1`
       METRIC_ID=`echo $METRIC_LINE | cut -d',' -f1`
       NFIDX=`echo $METRIC_LINE | cut -d',' -f2`
       SUBJECT=`echo $METRIC_LINE | cut -d"," -f3`
       MEASURE=`echo $METRIC_LINE | cut -d"," -f4-6`
       echo "export METRIC_LINE='$METRIC_LINE'" > ${MT_DETAIL_FILE}
       echo "export METRIC_ID=$METRIC_ID" >> ${MT_DETAIL_FILE}
       echo "export NFIDX=$NFIDX" >> ${MT_DETAIL_FILE}
       echo "export SUBJECT='$SUBJECT'" >> ${MT_DETAIL_FILE}
       echo "export MEASURE='$MEASURE'" >> ${MT_DETAIL_FILE}
     fi
     source ${MT_DETAIL_FILE}
     if [ "$OP" == "MOR" ];then
        create_open_related_file 
     elif [ "$OP" == "MPM" ];then
        create_pattern_match_file
     else
        create_input_file 
     fi
}


COMMON_TEST_OUTPUT() {
  OUTPUTFILE=${METADATA_REP}/${BATS_TEST_NUMBER}.output
  if [ "$OP" == "MOR" ];then
    automation_log tsdb_admin --tr $TESTIDX --op mor --f ${PATTERN_FILE} 
    tsdb_admin --tr $TESTIDX --op mor --f ${PATTERN_FILE} > $OUTPUTFILE
  elif [ "$OP" == "MPM" ];then
    automation_log tsdb_admin --tr $TESTIDX --op mpm --f ${PATTERN_FILE} --threshold 0
    tsdb_admin --tr $TESTIDX --op mpm --f ${PATTERN_FILE} --threshold 0 > $OUTPUTFILE
  else
    automation_log tsdb_admin --tr $TESTIDX --op mom --f ${PATTERN_FILE} --version $VERSION
    tsdb_admin --tr $TESTIDX --op mom --f ${PATTERN_FILE} --version $VERSION > $OUTPUTFILE
  fi

}




#---------------------- Metadata Open Merge, Exact Cases without      tag------------------------------------

#bats test_tags=op:mom,level:1,version:1,filter:exact,id:1
@test '[MOM001]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=Exact, Version=1' {
   HIER_LEVEL=1
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:1,filter:exact,id:2
@test '[MOM002]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Exact, Version=1' {
   HIER_LEVEL=2
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:1,filter:exact,id:3
@test '[MOM003]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=1' {
   HIER_LEVEL=3
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:1,version:2,filter:exact,id:4
@test '[MOM004]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=Exact, Version=2' {
   HIER_LEVEL=1
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:2,filter:exact,id:5
@test '[MOM005]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Exact, Version=2' {
   HIER_LEVEL=2
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:exact,id:6
@test '[MOM006]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=2' {
   HIER_LEVEL=3
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}








#------------------------------- Metadata Open Merge, All Cases w     ithout tag --------------------------------------------------

#bats test_tags=op:mom,level:1,version:1,filter:all,id:7
@test '[MOM007]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=All, Version=1' {
   HIER_LEVEL=1
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:1,filter:all,id:8
@test '[MOM008]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=All, Version=1' {
   HIER_LEVEL=2
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:1,filter:all,id:9
@test '[MOM009]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=1' {
   HIER_LEVEL=3
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:1,version:2,filter:all,id:10
@test '[MOM010]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=All, Version=2' {
   HIER_LEVEL=1
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:2,filter:all,id:11
@test '[MOM011]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=All, Version=2' {
   HIER_LEVEL=2
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:all,id:12
@test '[MOM012]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=2' {
   HIER_LEVEL=3
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}










#----------------------------------Metadata Open Merge, Pattern C     ases without tag-----------------------------

#bats test_tags=op:mom,level:1,version:1,filter:pattern,id:13
@test '[MOM013]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=Pattern, Version=1' {
   HIER_LEVEL=1
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:1,filter:pattern,id:14
@test '[MOM014]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Pattern, Version=1' {
   HIER_LEVEL=2
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:1,filter:pattern,id:15
@test '[MOM015]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Pattern, Version=1' {
   HIER_LEVEL=3
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:1,version:2,filter:pattern,id:16
@test '[MOM016]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=Pattern, Version=2' {
   HIER_LEVEL=1
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:2,filter:pattern,id:17
@test '[MOM017]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Pattern, Version=2' {
   HIER_LEVEL=2
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:pattern,id:18
@test '[MOM018]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Pattern, Version=2' {
   HIER_LEVEL=3
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}







#---------------------------------Metadata Open Related, Exact Cases Without Tag ---------------------------

#bats test_tags=op:mor,level:1,version:1,filter:exact,id:19
@test '[MOR019]Hierarchy=tier, OP=Open related metrics, SUB_MODE=Exact, Version=1' {
   HIER_LEVEL=1
   export OP=MOR
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:2,filter:exact,id:20
@test '[MOR020]Hierarchy=tier>server, OP=Open related metrics, SUB_MODE=Exact' {
   HIER_LEVEL=2
   OP=MOR
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:3,filter:exact,id:21
@test '[MOR021]Hierarchy=tier>server>instance, OP=Open related metrics, SUB_MODE=Exact' {
   HIER_LEVEL=3
   OP=MOR
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}





#-------------------------------- Metadata open related, All Case     s Without Tag--------------------------------------------------

#bats test_tags=op:mor,level:1,version:1,filter:all,id:22
@test '[MOR022]Hierarchy=tier, OP=Open related metrics, SUB_MODE=ALL' {
   HIER_LEVEL=1
   export OP=MOR
   FILTER=ALL
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:2,filter:all,id:23
@test '[MOR023]Hierarchy=tier>server, OP=Open related metrics, SUB_MODE=ALL' {
   HIER_LEVEL=2
   OP=MOR
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:3,filter:all,id:24
@test '[MOR024]Hierarchy=tier>server>instance, OP=Open related metrics, SUB_MODE=all' {
   HIER_LEVEL=3
   OP=MOR
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}






#-------------------------- Metadata open related, Pattern Cases without tags--------------------------------------

#bats test_tags=op:mor,level:1,filter:pattern,id:25
@test '[MOR025]Hierarchy=tier, OP=Open related metrics, SUB_MODE=Pattern' {
   HIER_LEVEL=1
   export OP=MOR
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:2,filter:pattern,id:26
@test '[MOR026]Hierarchy=tier>server, OP=Open related metrics, SUB_MODE=pattern' {
   HIER_LEVEL=2
   OP=MOR
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:3,filter:pattern,id:27
@test '[MOR027]Hierarchy=tier>server>instance, OP=Open related metrics, SUB_MODE=Pattern' {
   HIER_LEVEL=3
   OP=MOR
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}





#------------------------------ Metadata Pattern Matching, Exact Cases without tag-----------------------------------

#bats test_tags=op:mpm,level:2,filter:exact,id:28
@test '[MPM028]Hierarchy=tier>server, OP=Pattern Matching, SUB_MODE=Exact' {
   HIER_LEVEL=2
   OP=MPM
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mpm,level:3,filter:exact,id:29
@test '[MPM029]Hierarchy=tier>server>instance, OP=Pattern Matching, SUB_MODE=Exact' {
   HIER_LEVEL=3
   OP=MPM
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}






#-------------------------------- Metadata pattern matching, All Cases without tag------------------------------------------------

#bats test_tags=op:mpm,level:2,filter:all,id:30
@test '[MPM030]Hierarchy=tier>server, OP=Pattern Matching, SUB_MODE=ALL' {
   HIER_LEVEL=2
   OP=MPM
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mpm,level:3,filter:all,id:31
@test '[MPM031]Hierarchy=tier>server>instance, OP=Pattern matching, SUB_MODE=all' {
   HIER_LEVEL=3
   OP=MPM
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}





#-------------------------------- Metadata Pattern Matching, pattern Cases without tag-----------------------------------

#bats test_tags=op:mpm,level:2,filter:pattern,id:32
@test '[MPM032]Hierarchy=tier>server, OP=Pattern Matching, SUB_MODE=pattern' {
   HIER_LEVEL=2
   OP=MPM
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mpm,level:3,filter:pattern,id:33
@test '[MPM033]Hierarchy=tier>server>instance, OP=Pattern Matching, SUB_MODE=Pattern' {
   HIER_LEVEL=3
   OP=MPM
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}



#---------------------------------Metadata open Merge, Exact Cases with tag ------------------------------------------

#bats test_tags=level:1,version:1,filter:exact,id:34,tag:pass
@test '[MOM034]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=Exact, Version=1, Tag=Enable' {
   HIER_LEVEL=1
   TAG_FLAG=1
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:2,version:1,filter:exact,id:35,tag:pass
@test '[MOM035]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Exact, Version=1, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:3,version:1,filter:exact,id:36,tag:pass
@test '[MOM036]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=1, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:1,version:2,filter:exact,id:37,tag:pass
@test '[MOM037]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=Exact, Version=2, Tag=Enable' {
   HIER_LEVEL=1
   TAG_FLAG=1
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:2,version:2,filter:exact,id:38,tag:pass
@test '[MOM038]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Exact, Version=2, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:3,version:2,filter:exact,id:39,tag:pass
@test '[MOM039]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=2, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}



#-----------------------------------------Metadata Open Merge, All Cases with tag-----------------------------------------------

#bats test_tags=level:1,version:1,filter:all,id:40,tag:pass
@test '[MOM040]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=All, Version=1, Tag=Enable' {
   HIER_LEVEL=1
   TAG_FLAG=1
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:2,version:1,filter:all,id:41,tag:pass
@test '[MOM041]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=All, Version=1, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:3,version:1,filter:all,id:42,tag:pass
@test '[MOM042]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=1, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:1,version:2,filter:all,id:43,tag:pass
@test '[MOM043]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=All, Version=2, Tag=Enable' {
   HIER_LEVEL=1
   TAG_FLAG=1
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:2,version:2,filter:all,id:44,tag:pass
@test '[MOM044]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=All, Version=2, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:3,version:2,filter:all,id:45,tag:pass
@test '[MOM045]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=2, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}






#-------------------------------------- Metadata Open Merge Pattern Cases without tag ---------------------------------

#bats test_tags=level:1,version:1,filter:pattern,id:46,tag:pass
@test '[MOM046]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=Pattern, Version=1, Tag=Enable' {
   HIER_LEVEL=1
   TAG_FLAG=1
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:2,version:1,filter:pattern,id:47,tag:pass
@test '[MOM047]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Pattern, Version=1, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:3,version:1,filter:pattern,id:48,tag:pass
@test '[MOM048]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Pattern, Version=1, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:1,version:2,filter:pattern,id:49,tag:pass
@test '[MOM049]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=Pattern, Version=2, Tag=Enable' {
   HIER_LEVEL=1
   TAG_FLAG=1
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:2,version:2,filter:pattern,id:50,tag:pass
@test '[MOM050]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Pattern, Version=2, tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=level:3,version:2,filter:pattern,id:51,tag:pass
@test '[MOM051]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Pattern, Version=2, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}


#---------------------------------Metadata Open Related, Exact Cases With Tag ---------------------------

#bats test_tags=op:mor,level1,filter:exact,id:52,tag:pass
@test '[MOR052]Hierarchy=tier, OP=Open related metrics, SUB_MODE=Exact, Version=1, Tag=Enable' {
   HIER_LEVEL=1
   TAG_FLAG=1
   OP=MOR
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:2,filter:exact,id:53,tag:pass
@test '[MOR053]Hierarchy=tier>server, OP=Open related metrics, SUB_MODE=Exact, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   OP=MOR
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:3,filter:exact,id:54,tag:pass
@test '[MOR054]Hierarchy=tier>server>instance, OP=Open related metrics, SUB_MODE=Exact, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   OP=MOR
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}





#-------------------------------- Metadata open related, All Cases With Tag--------------------------------------------------

#bats test_tags=op:mor,level1,filter:all,id:55,tag:pass
@test '[MOR055]Hierarchy=tier, OP=Open related metrics, SUB_MODE=ALL, Tag=Enable' {
   HIER_LEVEL=1
   TAG_FLAG=1
   OP=MOR
   FILTER=ALL
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:2,filter:all,id:56,tag:pass
@test '[MOR056]Hierarchy=tier>server, OP=Open related metrics, SUB_MODE=ALL, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   OP=MOR
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:3,filter:all,id:57,tag:pass
@test '[MOR057]Hierarchy=tier>server>instance, OP=Open related metrics, SUB_MODE=all, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   OP=MOR
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}






#-------------------------- Metadata open related, Pattern Cases with tags--------------------------------------

#bats test_tags=op:mor,level:1,filter:pattern,id:58,tag:pass
@test '[MOR058]Hierarchy=tier, OP=Open related metrics, SUB_MODE=Pattern, Tag=Enable' {
   HIER_LEVEL=1
   TAG_FLAG=1
   OP=MOR
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:2,filter:pattern,id:59,tag:pass
@test '[MOR059]Hierarchy=tier>server, OP=Open related metrics, SUB_MODE=pattern, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   OP=MOR
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:3,filter:pattern,id:60,tag:pass
@test '[MOR060]Hierarchy=tier>server>instance, OP=Open related metrics, SUB_MODE=Pattern, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   OP=MOR
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}


#------------------------------ Metadata Pattern Matching, Exact Cases with tag-----------------------------------

#bats test_tags=op:mpm,level:2,filter:exact,id:61,tag:pass
@test '[MPM061]Hierarchy=tier>server, OP=Pattern Matching, SUB_MODE=Exact, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   OP=MPM
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mpm,level:3,filter:exact,id:62,tag:pass
@test '[MPM062]Hierarchy=tier>server>instance, OP=Pattern Matching, SUB_MODE=Exact, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   OP=MPM
   FILTER=exact
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}






#-------------------------------- Metadata pattern matching, All Cases with tag------------------------------------------------

#bats test_tags=op:mpm,level:2,filter:all,id:63,tag:pass
@test '[MPM063]Hierarchy=tier>server, OP=Pattern Matching, SUB_MODE=ALL, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   OP=MPM
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mpm,level:3,filter:all,id:64,tag:pass
@test '[MPM064]Hierarchy=tier>server>instance, OP=Pattern matching, SUB_MODE=all, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   OP=MPM
   FILTER=all
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}





#-------------------------------- Metadata Pattern Matching, pattern Cases with tag-----------------------------------

#bats test_tags=op:mpm,level:2,filter:pattern,id:65,tag:pass
@test '[MPM065]Hierarchy=tier>server, OP=Pattern Matching, SUB_MODE=pattern, Tag=Enable' {
   HIER_LEVEL=2
   TAG_FLAG=1
   OP=MPM
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mpm,level:3,filter:pattern,id:66,tag:pass
@test '[MPM066]Hierarchy=tier>server>instance, OP=Pattern Matching, SUB_MODE=Pattern, Tag=Enable' {
   HIER_LEVEL=3
   TAG_FLAG=1
   OP=MPM
   FILTER=pattern
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}




#--------------------------------------- Metadata Open Merge, Skip in response --------------------------------------------------------

#bats test_tags=op:mom,level:2,version:2,filter:exact,id:67,skip:enable
@test '[MOM067]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Exact, Version=2, skip_response=Tier' {
   HIER_LEVEL=2
   SKIP=ENABLE
   SKIP_MODE="1:0:0"
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:2,filter:exact,id:68,skip:enable
@test '[MOM068]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=Exact, Version=2, skip_response=Server' {
   HIER_LEVEL=2
   SKIP=ENABLE
   SKIP_MODE="0:1:0"
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:exact,id:69,skip:enable
@test '[MOM069]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=2, skip_response=Tier' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:0:0"
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:exact,id:70,skip:enable
@test '[MOM070]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=2, skip_response=Server' {
   skip	"Unsupported"
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="0:1:0"
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:exact,id:71,skip:enable
@test '[MOM071]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=2, skip_response=Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="0:0:1"
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:exact,id:72,skip:enable
@test '[MOM072]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=2, skip_response=Tier,Server' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:1:0"
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:exact,id:73,skip:enable
@test '[MOM073]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=2, skip_response=Tier,Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:0:1"
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:exact,id:74,skip:enable
@test '[MOM074]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=2, skip_response=Tier,Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="0:1:1"
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}
#bats test_tags=op:mom,level:3,version:2,filter:exact,id:75,skip:enable
@test '[MOM075]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=Exact, Version=2, skip_response=Tier,Server,Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:0:1"
   FILTER=exact
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}





#bats test_tags=op:mom,level:2,version:2,filter:all,id:76,skip:enable
@test '[MOM076]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=All, Version=2, skip_response=Tier' {
   HIER_LEVEL=2
   SKIP=ENABLE
   SKIP_MODE="1:0:0"
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:2,filter:all,id:77,skip:enable
@test '[MOM077]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=All, Version=2, skip_response=Server' {
   HIER_LEVEL=2
   SKIP=ENABLE
   SKIP_MODE="0:1:0"
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:all,id:78,skip:enable
@test '[MOM078]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=2, skip_response=Tier' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:0:0"
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:all,id:79,skip:enable
@test '[MOM079]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=2, skip_response=Server' {
   skip "Unsupported"
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="0:1:0"
   FILTER=all
   get_metric_detail
VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:all,id:80,skip:enable
@test '[MOM080]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=2, skip_response=Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="0:0:1"
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:all,id:81,skip:enable
@test '[MOM081]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=2, skip_response=Tier,Server' {
  HIER_LEVEL=3
   SKIP=ENABLE
SKIP_MODE="1:1:0"
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:all,id:82,skip:enable
@test '[MOM082]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=2, skip_response=Tier,Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:0:1"
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:all,id:83,skip:enable
@test '[MOM083]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=2, skip_response=Tier,Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="0:1:1"
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}
#bats test_tags=op:mom,level:3,version:2,filter:all,id:84,skip:enable
@test '[MOM084]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=All, Version=2, skip_response=Tier,Server,Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:0:1"
   FILTER=all
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}





#bats test_tags=op:mom,level:2,version:2,filter:pattern,id:85,skip:enable
@test '[MOM085]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=pattern, Version=2, skip_response=Tier' {
   HIER_LEVEL=2
   SKIP=ENABLE
   SKIP_MODE="1:0:0"
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:2,filter:pattern,id:86,skip:enable
@test '[MOM086]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=pattern, Version=2, skip_response=Server' {
   HIER_LEVEL=2
   SKIP=ENABLE
   SKIP_MODE="0:1:0"
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:pattern,id:87,skip:enable
@test '[MOM087]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=pattern, Version=2, skip_response=Tier' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:0:0"
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:pattern,id:88,skip:enable
@test '[MOM088]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=pattern, Version=2, skip_response=Server' {
   skip "Unsupported"
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="0:1:0"
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:pattern,id:89,skip:enable
@test '[MOM089]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=pattern, Version=2, skip_response=Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="0:0:1"
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:pattern,id:90,skip:enable
@test '[MOM090]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=pattern, Version=2, skip_response=Tier,Server' {
  HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:1:0"
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:pattern,id:91,skip:enable
@test '[MOM091]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=pattern, Version=2, skip_response=Tier,Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:0:1"
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2,filter:pattern,id:92,skip:enable
@test '[MOM092]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=pattern, Version=2, skip_response=Tier,Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="0:1:1"
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}
#bats test_tags=op:mom,level:3,version:2,filter:pattern,id:93,skip:enable
@test '[MOM093]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=pattern, Version=2, skip_response=Tier,Server,Instance' {
   HIER_LEVEL=3
   SKIP=ENABLE
   SKIP_MODE="1:0:1"
   FILTER=pattern
   get_metric_detail
   VERSION=2
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}






#--------------------------------Metadata open merge dervied cases-------------------------------------------------
#bats test_tags=op:mom,level:1,version:2, filter:exact,id:94,type:derived
@test '[MOM094]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=pattern, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=1
    FILTER=exact
    TYPE=Derived
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:2, filter:exact,id:95,type:derived
@test '[MOM095]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=pattern, Version=2, Type=Derived' {
    HIER_LEVEL=2
    FILTER=exact
    TYPE=Derived
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2, filter:exact,id:96,type:derived
@test '[MOM096]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=pattern, Version=2, Type=Derived' {
    HIER_LEVEL=3
    FILTER=exact
    TYPE=Derived
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}


#bats test_tags=op:mom,level:1,version:2, filter:all,id:97,type:derived
@test '[MOM097]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=all, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=1
    FILTER=all
    TYPE=Derived
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:2, filter:all,id:98,type:derived
@test '[MOM098]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=all, Version=2, Type=Derived' {
    HIER_LEVEL=2
    FILTER=all
    TYPE=Derived
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2, filter:all,id:99,type:derived
@test '[MOM099]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=all, Version=2, Type=Derived' {
    HIER_LEVEL=3
    FILTER=all
    TYPE=Derived
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:1,version:2, filter:pattern,id:100,type:derived
@test '[MOM100]Hierarchy=tier, OP=Advance open/merge, SUB_MODE=pattern, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=1
    FILTER=pattern
    TYPE=Derived
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:2,version:2, filter:pattern,id:101,type:derived
@test '[MOM101]Hierarchy=tier>server, OP=Advance open/merge, SUB_MODE=pattern, Version=2, Type=Derived' {
    HIER_LEVEL=2
    FILTER=pattern
    TYPE=Derived
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:3,version:2, filter:pattern,id:102,type:derived
@test '[MOM102]Hierarchy=tier>server>instance, OP=Advance open/merge, SUB_MODE=pattern, Version=2, Type=Derived' {
    HIER_LEVEL=3
    FILTER=pattern
    TYPE=Derived
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:4,version:2, filter:exact,id:103,type:derived
@test '[MOM103]Hierarchy=tier>server>instance>bt, OP=Advance open/merge, SUB_MODE=exact, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=4
    FILTER=exact
    TYPE=Derived_BT
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}


#bats test_tags=op:mom,level:4,version:2, filter:exact,id:104,type:derived
@test '[MOM104]Hierarchy=tier>server>instance>bt, OP=Advance open/merge, SUB_MODE=exact, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=4
    FILTER=exact
    TYPE=Derived_TSI
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}


#bats test_tags=op:mom,level:3,version:2, filter:exact,id:105,type:derived
@test '[MOM105]Hierarchy=tier>server>instance>bt, OP=Advance open/merge, SUB_MODE=exact, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=4
    FILTER=exact
    TYPE=Derived_T
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:4,version:2, filter:all,id:106,type:derived
@test '[MOM106]Hierarchy=tier>server>instance>bt, OP=Advance open/merge, SUB_MODE=all, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=4
    FILTER=all
    TYPE=Derived_BT
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}


#bats test_tags=op:mom,level:4,version:2, filter:all,id:107,type:derived
@test '[MOM107]Hierarchy=tier>server>instance>bt, OP=Advance open/merge, SUB_MODE=all, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=4
    FILTER=all
    TYPE=Derived_TSI
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}


#bats test_tags=op:mom,level:4,version:2, filter:all,id:108,type:derived
@test '[MOM108]Hierarchy=tier>server>instance>bt, OP=Advance open/merge, SUB_MODE=all, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=4
    FILTER=all
    TYPE=Derived_T
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}

#bats test_tags=op:mom,level:4,version:2, filter:pattern,id:109,type:derived
@test '[MOM109]Hierarchy=tier>server>instance>bt, OP=Advance open/merge, SUB_MODE=pattern, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=4
    FILTER=pattern
    TYPE=Derived_BT
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}


#bats test_tags=op:mom,level:4,version:2, filter:pattern,id:110,type:derived
@test '[MOM110]Hierarchy=tier>server>instance>bt, OP=Advance open/merge, SUB_MODE=pattern, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=4
    FILTER=pattern
    TYPE=Derived_TSI
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}


#bats test_tags=op:mom,level:4,version:2, filter:pattern,id:111,type:derived
@test '[MOM111]Hierarchy=tier>server>instance>bt, OP=Advance open/merge, SUB_MODE=pattern, Version=2, Type=Derived' {
    skip "Unsupported"
    HIER_LEVEL=4
    FILTER=pattern
    TYPE=Derived_T
    get_metric_detail
    VERSION=2
    COMMON_TEST_OUTPUT
    output=$(validate_output)
    assert_output "PASS"
}




#---------------------------------Metadata Open Related, Exact Cases Without Tag ---------------------------

#bats test_tags=op:mor,level:1,version:1,filter:exact,id:112,type:derived
@test '[MOR112]Hierarchy=tier, OP=Open related metrics, SUB_MODE=Exact, Version=1, Type=Derived' {
   HIER_LEVEL=1
   export OP=MOR
   FILTER=exact
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:2,filter:exact,id:113,type:derived
@test '[MOR113]Hierarchy=tier>server, OP=Open related metrics, SUB_MODE=Exact, Type=Derived' {
   HIER_LEVEL=2
   OP=MOR
   FILTER=exact
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:3,filter:exact,id:114,type:derived
@test '[MOR114]Hierarchy=tier>server>instance, OP=Open related metrics, SUB_MODE=Exact, Type=Derived' {
   HIER_LEVEL=3
   OP=MOR
   FILTER=exact
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}





#-------------------------------- Metadata open related, All Cases Without Tag--------------------------------------------------

#bats test_tags=op:mor,level:1,version:1,filter:all,id:115,type:derived
@test '[MOR115]Hierarchy=tier, OP=Open related metrics, SUB_MODE=ALL, Type=Derived' {
   HIER_LEVEL=1
   export OP=MOR
   FILTER=ALL
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:2,filter:all,id:116,type:derived
@test '[MOR116]Hierarchy=tier>server, OP=Open related metrics, SUB_MODE=ALL, Type=Derived' {
   HIER_LEVEL=2
   OP=MOR
   FILTER=all
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:3,filter:all,id:117,type:derived
@test '[MOR117]Hierarchy=tier>server>instance, OP=Open related metrics, SUB_MODE=all, Type=Derived' {
   HIER_LEVEL=3
   OP=MOR
   FILTER=all
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}






#-------------------------- Metadata open related, Pattern Cases without tags--------------------------------------

#bats test_tags=op:mor,level:1,filter:pattern,id:118,type:derived
@test '[MOR118]Hierarchy=tier, OP=Open related metrics, SUB_MODE=Pattern, Type=Derived' {
   HIER_LEVEL=1
   export OP=MOR
   FILTER=pattern
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:2,filter:pattern,id:119,type:derived
@test '[MOR119]Hierarchy=tier>server, OP=Open related metrics, SUB_MODE=pattern, Type=Derived' {
   HIER_LEVEL=2
   OP=MOR
   FILTER=pattern
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mor,level:3,filter:pattern,id:120,type:derived
@test '[MOR120]Hierarchy=tier>server>instance, OP=Open related metrics, SUB_MODE=Pattern, Type=Derived' {
   HIER_LEVEL=3
   OP=MOR
   FILTER=pattern
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}



#------------------------------ Metadata Pattern Matching, Exact Cases without tag-----------------------------------

#bats test_tags=op:mpm,level:2,filter:exact,id:121,type:derived
@test '[MPM121]Hierarchy=tier>server, OP=Pattern Matching, SUB_MODE=Exact, Type=Derived' {
   HIER_LEVEL=2
   OP=MPM
   FILTER=exact
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mpm,level:3,filter:exact,id:122,type:derived
@test '[MPM122]Hierarchy=tier>server>instance, OP=Pattern Matching, SUB_MODE=Exact, Type=Derived' {
   HIER_LEVEL=3
   OP=MPM
   FILTER=exact
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}






#-------------------------------- Metadata pattern matching, All Cases without tag------------------------------------------------

#bats test_tags=op:mpm,level:2,filter:all,id:123,type:derived
@test '[MPM123]Hierarchy=tier>server, OP=Pattern Matching, SUB_MODE=ALL, Type=Derived' {
   HIER_LEVEL=2
   OP=MPM
   FILTER=all
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mpm,level:3,filter:all,id:124,type:derived
@test '[MPM124]Hierarchy=tier>server>instance, OP=Pattern matching, SUB_MODE=all, Type=Derived' {
   HIER_LEVEL=3
   OP=MPM
   FILTER=all
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}





#-------------------------------- Metadata Pattern Matching, pattern Cases without tag-----------------------------------

#bats test_tags=op:mpm,level:2,filter:pattern,id:125,type:derived
@test '[MPM125]Hierarchy=tier>server, OP=Pattern Matching, SUB_MODE=pattern, Type=Derived' {
   HIER_LEVEL=2
   OP=MPM
   FILTER=pattern
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}

#bats test_tags=op:mpm,level:3,filter:pattern,id:126,type:derived
@test '[MPM126]Hierarchy=tier>server>instance, OP=Pattern Matching, SUB_MODE=Pattern, Type=Derived' {
   HIER_LEVEL=3
   OP=MPM
   FILTER=pattern
   TYPE=Derived
   get_metric_detail
   VERSION=1
   COMMON_TEST_OUTPUT
   output=$(validate_output)
   assert_output "PASS"
}



