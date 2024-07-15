import subprocess
import time
import requests
import pytest
import enum
import json
import os
import Port
import setup

from pathlib import Path


class AlertReason(enum.Enum): 
    NEW=1
    CONTINUOUS=2
    UPGRADE=3
    DOWNGRADE=4
    END=5

    def __str__(self) -> str:
        return self.name

class AlertSeverity(enum.Enum):
    NORMAL=0
    MINOR=1
    MAJOR=2
    CRITICAL=3

    def __str__(self) -> str:
        return self.name

ALERT_STATE_SUCCESS=0
ALERT_STATE_FAILED=-1
ALERT_STATE_UNKNOWN=-2

TESTSUITE_TIMEOUT=1800

EXP_FIELD_TYPE=0
EXP_FIELD_REASON=1
EXP_FIELD_SEVERITY=2
EXP_FIELD_THRESHOLD=3
EXP_FIELD_ALERT_VALUE=4

ALERT_PORT='-1'

parsed_dict=setup.parse_csv_to_dict("fc_rules.csv")

tr_num=-1
rulesMap={} # ruleid will be it's key. 
TSDB_DIR=""

class AlertData:
    def __init__(self, data, ruleid) -> None:
        self.data=data 
        self.lmt=0
        self.expidx=0
        self.status=ALERT_STATE_UNKNOWN
        self.error=''
        self.ruleid=ruleid
        self.linesDone=0
        self.exps=json.loads(data['Expectation'])


