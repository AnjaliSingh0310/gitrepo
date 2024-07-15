#!/bin/bash

#
#./regression_automation.sh <testsuite name> <build> <version>
#

SCENARIO_FILE=""
TRNUM=0
CMT_TEST=0

#test suite idx
TS_NAME=""
BUILD=""
VERSION=""

#check the args
#if Build is given then version must be there
while getopts t:B:V: a
do
  case $a in
    t) TS_NAME="$OPTARG";;
    B) BUILD="$OPTARG";;
    V) VERSION="$OPTARG";;
  esac
done

#For Checking status of CMT
echo "[*] Checking for running cmt"
IFS='' read -a TRS <<< "$(nsu_show_netstorm | awk '{print $1}' | grep -v 'TestRun' | xargs)"
running_tr_count=${#TRS[@]}

#get the cmt test run no.
TRNUM=`grep '^nde.testRunNum=' $NS_WDIR/webapps/sys/config.ini | cut -d'=' -f2`

uprgrade_build()
{
  cur_path=`pwd`
  cd $NS_WDIR/upgrade

  # Thirdparty download
  while true; do
    output=$(wget -S --spider "$url$file1" 2>&1)

    if [[ $output =~ "200 OK" ]]; then
      echo "File $file1 found and available."
      echo "Downloading $file1..."
      wget "$url$file1"
      # Thirdparty Install
      chmod +x $file1
      output=$(./$file1)
      echo "$output"
      if [[ ! $output =~ "Thirdparty build upgraded successfully" ]]; then
          rm -rf $url$file1
          sleep 3600
          continue
      fi
      break
    elif [[ $output =~ "404 Not Found" ]]; then
      echo "File $file1 not found yet on buildhub or download failed." #" Error message: $output"
      sleep 7200
    else
      echo "File $file1 availability unknown. Retrying in 3600 seconds..."
      sleep 3600
    fi
  done

  # Netstorm download
  while true; do
    output=$(wget -S --spider "$url$file2" 2>&1)

    if [[ $output =~ "200 OK" ]]; then
      echo "File $file2 found and available."
      echo "Downloading $file2..."
      wget "$url$file2"
      # Netstom Install
      chmod +x $file2
      output=$(./$file2)
      echo "$output"
       if [[ ! $output =~ "Upgradation completed" ]]; then
          rm -rf $url$file2
          sleep 3600
          continue
      fi
      break
    elif [[ $output =~ "404 Not Found" ]]; then
      echo "File $file2 not found yet on buildhub or download failed." #" Error message: $output"
      sleep 3600
    else
      echo "File $file2 availability unknown. Retrying in 3600 seconds..."
      sleep 3600
    fi
  done

  cd $cur_path
}

if [ "X$BUILD" != "X" ] && [ "X$VERSION" != "X" ]; then
  url="http://10.10.30.16:8992/U20/4.$VERSION.0/"
  file1="thirdparty.4.$VERSION.0."$BUILD"_Ubuntu2004_64.bin"
  file2="netstorm_all.4.$VERSION.0."$BUILD"_Ubuntu2004_64.bin"

  if [ ${running_tr_count} -gt 0 ];then
    echo "[*] Stopping running tests"
    for ((i=0;i<running_tr_count;i++))
    do
        nsu_stop_test -f ${TRS[i]}
    done
  fi

  # Stop nsu_check_cont_test process
  ps -ef | grep nsu_check_cont | grep test | cut -d " " -f2 | xargs -I {} kill -9 {}

  # Change TR number
  echo "[*] Changing TR Number"
  TRNUM=$((TRNUM + 1))
  sed -i "/^nde.testRunNum=/d" $NS_WDIR/webapps/sys/config.ini
  echo "nde.testRunNum=$TRNUM" >>$NS_WDIR/webapps/sys/config.ini
  echo "New TestRunNumber = $(grep "^nde.testRunNum" $NS_WDIR/webapps/sys/config.ini | cut -d'=' -f2 | xargs)"
  uprgrade_build
fi

#echo "[*] Restarting NDC"
#/etc/init.d/ndc restart

check_for_scenario()
{
  if [ ! -z $NS_WDIR/logs/TR$TRNUM/summary.top ]; then
    SCENARIO_FILE=`cut -d "|" -f2 $NS_WDIR/logs/TR$TRNUM/summary.top`
    if [ "X$SCENARIO_FILE" == "X" ]; then
      SCENARIO_FILE=default/default/nde
    fi
  fi
}

if [ ${running_tr_count} -eq 0 ];then
  if [ "X$TRNUM" != "X" ];then
    CMT_TEST=1;
    check_for_scenario
  else
    echo "[*] Going to run a NS Test, as cmt tr no. is not mentioned"
  fi

  if [ $CMT_TEST -eq 1 ]; then
    echo "[*] Starting CMT"
    output=`nsu_start_test -n $SCENARIO_FILE -S gui -u cavisson -r admin`
  else
    output=`nsu_start_test -n $SCENARIO_FILE -S gui`
  fi

  echo $output
  if [[ $output=="Netstorm started successfully. TestRunNumber is" ]]; then
    echo "[*] Test started successfully"
  else
    echo -e "[*] Test not started. Erorr $output \n Exiting..."
    exit 1
  fi
  sleep 60
else
  TRNUM=`nsu_show_netstorm | grep -v "TestRun" |cut -d " " -f1| head -1`
fi

# start CMT

echo "[*] Stopping the ingestion tool for this tr $TRNUM"
$NS_WDIR/TSDB/tsdb/automation/tsdb_ingestion/tsdb_ingestion_ctrl -o stop -t $TRNUM
sleep 60
# Start Ingestion
echo "[*] Starting Ingestion"
output=$($NS_WDIR/TSDB/tsdb/automation/tsdb_ingestion/tsdb_ingestion_ctrl -o start -f $NS_WDIR/TSDB/tsdb/automation/tsdb_ingestion/tsdb_ingestion_test.conf -t $TRNUM)
echo "$output"

expected_output="response from test - response: register started successfully for profile - $NS_WDIR/TSDB/tsdb/automation/tsdb_ingestion/tsdb_ingestion_test.conf"

if [[ "$output" == "$expected_output" ]]; then
  echo "[*] Ingestion started successfully"
else
  echo "[*] Ingestion not started. Retrying once..."

  # Retry the ingestion process
  output=$($NS_WDIR/TSDB/tsdb/automation/tsdb_ingestion/tsdb_ingestion_ctrl -o start -f $NS_WDIR/TSDB/tsdb/automation/tsdb_ingestion/tsdb_ingestion_test.conf -t $TRNUM)

  if [[ "$output" == "$expected_output" ]]; then
    echo "[*] Ingestion started successfully on retry"
  else
    echo "[*] Ingestion still not started. Exiting..."
    exit 1
  fi
fi

#for dump CurTime and FileTimeStamp in FileTimestamp_vs_CurTime.txt file
#./FileTimestamp_vs_CurTime.sh &
#echo "[*] CurTime and FileTimeStamp dumped in FileTimestamp_vs_CurTime.txt file"

PID=`cat $NS_WDIR/logs/TR$TRNUM/.pidfiles/.cav_tsdb.pid`
ELASPED_TS=`ps -o etimes= -p $PID`
if [ "$ELASPED_TS" -lt 600 ]; then
  echo "[*] Sleep for 10 mins after that going for run automation"
  sleep 600
fi

# Regression Automation
echo "[*] Run regression automation"
cd "$NS_WDIR/TSDB/tsdb/automation/"

bash cleanup.sh
bash setup.sh

#for generate online.bats file
./generate_GDF_conf
bash testsuites/noc_datacall

#for generate group_and_graph_call.bats file in 4.13.0 and In case of 4.11.0 going for remove old 4.13.0 generated file 
build_n=$(nsu_get_version -n |cut -d "." -f2)
if [ $build_n == 13 ]; then
  bash generate_mgroup $TRNUM
  ./trigger $TS_NAME
else
  `mv $NS_WDIR/TSDB/tsdb/automation/testsuites/group_and_graph_call.bats $NS_WDIR/TSDB/tsdb/automation/testsuites/group_and_graph_call.bats_bkp`
  ./trigger $TS_NAME
  `mv $NS_WDIR/TSDB/tsdb/automation/testsuites/group_and_graph_call.bats_bkp $NS_WDIR/TSDB/tsdb/automation/testsuites/group_and_graph_call.bats`
fi

if [ "$TS_NAME" != "" ]; then
  echo "Given test suite $TS_NAME is run"
else
  echo "All test cases are run"
fi

#echo "[*] Now Sending regression automation report through mail"
#if [[ $output="All test cases are run" ]]; then
#  cd "$NS_WDIR/TSDB/tsdb/automation/"
#  python3 lib/sendmail.py
#  echo "[*] Report sent successfully , Check mail"
#fi
#

echo "[*] Now going to run tsdb-validation script"
CUR_PATH=`pwd`
cd $NS_WDIR/tsdb-validator
bash ./validation.sh $TRNUM
cd $CUR_PATH
