import os
import json
import treecall_lib as tl

out_msg = str()
expand_lvl = int(os.environ['EXPAND_LEVEL'])
rep_file = os.environ['RESPONSE_FILE']

def check_rep_status(rep_file):
    global content
    content = l.get_rep_content(rep_file)
    if content['status']['code'] != 200:
        return "FAIL : {}".format(content['status']['msg'])
    else:
        return "PASS"
