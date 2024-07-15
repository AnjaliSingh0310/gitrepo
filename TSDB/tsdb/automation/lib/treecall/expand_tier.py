import utilities as utils
import json
import os
import sys

token = os.environ['TOKEN']
rep_file = os.environ['RESPONSE_FILE']
url = "https://"+os.environ['IP_PORT']+"/DashboardServer/v2/web/metrictree/tree?cavToken="+token

node_id = utils.get_tier_id()

payload = utils.create_payload(node_id,1)
response = utils.send_post_request(url,payload)

content = json.dumps(response.json(), indent=4)
utils.write_response(content)