def generateReport():
    # It will generate a python file and will dump some dummy test cases into that. 
    filename=f'alert_validation_{os.getpid()}.py'

    with open(filename, 'w') as outfp:
        outfp.write("import pytest")
        for ruleid in rulesMap:
            ruleObj=rulesMap[ruleid]

            error="Success"
            if ruleObj.status == ALERT_STATE_UNKNOWN:
                error=f"Failed to validate within timeout {TESTSUITE_TIMEOUT}"
            elif ruleObj.status == ALERT_STATE_FAILED:
                error=ruleObj.error

            if error == "Success":
               tc=f"""

def test_{ruleObj.data["Rule Name"]}():
  assert 1, "{error}"

"""
            else:
                tc=f"""

def test_{ruleObj.data["Rule Name"]}():
    assert 0, "{error}"
"""
                   
            outfp.write(tc)

        outfp.close()

    process = subprocess.run(["python3", "-m", "pytest", filename, "--html=report.html"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    print('Testsuite report is generated')

    os.remove(filename)


#test for run all the confugrations
def test_setup(capfd):
    print('setting up test suites')
    global tr_num, parsed_dict, ALERT_PORT, TSDB_DIR

    # Get the port number from the file
    ALERT_PORT = Port.get_port_from_file()

    #parse the csv file to get test case
    #parsed_dict = setup.parse_csv_to_dict("th_rules.csv")

    #get tr number
    tr_num = setup.get_test_number().strip()

    #run ingestion
    ingestion = setup.run_ingestion(parsed_dict)
    assert ingestion == 1, "Failed to start ingestion"
    time.sleep(300)
    print("Ingestion started")
    TSDB_DIR=f'{os.getenv("NS_WDIR")}/logs/TR{tr_num}/tsdb/'
    print(f'tr_num={tr_num}, Alert port={ALERT_PORT}, TSDB_DIR={TSDB_DIR}, Total rules={len(parsed_dict)}')

i = 0
#test for the add rules
@pytest.mark.parametrize(
        "rule_dict",
        parsed_dict,
        ids=[str(rule) for rule in parsed_dict],
)
def test_parameterized_condition_values(rule_dict, capfd):
    #global i 
    #if i >=1:
    #   pytest.skip("Limit reached!")
    #i += 1

    json_file_path = ""

    #Parse the rule_dict 
    cond_obj = json.loads(rule_dict['Condition Type'])
    sev_obj = json.loads(rule_dict['Sev']);
    win_obj = json.loads(rule_dict['Window Type'])
    subMode_obj = json.loads(rule_dict['Subject Mode'])
    measure_obj = json.loads(rule_dict['Measure'])
    subject_obj = json.loads(rule_dict['Subject'])

    # threshold = 0 and change = 1
    if cond_obj[0][0] == "0":
        json_file_path = "/home/cavisson/work/TSDB/tsdb/automation/testsuites/alerts/alert_th_add.json"
    elif cond_obj[0][0] == "1":
        json_file_path = "/home/cavisson/work/TSDB/tsdb/automation/testsuites/alerts/alert_ch_add.json"
    elif cond_obj[0][0] == "2":
        json_file_path = "/home/cavisson/work/TSDB/tsdb/automation/testsuites/alerts/alert_an_json.json"
    elif cond_obj[0][0] == "3":
        json_file_path = "/home/cavisson/work/TSDB/tsdb/automation/testsuites/alerts/alert_ol_json.json"
    elif cond_obj[0][0] == "4":
        json_file_path = "/home/cavisson/work/TSDB/tsdb/automation/testsuites/alerts/alert_fc_json.json"
   
    with open(json_file_path, "r+") as f:
        data = json.load(f)

    data["rules"][0]["name"] = rule_dict['Rule Name']
    
    if cond_obj[0][0] == "0":
        data["rules"][0]["attributes"]["severity"][0]["id"] = sev_obj[0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["type"] = cond_obj[0][0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["thresholdType"]["dataType"] = cond_obj[0][2]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["thresholdType"]["operator"] = cond_obj[0][3]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["thresholdType"]["windowType"] = win_obj[0][0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["thresholdType"]["fThreshold"] = cond_obj[0][4]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["thresholdType"]["timeWindow"] = cond_obj[0][5]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["thresholdType"]["pctType"] = cond_obj[0][6]

        if (len(sev_obj) > 1):
            for s in range(0, len(sev_obj) - 1):
                p_sev = data["rules"][0]["attributes"]["severity"]
                #print(s)
                new_tag = {};
                new_tag = {
                    "id": sev_obj[s + 1],
                    "condition": "C1",
                    "conditionList": [
                        {
                            "type": cond_obj[s + 1][0],
                            "mName": cond_obj[s + 1][1],
                            "grpAffLevel": 0,
                            "gAffLevfTh": -1,
                            "gAffLevrTh": -1,
                            "thresholdType": {
                                "dataType": cond_obj[s + 1][2],
                                "operator": cond_obj[s + 1][3],
                                "windowType": win_obj[0],
                                "fThreshold": cond_obj[s + 1][4],
                                "sThreshold": -1,
                                "frThreshold": -1,
                                "srThreshold": -1,
                                "pctType": cond_obj[s + 1][6],
                                "pct": 100,
                                "timeWindow": cond_obj[s + 1][5],
                                "twUnit": 0
                            },
                            "id": 0,
                            "name": "C1"
                        }
                    ]
                }
                p_sev.append(new_tag)
                
    elif cond_obj[0][0] == "1":
        data["rules"][0]["attributes"]["severity"][0]["id"] = sev_obj[0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["type"] = cond_obj[0][0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["changeType"]["dataType"] = cond_obj[0][2]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["changeType"]["operator"] = cond_obj[0][3]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["changeType"]["windowType"] = win_obj[0][0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["changeType"]["fThreshold"] = cond_obj[0][4]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["changeType"]["timeWindow"] = cond_obj[0][5]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["changeType"]["pastWindow"] = cond_obj[0][6]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["changeType"]["pctType"] = cond_obj[0][7]

        if (len(sev_obj) > 1):
            for s in range(0, len(sev_obj) - 1):
                p_sev = data["rules"][0]["attributes"]["severity"]
                #print(s)
                new_tag = {};
                new_tag = {
                    "id": sev_obj[s + 1],
                    "condition": "C1",
                    "conditionList": [
                        {
                            "type": cond_obj[s + 1][0],
                            "mName": cond_obj[s + 1][1],
                            "grpAffLevel": 0,
                            "gAffLevfTh": -1,
                            "gAffLevrTh": -1,
                            "changeType": {
                                "dataType": cond_obj[s + 1][2],
                                "operator": cond_obj[s + 1][3],
                                "windowType": win_obj[0],
                                "fThreshold": cond_obj[s + 1][4],
                                "sThreshold": -1,
                                "frThreshold": -1,
                                "srThreshold": -1,
                                "pctType": cond_obj[s + 1][7],
                                "pct": 100,
                                "timeWindow": cond_obj[s + 1][5],
                                "twUnit": 0,
                                "pastWindow": cond_obj[s + 1][6],
                                "pwUnit": 0
                            },
                            "id": 0,
                            "name": "C1"
                        }
                    ]
                }
                p_sev.append(new_tag)
    
    elif cond_obj[0][0] == "2":
        data["rules"][0]["attributes"]["severity"][0]["id"] = sev_obj[0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["anomalyType"]["dataType"] = cond_obj[0][1]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["anomalyType"]["operator"] = cond_obj[0][2]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["anomalyType"]["windowType"] = win_obj[0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["anomalyType"]["algoType"] = cond_obj[0][3]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["anomalyType"]["timeWindow"] = cond_obj[0][4]
        data['rules'][0]['attributes']["severity"][0]["conditionList"][0]["anomalyType"]["deviation"] = cond_obj[0][5]
        data['rules'][0]['attributes']["severity"][0]["conditionList"][0]["anomalyType"]["pctType"] = cond_obj[0][6]
        data['rules'][0]['attributes']["severity"][0]["conditionList"][0]["anomalyType"]["pct"] = cond_obj[0][7]

    elif cond_obj[0][0] == "3":
        data["rules"][0]["attributes"]["severity"][0]["id"] = sev_obj[0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["outliersType"]["dataType"] = cond_obj[0][1]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["outliersType"]["pct"] = cond_obj[0][2]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["outliersType"]["algoType"] = cond_obj[0][3]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["outliersType"]["timeWindow"] = cond_obj[0][4]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["outliersType"]["tolerance"] =  cond_obj[0][5]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["outliersType"]["pctType"] = cond_obj[0][6]

    elif cond_obj[0][0] == "4":
        data["rules"][0]["attributes"]["severity"][0]["id"] = sev_obj[0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["dataType"] = cond_obj[0][1]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["operator"] = cond_obj[0][2]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["fThreshold"] = cond_obj[0][3]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["forecastModel"] = cond_obj[0][4]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["forecastType"] = cond_obj[0][5]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["windowType"] = win_obj[0]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["timeWindow"] = cond_obj[0][6]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["pctType"] = cond_obj[0][7]
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["pct"] = cond_obj[0][8]



    #Updating the subject in case of pattern
    if (subMode_obj[0] == "4" and data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["key"] == "Tier"):
        data["rules"][0]["attributes"]["metric"][0]['mode'] = subMode_obj[0]
        data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["mode"] = subMode_obj[0]
        data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["value"] = "*"
        data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][1]["mode"] = subMode_obj[0]
        data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][1]["value"] = "*"
    #in case of specific subject
    elif (subMode_obj[0] == "1" and data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["key"] == "Tier"):
        data["rules"][0]["attributes"]["metric"][0]['mode'] = subMode_obj[0]
        data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["mode"] = subMode_obj[0]
        data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["value"] = subject_obj[0]
        data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][1]["mode"] = subMode_obj[0]
        data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][1]["value"] = subject_obj[1]
   
    #Updating the metric 
    data["rules"][0]["attributes"]["metric"][0]['measure']["metric"] = measure_obj[0]
    data["rules"][0]["attributes"]["metric"][0]['measure']["metricId"] = measure_obj[1]
    data["rules"][0]["attributes"]["metric"][0]['measure']["mg"] = measure_obj[2]
    data["rules"][0]["attributes"]["metric"][0]['measure']['mgId'] = measure_obj[3]
    data["rules"][0]["attributes"]["metric"][0]['measure']['mgType'] = measure_obj[4]
    
    #print(data)
    url = "http://127.0.0.1:" + ALERT_PORT + "/alert/rule/add"
    headers = {
      "Content-Type": "application/json"
    }
    
    response = requests.request("post", url, json=data, headers=headers, verify=False)
    # Assert the response status code
    assert response.status_code == 200
    response_json = response.json()

    rid = response_json["rules"][0]["id"]
    rulesMap[rid]=AlertData(rule_dict, rid)
    print(f"Added Rule {rule_dict['Rule Name']}  rule_id: {rid}")


#This test case will validate the alerts
def test_parameterized_validation_debug_file(capfd):
    # Putting initial sleep to wait for debug file. 
    elapsed=0
    activeAlertCount=len(rulesMap.keys()) #Number of alerts which are still in process of validation. 
    
    TESTSUITE_TIMEOUT_TEST_COUNTER = 0
    #while(activeAlertCount != 0 and elapsed < TESTSUITE_TIMEOUT): 
    while(elapsed < TESTSUITE_TIMEOUT): 
        time.sleep(10)
        elapsed += 10
        activeAlertCount=0

        for ruleid in rulesMap:
            ruleObj=rulesMap[ruleid]
            if ruleObj.status == ALERT_STATE_UNKNOWN: 
                #Validate. 
                debug_file_path = Path(f"{TSDB_DIR}/alerts/.tmp/debug/rule_{ruleObj.ruleid}.debug")
                if os.path.exists(debug_file_path):
                    if ruleObj.lmt < os.path.getmtime(debug_file_path): 
                        with open(debug_file_path, 'r') as filefp: 
                            t_lines=filefp.readlines()
                            lines=t_lines[ruleObj.linesDone:]
                            for line in lines:
                                line=line.strip()
                                #Currently skipping empty or commented lines. 
                                if not line.startswith('Alert,'): continue

                                #print(f"line {line}")

                                # Sample data. 
                                #Alert,1713407400000,1713407700000,44,1,0,1,C1:29.999 ,Default>Default>Cavisson>CavMaster,30.000000, 30.019000, 149.998000, 5, 5
                                fields=line.split(',')
                                alertValue=float(fields[7].split(':')[1])
                                for expidx in range(ruleObj.expidx, len(ruleObj.exps)):
                                    exp=ruleObj.exps[expidx]
                                    #print(f"ruleid {ruleid}")
                                    if float(exp[EXP_FIELD_ALERT_VALUE]) == -1:
                                        if exp[EXP_FIELD_REASON] == fields[4]:
                                            ruleObj.expidx += 1
                                    elif exp[EXP_FIELD_REASON] == fields[4] and  \
                                            exp[EXP_FIELD_SEVERITY] == fields[6] and \
                                            float(exp[EXP_FIELD_ALERT_VALUE]) <= alertValue:
                                        ruleObj.expidx += 1
                                        #print(f"ruleid {ruleObj.ruleid}, idx {ruleObj.expidx}")
                                        break
                                    else: 
                                        ruleObj.status=ALERT_STATE_FAILED
                                        ruleObj.expidx = len(ruleObj.exps)
                                        ruleObj.error=f'Expected reason={AlertReason(int(exp[EXP_FIELD_REASON]))},severity={AlertSeverity(int(exp[EXP_FIELD_SEVERITY]))},value={exp[EXP_FIELD_ALERT_VALUE]}, Actual reason={AlertReason(int(fields[4]))},severity={AlertSeverity(int(fields[6]))},value={alertValue}'
                                        print(f"Error for rule id {ruleObj.ruleid}: {ruleObj.error} idx {ruleObj.expidx}")
                                        TESTSUITE_TIMEOUT_TEST_COUNTER += 1
                                        break
                                if ruleObj.expidx == len(ruleObj.exps): 
                                    ruleObj.status=ALERT_STATE_SUCCESS
                                    TESTSUITE_TIMEOUT_TEST_COUNTER += 1
                                    break
                            
                            ruleObj.linesDone += len(lines)

                            if ruleObj.status == ALERT_STATE_UNKNOWN: activeAlertCount += 1
                            filefp.close()
        if TESTSUITE_TIMEOUT_TEST_COUNTER == (len(rulesMap)):
            print("All rules are processed, no futher rules for validation")
            break

    # Done 
    if elapsed >= TESTSUITE_TIMEOUT and activeAlertCount != 0: 
        print(f'Error: Failed to validate all the alerts within timeout {TESTSUITE_TIMEOUT}sec')
    else:
        print(f'All test cases are validated, generating report. ')

    generateReport()

