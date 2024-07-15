import os
import json

rep_file = os.environ['RESPONSE_FILE']
log_file = os.environ['LOG_FILE'] 

with open(rep_file, 'r') as reader:
    content = reader.read()

response = json.loads(content)
tree = response['tree']
for i in range(0,len(tree)):
    node = tree[i]['name']
    if node == "MetricGroups":
        childrens = tree[i]['children']
        break

gdf_ids=set()
for child in childrens:
    gdf_ids.add(child['gdfId'])

mg_ids = list(gdf_ids)
mg_ids.sort() 

ids=str()
for mgid in mg_ids:
    ids=ids+" "+str(mgid)

print(ids)
