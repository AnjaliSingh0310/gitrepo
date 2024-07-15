import os
import json

hi_list = list()
all_hierarchy = list()
all_subjects = os.environ['ALL_SUBJECT']

def log(msg):
    with open(os.environ['LOG_FILE'],'a') as logger:
        logger.write(msg+"\n")

def get_rep_content(rep_file):
    with open(rep_file,'r') as rfile:
        content = json.load(rfile)
    return content

def get_hierarchy(rep_file):
    content = get_rep_content(rep_file)
    hierarchy_node = content['hierarchy']
    return hierarchy_node

def get_exp_subjects():
    subjects = list()
    with open(all_subjects,'r') as reader:
        subjects = reader.readlines()
    return subjects


def get_exp_tier_list():
    subjects = get_exp_subjects()
    tiers = set()
    for subject in subjects:
        tier = subject.split('>')[0].split(':')[1].strip()
        tiers.add(tier)
    log("Exp Tiers = {}".format(list(tiers)))
    return list(tiers)


def get_act_tier_list(rep_content):
    content = rep_content
    tree = content['hierarchy']
    if tree[0]['metadata'] == "Tier":
        log("Act Tiers = {}".format(tree[0]['vectorList']))
        return tree[0]['vectorList']


def get_exp_servers(req_tier):
    subjects = get_exp_subjects()
    servers = set()
    for subject in subjects:
        if len(subject.split('>')) >= 2:
            tier = subject.split('>')[0].split(':')[1].strip()
            if tier == req_tier:
                server = subject.split('>')[1].split(':')[1].strip()
                servers.add(server)
    log("Tier = {} ,Exp Servers = {}".format(req_tier,list(servers)))
    return list(servers)


def get_exp_lvl3_subjects(req_server):
    subjects = get_exp_subjects()
    lvl3_subjects = set()
    for subject in subjects:
        if len(subject.split('>')) >= 3:
            server = subject.split('>')[1].split(':')[1].strip()
            if server == req_server:
                lvl3_subject = subject.split('>')[2].split(':')[0].strip()
                lvl3_subjects.add(lvl3_subject)
    log("Server = {} , Exp_lvl3_subjects = {}".format(req_server,list(lvl3_subjects)))
    return list(lvl3_subjects)


def get_exp_lvl3_vectors(req_lvl3_subject):
    subjects = get_exp_subjects()
    lvl3_vectors = set()
    for subject in subjects:
        if len(subject.split('>')) >= 3:
            lvl3_subject = subject.split('>')[2].split(':')[0].strip()
            if lvl3_subject == req_lvl3_subject:
                lvl3_vector = subject.split('>')[2].split(':')[1].strip()
                lvl3_vectors.add(lvl3_vector)
    log("lvl3_subject = {} , Exp_lvl3_vectors = {}".format(req_lvl3_subject,list(lvl3_vectors)))
    return list(lvl3_vectors)

def get_tags(sub_lvl):
    subjects = get_subjects_list()
    tags = list()
    tier_name = os.environ['TIER'].strip()
    server = str()
    lvl3_subect = str()
    lvl3_vector = str()
    if sub_lvl >= 1:
        if int(os.environ['SUB_MODE'].split(':')[0]) == 1:
            tag = { "key":"Tier", "value":tier_name, "mode":1 }
            tags.append(tag)
        if int(os.environ['SUB_MODE'].split(':')[0]) == 2:
            tag = { "key":"Tier", "value":"ALL", "mode":2 }
            tags.append(tag)
        if int(os.environ['SUB_MODE'].split(':')[0]) == 4:
            value = tier_name.replace(tier_name.split('-')[-1],'*')
            tag = { "key":"Tier", "value":value, "mode":4 }
            tags.append(tag)
    if sub_lvl >= 2:
        #with open(os.environ['ALL_SUBJECT'],"r") as reader:
        #   lines = reader.readlines()
        for line in subjects:
            #log("line = {}".format(line))
            if tier_name in line and len(line.split('>')) >= 2:
                server = line.split('>')[1].split(':')[1].strip()
                break
        if int(os.environ['SUB_MODE'].split(':')[1]) == 1:
            tag = { "key":"Server", "value":server, "mode":1 }
            tags.append(tag)
        if int(os.environ['SUB_MODE'].split(':')[1]) == 2:
            tag = { "key":"Server", "value":"ALL", "mode":2 }
            tags.append(tag)
        if int(os.environ['SUB_MODE'].split(':')[1]) == 4:
            value = server.replace(server.split('-')[-1],'*')
            tag = { "key":"Server", "value":value, "mode":4 }
            tags.append(tag)
    #if sub_lvl >= 3:

        
    log("tags = {}".format(tags))
    return tags



def get_subjects(sub_node):
    global hi_list
    global all_hierarchy
    for item in sub_node:
        sub_metadata = item['metadata']
        sub_vector = item['vector']
        string = "{}:{}".format(sub_metadata,sub_vector)
        hi_list.append(string)
        if len(item['subjects']) > 0:
            get_subjects(item['subjects'])
            hi_list.pop()
        else:
            string = ('>').join(hi_list)
            all_hierarchy.append(string)
            hi_list.pop()

def get_subjects_list():
    global hi_list
    global all_hierarchy
    json_file = os.environ['HIERARCHY_REP']+"/hi_1.json"
    with open(json_file,"r") as response:
        json_rep = json.load(response)
    start_node = json_rep['hierarchy']
    subjects_list = os.environ['HIERARCHY_REP']+"/all_subjects"
    for jobj in start_node:
        hi_list = list()
        metadata = jobj['metadata']
        vector = jobj['vector']
        string = "{}:{}".format(metadata,vector)
        hi_list.append(string)
        get_subjects(jobj['subjects'])
    #log("subjects = {}".format(all_hierarchy))
    return all_hierarchy
