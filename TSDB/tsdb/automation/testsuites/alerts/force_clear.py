import pytest
import os
import json
import requests
import enum
import time

# Get the port number from the file
import Port
port = Port.get_port_from_file()

@pytest.fixture
def refresh_json_path():
  return "/home/cavisson/work/TSDB/tsdb/automation/testsuites/alerts/refresh.json"
 
def test_force_clear(refresh_json_path):
    with open(refresh_json_path, "r+") as f:
      data = json.load(f)

    headers = {
      "Content-Type": "application/json"
    }

    refresh_url = "http://127.0.0.1:" + port + "/alert/event/all?level=-1"
    response = requests.request("post", refresh_url, json=data, headers=headers, verify=False)
    assert response.status_code == 200

    response_json = response.json() 
    event = response_json["events"]
    events_length = len(response_json.get("events", []))
    print(events_length)


    if (events_length == 0):
        print("No active alert are present")
    else:
        # Copy the desired events
        new_event = {}

        # Additional data to be included
        new_event["cctx"] = {
            "cck": "cavisson.242440.1715663402971",
            "pk": "cavisson:172.24.0.206:05-14-2024 00-09-32.450",
            "u": "cavisson",
            "prodType": "Netdiagnostics"
        }

        # Create a copy of the event
        new_event["events"] = event

        # Add the ending data at the end
        new_event["opType"] = "51"
        new_event["tr"] = response_json["events"][0]["tr"]

        print (new_event)

        force_clear_url = "http://127.0.0.1:" + port + "/alert/event/clear"
        response = requests.request("post", force_clear_url, json=new_event, headers=headers, verify=False)
        assert response.status_code == 200


class Opcode(enum.Enum):
    ENABLE = 33
    DISABLE = 34

@pytest.fixture
def enable_disbale_json_path():
  return "/home/cavisson/work/alert_pytest/enable_disbale.json"
 
@pytest.mark.parametrize(
    "opcode",
    Opcode,
    ids=[str(o.value) for o in Opcode],
)
def test_single_enable_and_disable(opcode, enable_disbale_json_path):
    with open(enable_disbale_json_path, "r+") as f:
      data = json.load(f)

    headers = {
      "Content-Type": "application/json"
    }

    if opcode.value == 33:
        data["rules"][0]["attributes"]["enable"] = "true"
        data["opType"] = opcode.value
       
        url = "http://127.0.0.1:" + port + "/alert/rule/enable"
        response = requests.request("post", url, json=data, headers=headers, verify=False)
        assert response.status_code == 200
    else:
        data["rules"][0]["attributes"]["enable"] = "false"
        data["opType"] = opcode.value
       
        url = "http://127.0.0.1:" + port + "/alert/rule/disable"
        response = requests.request("post", url, json=data, headers=headers, verify=False)
        assert response.status_code == 200
 
class G_EN_DIS(enum.Enum):
    #ENABLE = "true"
    #DISABLE = "false"
    CLEAR = "clear"

@pytest.fixture
def refresh_json_path():
  return "/home/cavisson/work/alert_pytest/refresh.json"
 
@pytest.fixture
def global_enable_disbale_json_path():
  return "/home/cavisson/work/alert_pytest/global_en_dis.json"

@pytest.mark.parametrize(
    "g_op",
    G_EN_DIS,
    ids=[str(g.value) for g in G_EN_DIS],
)

def test_global_operation(g_op, global_enable_disbale_json_path, refresh_json_path):
    with open(global_enable_disbale_json_path, "r+") as f:
      data = json.load(f)
    
    if g_op.value == "clear":
        data["config"]["enable"] = "false"
        data["config"]["clearEvent"] = "true"
    else: 
        data["config"]["enable"] = g_op.value
 
    headers = {
      "Content-Type": "application/json"
    }
  
    url = "http://127.0.0.1:" + port + "/alert/config/update"
    response = requests.request("post", url, json=data, headers=headers, verify=False)
    assert response.status_code == 200

    with open(refresh_json_path, "r+") as f:
      data = json.load(f)

    headers = {
      "Content-Type": "application/json"
    }

    time.sleep(30) 
    refresh_url = "http://127.0.0.1:" + port + "/alert/event/all?level=-1"
    response = requests.request("post", refresh_url, json=data, headers=headers, verify=False)
    assert response.status_code == 200

    response_json = response.json() 
    event = response_json["events"]
    events_length = len(response_json.get("events", []))
    print(events_length)


    if (events_length == 0):
        print("No active alert are present")
    else: 
        assert 0
 
