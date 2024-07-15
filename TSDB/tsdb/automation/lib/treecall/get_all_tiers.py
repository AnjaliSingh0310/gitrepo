import requests
import json
import os

token = os.environ['TOKEN']
global_tree_file = os.environ['INIT_TREE']
tier_info = os.environ['TREECALL_TEMP']+"/tier_info.txt"
rep_file = os.environ['RESPONSE_FILE']
log_file = os.environ['LOG_FILE']
url = "https://"+os.environ['IP_PORT']+"/DashboardServer/v2/web/metrictree/tree?cavToken="+token

def write_file(target_file,operation,msg):
    with open(target_file,operation) as writer:
        writer.write(msg)

with open(global_tree_file,"r") as local_tree:
    local = json.load(local_tree)
    
node = local['tree'][0]['id']

json_payload = {"clientId":"Default" , "appId":"Default" , "opType":2}
json_payload['tr'] = os.environ['TESTIDX']
duration = {"viewBy":0}
duration['st'] = os.environ['STIME']
duration['et'] = os.environ['ETIME']
duration['preset'] = os.environ['PRESET']

json_payload['duration'] = duration
json_payload['id'] = node
json_payload['expandLevel'] = 2

headers = {'Content-Type': 'application/json'}
payload = json.dumps(json_payload)

write_file(log_file,"a","URL :-\n " + url + "\n")
write_file(log_file,"a","Request Payload :-\n " + payload + "\n")

response = requests.request("post", url, headers=headers, data=payload, verify=False)
content = json.dumps(response.json(), indent=4)

rep = response.json()
if rep['status']['msg'] == "OK":
    if os.path.exists(tier_info):
        os.remove(tier_info)
    tiers = rep['tree'][0]['children']
    for tier in tiers:
        write_file(tier_info,"a","{}={}\n".format(tier['name'],tier['id']))

write_file(rep_file,"w",content)
