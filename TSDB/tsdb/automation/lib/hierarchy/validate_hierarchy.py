import os
import json
import sys
import re
import hierarchy_lib as hl

out_msg = str()
expand_lvl = int(os.environ['EXPAND_LEVEL'])
rep_file = os.environ['RESPONSE_FILE']
sub_lvl = int(os.environ['SUB_LVL'])
content = dict()
actual_subjects = list()

def check_rep_status(rep_file):
    global content
    content = hl.get_rep_content(rep_file)
    if content['status']['code'] != 200:
        return "FAIL : {}".format(content['status']['msg'])
    else:
        return "PASS"

def validate_hierarchy():
    global out_msg
    global expand_lvl
    if expand_lvl == 1:
        act_tiers = hl.get_act_tier_list(content)
        exp_tiers = hl.get_exp_tier_list()
        act_tiers.sort()
        exp_tiers.sort()
        if act_tiers != exp_tiers:
            out_msg = "FAIL : expected_tiers = [ {} ] , actual_tiers = [ {} ]".format(exp_tiers,act_tiers)
        else:
            out_msg = "PASS"

    if expand_lvl >= 2:
        act_servers = set()
        exp_tiers = hl.get_exp_tier_list()
        tree = content['hierarchy'] 
        #iterate through tiers in hierarchy list
        for i in range(0,len(tree)):
            if tree[i]['vector'] in exp_tiers:
                exp_servers = hl.get_exp_servers(tree[i]['vector'])
                lvl1_subjects = tree[i]['subjects']
                #iterate through servers in tier subject
                for vector in lvl1_subjects:
                    if vector['metadata'] == "Server":
                        server = vector['vector']
                        hl.log("Act Server = [ {} ]".format(server))
                        if server not in exp_servers:
                            out_msg = out_msg+"Unknown server name - {}\n".format(vector['vector'])
                            break
                        if expand_lvl == 3:
                            exp_lvl3_subjects = hl.get_exp_lvl3_subjects(server)
                            lvl3_subjects = vector['subjects']
                            if len(lvl3_subjects) > 0:
                                for lvl3_subject in lvl3_subjects:
                                    if lvl3_subject['metadata'] not in exp_lvl3_subjects:
                                        out_msg = out_msg+"unknown lvl3 subject - {}\n".format(lvl3_subject['metadata'])
                                        break
                                    exp_lvl3_vectors = hl.get_exp_lvl3_vectors(lvl3_subject['metadata'])
                                    if lvl3_subject['vector'] not in exp_lvl3_vectors:
                                        out_msg = out_msg+"Unknown lvl3 vector - {}\n".format(lvl3_subject['vector'])
                                        break
                    else:
                        out_msg = out_msg+"Unknown metadata of lvl1 subject - {}\n".format(vector['metadata'])
                        break
            else:
                out_msg = out_msg+"Unknown tier name - {}\n".format(tree[i]['vector'])
                break
    if len(out_msg) == 0:
        out_msg = "PASS"
def validate_vector_list(inp_sub):
    global out_msg
    length_inp_sub = len(inp_sub)
    sub_line = ('.*').join(inp_sub).replace('ALL','*')
    hl.log("sub_line = {}".format(sub_line))
    subjects = hl.get_subjects_list()
    exp_vector_list = set()
    for subject in subjects:
        if len(subject.split('>')) > length_inp_sub:
            if re.search(sub_line, subject):
                hl.log("subject = {}".format(subject))
                vector = subject.split('>')[length_inp_sub]
                exp_vector_list.add(vector)
    hl.log("exp_vector_list = {}".format(exp_vector_list))
    hierarchy = hl.get_hierarchy(rep_file)
    for obj in hierarchy:
        act_metadata = obj['metadata']
        act_vectors = obj['vectorList']
        for vector in act_vectors:
            act_vector = "{}:{}".format(act_metadata,vector)
            if act_vector not in exp_vector_list:
                out_msg = out_msg+"unknown {} : {}\n".format(act_metadata,act_vector)
    if len(out_msg) == 0:
        out_msg = "PASS"


def validate_vectors(hierarchy,exp_sub_list):
    global out_msg
    global actual_subjects
    for node in hierarchy:
        metadata = node['metadata']
        try:
            vector = node['vector']
        except Exception:
            hl.log("Vector name not exists")
            if len(actual_subjects) > 0:
                actual_subjects.pop()
            continue
        string = "{}:{}".format(metadata,vector)
        actual_subjects.append(string)
        if len(node['subjects']) > 0:
            validate_vectors(node['subjects'],exp_sub_list)
            actual_subjects.pop()
        else:
            subject = ('>').join(actual_subjects)
            if subject not in exp_sub_list:
                out_msg = out_msg+"unkown subject : {}\n".format(subject)
            actual_subjects.pop()
        
def validate_hierarchy_with_subject():
    global out_msg
    tags = hl.get_tags(sub_lvl)
    subject = list()
    for tag in tags:
        key = tag['key']
        value = tag['value']
        subject.append("{}:{}".format(key,value))
    hl.log("subject = {}".format(subject))
    if expand_lvl == 1:
        validate_vector_list(subject)
    elif expand_lvl > 1:
        subjects = hl.get_subjects_list()
        subject_length = len(subject)
        sub_line = ('.*').join(subject).replace('ALL','*')
        exp_sub_list = set()
        for sub in subjects:
            sub_length = len(sub.split('>'))
            if sub_length > subject_length: 
                if re.search(sub_line,sub):
                    temp_list = list()
                    lb = subject_length
                    ub = subject_length+expand_lvl
                    if sub_length < ub:
                        ub = sub_length
                    #elif sub_length > expand_lvl:
                    #    ub = lb+expand_lvl
                    #hl.log("sub_length = {} , lb = {} , ub = {}".format(sub_length,lb,ub))
                    for i in range(lb,ub):
                    #    hl.log("i = {}".format(i))
                        temp_list.append(sub.split('>')[i])
                    string = ('>').join(temp_list)
                    exp_sub_list.add(string)
        hl.log("exp_sub_list = {}".format(exp_sub_list))
        hierarchy = hl.get_hierarchy(rep_file)
        validate_vectors(hierarchy,list(exp_sub_list))
        if len(out_msg) == 0:
            out_msg = "PASS"

msg = check_rep_status(rep_file)
if msg == "PASS":
    if sub_lvl > 0:
        validate_hierarchy_with_subject()
    else:
        validate_hierarchy()
    print(out_msg)
else:
    print(msg)
