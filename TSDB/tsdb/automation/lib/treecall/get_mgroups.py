import requests
import json
import os

token = os.environ['TOKEN']
rep_file = os.environ['RESPONSE_FILE']
log_file = os.environ['LOG_FILE']
tier_info = os.environ['TREECALL_TEMP']+"/tier_info.txt"
hi_level = int(os.environ['HI_LEVEL'])
url = "https://"+os.environ['IP_PORT']+"/DashboardServer/v2/web/metrictree/tree?cavToken="+token
node_id = int()
tiers = list()
with open(tier_info,'r') as reader:
     tiers = reader.readlines()
     
for item in tiers:
    if hi_level == 1:
        if item.split('=')[0] == os.environ['TIER']:
            node_id = item.split('=')[1]
            break

json_payload = {"clientId":"Default" , "appId":"Default" , "opType":2}
json_payload['tr'] = os.environ['TESTIDX']
duration = {"viewBy":0}
duration['st'] = os.environ['STIME']
duration['et'] = os.environ['ETIME']
duration['preset'] = os.environ['PRESET']

json_payload['duration'] = duration
json_payload['id'] = node_id
json_payload['expandLevel'] = 2

headers = {'Content-Type': 'application/json'}
payload = json.dumps(json_payload)

fp = open(log_file,"a")
fp.write("Request Payload :-\n " + payload + "\n")
fp.close()

response = requests.request("post", url, headers=headers, data=payload, verify=False)
content = json.dumps(response.json(), indent=4)
fp = open(rep_file, "w")
fp.write(content)
fp.close()
