export INGESTION_HOME="${PWD}/tsdb_ingestion"
export TESTIDX=`grep "^nde.testRunNum" $NS_WDIR/webapps/sys/config.ini | cut -d'=' -f2 | xargs`
export ING_CONF_FILE="${INGESTION_HOME}/tsdb_ingestion_test.conf"
export ING_CTRL_BIN="${INGESTION_HOME}/tsdb_ingestion_ctrl"

if [ "$1" == "start" ];then
   $ING_CTRL_BIN -o start -t $TESTIDX -f $ING_CONF_FILE
   echo "$TESTIDX">.tmp/tr_num
elif [ "$1" == "status" ];then
   CURR_TR=`cat .tmp/tr_num`
   $ING_CTRL_BIN -o status -t $CURR_TR  
elif [ "$1" == "stop" ];then
   CURR_TR=`cat .tmp/tr_num`
   $ING_CTRL_BIN -o stop -t $CURR_TR  

else
   echo "Invalid Operation"
   exit 1
fi

exit 0



