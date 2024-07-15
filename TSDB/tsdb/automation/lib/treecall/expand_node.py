import requests
import json
import os

token = os.environ['TOKEN']
rep_file = os.environ['RESPONSE_FILE']
log_file = os.environ['LOG_FILE']
url = "https://"+os.environ['IP_PORT']+"/DashboardServer/v2/web/metrictree/tree?cavToken="+token

json_payload = {"clientId":"Default" , "appId":"Default" , "opType":2}
json_payload['tr'] = os.environ['TESTIDX']
duration = {"viewBy":0}
duration['st'] = os.environ['STIME']
duration['et'] = os.environ['ETIME']
duration['preset'] = os.environ['PRESET']

json_payload['duration'] = duration
json_payload['id'] = os.environ['EXPAND_ID']
json_payload['expandLevel'] = 1

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
