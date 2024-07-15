import utilities as utils
import json
import os

token = os.environ['TOKEN']
rep_file = os.environ['RESPONSE_FILE']
level = int(os.environ['HI_LEVEL'])
url = "https://"+os.environ['IP_PORT']+"/DashboardServer/v2/web/metrictree/tree?cavToken="+token
if level == 1:
    node_id = utils.get_tier_id()
    payload = utils.create_payload(node_id,level+1)
    response = utils.send_post_request(url,payload)
if level == 2:
    node_id = utils.get_server_id()
    payload = utils.create_payload(node_id,level+1)
    response = utils.send_post_request(url,payload)
utils.log("URL :-\n"+url+"\n")
utils.log("Request payload :-\n"+payload+"\n")
content = json.dumps(response.json(), indent=4)
utils.write_response(content)

if level == 1:
    utils.write_servers_info(rep_file)
if level == 2:
    utils.write_instances_info(rep_file)
