import os
import json
import requests
import urllib3
import hierarchy_lib as hl

rep_file = os.environ['RESPONSE_FILE']
log_file = os.environ['LOG_FILE']
sub_lvl = int(os.environ['SUB_LVL'])
sub_mode = os.environ['SUB_MODE']

def create_payload():
    tsdb_stime = os.environ['STIME']
    tsdb_etime = os.environ['ETIME']
    preset = os.environ['PRESET']
    tr_num = str(os.environ['TESTIDX'])
    level = os.environ['EXPAND_LEVEL']
    duration = { "st":tsdb_stime, "et":tsdb_etime, "preset":preset, "viewBy":0 }
    if sub_lvl == 0:
        body = { "opType":9, "tr":tr_num, "clientId":"Default", "appId":"Default", "duration":duration, "levels":level }
    elif sub_lvl > 0:
        subject = hl.get_tags(sub_lvl)
        body = { "opType":9, "tr":tr_num, "clientId":"Default", "appId":"Default", "duration":duration, "levels":level, "subject":{ "tags":subject } }
    payload = json.dumps(body)
    hl.log("Request payload :- \n {} \n".format(payload))
    return payload

def send_request(payload):
    token = os.environ['TOKEN']
    host = os.environ['IP_PORT']
    url = "https://"+host+"/DashboardServer/v2/web/metrictree/hierarchical?cavToken="+token
    hl.log("URL : [ {} ] \n".format(url))
    headers = {'Content-Type': 'application/json'}
    rep = requests.request("post", url, headers=headers, data=payload, verify=False)
    return rep

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
payload = create_payload()
response = send_request(payload)
if response.status_code == 200:
    content = json.dumps(response.json(), indent=4)
    with open(rep_file,'w') as writer:
        writer.write(content)
