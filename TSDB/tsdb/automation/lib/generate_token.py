import os
import requests
import json
import base64
import subprocess
  
string = "cavisson:@dmin"
string_bytes = string.encode("ascii")

base64_bytes = base64.b64encode(string_bytes)
base64_string = base64_bytes.decode("ascii")

url = "https://"+os.environ['IP_PORT']+"/DashboardServer/v2/web/common/generateNewToken"
auth_token = "Basic "+base64_string
header = {"Authorization":auth_token}

import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

response = requests.request("get", url, params={"validityPeriod":"00:30:00"}, headers=header, verify=False)

body = response.json()
res_code = body['status']['code']

version = '"' + subprocess.check_output("nsu_get_version | head -1 | cut -d' ' -f2 ", shell=True, text=True).rstrip() + '"' 

if res_code == 200:
    #body = response.json()
    #if version == "4.11.0" :
    if "4.11.0" in version:
        token_val = body['token'] 
    else:
        token_val = body['data'][0]['token']
    print(token_val)
    f_token = open(".token", "w")
    f_token.write(token_val)
    f_token.close()
