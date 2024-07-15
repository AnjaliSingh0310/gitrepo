import requests
import json
import os

token = os.environ['TOKEN']
rep_file = os.environ['INIT_TREE']
log_file = os.environ['LOG_FILE']
url = "https://"+os.environ['IP_PORT']+"/DashboardServer/v2/web/metrictree/tree?cavToken="+token

json_payload = {"clientId":"Default" , "appId":"Default" , "opType":1}
json_payload['tr'] = os.environ['TESTIDX']
duration = {"viewBy":0}
duration['st'] = str(os.environ['STIME'])
duration['et'] = str(os.environ['ETIME'])
duration['preset'] = str(os.environ['PRESET'])
json_payload['duration'] = duration

headers = {'Content-Type': 'application/json'}
payload = json.dumps(json_payload)

response = requests.request("post", url, headers=headers, data=payload, verify=False)

with open(log_file,"a") as writer:
    writer.write("URL :-\n " + url +"\n")
    writer.write("Request Payload :-\n " + payload +"\n")

content = json.dumps(response.json(), indent=4)

with open(rep_file, "w") as writer:
    writer.write(content)
