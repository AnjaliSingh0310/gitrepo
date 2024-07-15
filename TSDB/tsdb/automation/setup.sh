LOG_DIR="logs"
TMP_DIR=".tmp"
RESPONSE_DIR="responses"
TESTSUITES=("datacall" "metadata" "treecall" "hierarchy" "derived" "redo" "Metricconf" "datacall_tags" "alert" "group_graph" "tags" "percentile" "nonbusiness" "online" "ingestion")
OUT_FILE="alert_responses"
VAL_FILE="validation_responses"

mkdir $OUT_FILE
mkdir $VAL_FILE
mkdir $LOG_DIR
for item in ${TESTSUITES[@]}
do
   mkdir -p $TMP_DIR/$item
done
for item in ${TESTSUITES[@]}
do
   mkdir -p $RESPONSE_DIR/$item
done
