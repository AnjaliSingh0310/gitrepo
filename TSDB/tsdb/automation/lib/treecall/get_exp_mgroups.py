import os

metric_file = os.environ['METRIC_FILE']
tier = os.environ['EXPAND_TIER']

with open(metric_file, 'r') as reader:
    lines = reader.readlines()

gdf_ids=set()
for line in lines:
    Tier = line.split(',')[2].split('>')[-1]
    if Tier == "Tier:"+tier:
        gdf_ids.add(line.split(',')[4])

mg_ids = list(gdf_ids)
mg_ids.sort()

ids=str()
for mgid in mg_ids:
    ids=ids+" "+str(mgid)

print(ids)
