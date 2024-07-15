import os
import json

def log(msg):
    with open(os.environ['LOG_FILE'],'a') as logger:
        logger.write(msg+"\n")

def get_rep_content(rep_file):
    with open(rep_file,'r') as rfile:
        content = json.load(rfile)
    return content

