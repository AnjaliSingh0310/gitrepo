import os
import json
import requests

def log(msg):
    log_file = os.environ['LOG_FILE']
    with open(log_file,"a") as writer:
        writer.write(msg+"\n")

def write_file(filename,msg):
    target_file = os.environ['TREECALL_TEMP']+"/"+filename
    with open(target_file,operation) as writer:
        writer.write(msg)

def get_tier_id():
    tier_info = os.environ['TREECALL_TEMP']+"/tier_info.txt"
    tiers = list()
    with open(tier_info,'r') as reader:
        tiers = reader.readlines()
    for item in tiers:
        if item.split('=')[0] == os.environ['TIER']:
            node_id = item.split('=')[1]
            break
    return node_id

def get_server_id():
    server_info = os.environ['TREECALL_TEMP']+"/server_info.txt"
    server = str()
    with open(server_info,'r') as reader:
        server = reader.readline()
    node_id = server.split('|')[1]
    return node_id

def get_instance_id():
    instance_info = os.environ['TREECALL_TEMP']+"/instance_info.txt"
    instance = str()
    with open(instance_info,'r') as reader:
        instance = reader.readline()
    node_id = instance.split('|')[2]
    return node_id

def create_payload(node_id,level):
    duration = {"viewBy":0}
    duration['st'] = os.environ['STIME']
    duration['et'] = os.environ['ETIME']
    duration['preset'] = os.environ['PRESET']
    json_payload = {"clientId":"Default" , "appId":"Default" , "opType":2}
    json_payload['tr'] = os.environ['TESTIDX']
    json_payload['duration'] = duration
    json_payload['id'] = node_id
    json_payload['expandLevel'] = level
    payload = json.dumps(json_payload)
    log("Request Payload :-\n " + payload)
    return payload

def send_post_request(url,payload):
    headers = {'Content-Type': 'application/json'}
    response = requests.request("post", url, headers=headers, data=payload, verify=False)
    return response

def write_response(content):
    rep_file = os.environ['RESPONSE_FILE']
    with open(rep_file,"w") as writer:
        writer.write(content)

def write_servers_info(rep):
    server_info = os.environ['TREECALL_TEMP']+"/server_info.txt"
    with open(rep,'r') as reader:
        json_rep = json.load(reader)
        tree = json_rep['tree']
        for node in tree:
            if node['name'] == 'Subjects':
                if os.path.exists(server_info):
                    os.remove(server_info)
                fp=open(server_info,'a')
                servers = node['children'][0]['children']
                for server in servers:
                    string = "{}|{}".format(server['name'],server['id'])
                    fp.write(string+"\n")
                fp.close()

def write_instances_info(rep):
    instance_info = os.environ['TREECALL_TEMP']+"/instance_info.txt"
    with open(rep,'r') as reader:
        json_rep = json.load(reader)
        tree = json_rep['tree']
        for node in tree:
            if node['name'] == 'Subjects':
                if os.path.exists(instance_info):
                    os.remove(instance_info)
                fp=open(instance_info,'a')
                instances = node['children'][0]['children']
                for instance in instances:
                    string = "{}|{}|{}".format(node['children'][0]['name'],instance['name'],instance['id'])
                    fp.write(string+"\n")
                fp.close()


