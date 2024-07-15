[-] [-------------How to run noc_datacall-------------------------]
## (Files which are required to run datatcall)
__INSIDE AUTOMATION DIRECTORY__
[-][generate gdf conf] - It will generate GDF.conf file. It internally runs mgn call and takes all gdf id 


[-] [--------------Usage of the files and directory---------------]

## (Inside automation directory)

[-][thirdparty] - It contains all the bats pre-required files.
[-][tsdb_ingestion] - It contains ingestion configuration file and ingestion ctrl
[-][lib] - It conatins all the library file which is required for running automation
[-][testsuites] - It contains all the bats scripts which is required for running automation scripts.
[-][setup.sh] - It will create logs and response directory
[-][ingestion.sh] - It is used for start, stop and check status of ingestion ctrl
[-][trigger] - It is used to run the automation script 
[-][cleanup.sh] - It will remove all the logs , temporary file

[-][---------Steps to run this automation file-----------]__
1. First Run (bash setup.sh) in tsdb/automation directory ( It will create all the required logs file and response file ).
2. Then, run (bash trigger) command and choose the scripts you want to run.
3. Or use (./bats testsuites/filename.bats) to run individual file.
4. After running all the test scripts, run (bash cleanup.sh) to remove all the log and temporary file.


