import os
import json

rep_file = os.environ['RESPONSE_FILE']
with open(rep_file,'r') as reader:
    content = reader.read()

json_content = json.loads(content)

with open(".expected_graphs",'r') as reader:
    exp_graph_list = reader.readlines()

count = 0
exp_mgid = os.environ['EXP_MGID']
graph_list = list()
hierarchy = 1

if hierarchy = 1:
    tree = json_content['tree']
    for i in range(0,len(tree)):
        if tree[i]['name'] == 'MetricGroups':
            groups = tree[i]['children']
            break
    for group in groups:
        mgid = group['gdfid']
        if mgid == exp_mgid:
            graphs = group['children']
    for graph in graphs:
        graph_list.insert(graph['name'])

    for graph in graph_list:
        if graph in exp_graph_list:
            count = count + 1
    print(count)
            

