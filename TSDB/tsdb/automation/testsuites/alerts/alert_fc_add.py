import requests
import shutil
import pytest
import enum
import json
import os

import Port

# Get the port number from the file
port = Port.get_port_from_file()

i = 0

class SeverityType(enum.Enum):
    CRITICAL = "3"
    MAJOR = "2"
    MINOR = "1"

class MetricAttribute(enum.Enum):
    AVG = "0"
    #MIN = "1"
    #MAX = "2"
    #COUNT = "3"

class SubType(enum.Enum):
    ALL_MODE = "2"
    #SPECIFIED_MODE = "1"
    #PATTERN_MODE = "4"

class Operand(enum.Enum):
    AVERAGE = "0"
    SUM_OF_EVERY = "1"
    MAX = "2"
    MIN = "3"
    AT_LEAST_ONE = "4"
    EVERY = "5"


class Operator(enum.Enum):
    ABOVE = "0"
    ABOVE_OR_EQUAL = "1"
    BELOW = "2"
    BELOW_OR_EQUAL = "3"
class ForecastModel(enum.Enum):
    DEFAULT = "0"
    SIMPLE = "1"
    REACTIVE = "2"
class ForecastType(enum.Enum):
    LINEAR = "0"
    SEASONAL = "1"
class WindowType(enum.Enum):
    #MOVING = "0"
    FIXED = "1"

#We have take only two time i.e. 1 min and 5 min
class TimeWindow(enum.Enum):
    FIRST = "1"
    SECOND = "5"

@pytest.fixture
def json_file_path():
    return "/home/cavisson/work/TSDB/tsdb/automation/testsuites/alerts/alert_fc_json.json"

@pytest.mark.parametrize(
    "metric_att",
    MetricAttribute,
    ids=[str(met.value) for met in MetricAttribute],
)
@pytest.mark.parametrize(
    "subtype",
    SubType,
    ids=[str(sub.value) for sub in SubType],
)
@pytest.mark.parametrize(
    "timeWindow",
    TimeWindow,
    ids=[str(t.value) for t in TimeWindow],
)
@pytest.mark.parametrize(
    "severity",
    SeverityType,
    #ids=[str(s.value) for s in SeverityType],
    ids=[str(s) for s in SeverityType],
)
@pytest.mark.parametrize(
    "operand",
    Operand,
    ids=[str(o.value) for o in Operand],
)
@pytest.mark.parametrize(
    "operator",
    Operator,
    ids=[str(op.value) for op in Operator],
)
@pytest.mark.parametrize(
    "forecastModel",
    ForecastModel,
    ids=[str(op.value) for op in ForecastModel],
)
@pytest.mark.parametrize(
    "forecastType",
    ForecastType,
    ids=[str(op.value) for op in ForecastType],
)
@pytest.mark.parametrize(
    "Window",
    WindowType,
    ids=[str(w.value) for w in WindowType],
)
def test_parameterized_condition_values(severity, operand, operator, forecastModel, forecastType, Window, timeWindow, subtype, metric_att, json_file_path):
    """
    Tests with all combinations of severity, operand, and operator values.

    Creates a copy of the provided JSON file for each test case,
    updates the `dataType` and `operator` values, and prints a success message.
    """

    # Create a copy of the original JSON file with a unique suffix
    #new_file_path = f"{json_file_path}_{severity}_{operand.value}_{operator.value}_{Window.value}_{timeWindow.value}_{subtype.value}.json"
    #shutil.copy(json_file_path, new_file_path)

    global i
    with open(json_file_path, "r+") as f:
        data = json.load(f)

        data["rules"][0]["name"] = f"automation_test_fc_{i}"
        i += 1

        #if i >= 2:
        #  pytest.skip("Limit reached!")


        data["rules"][0]["attributes"]["severity"][0]["id"] = severity.value

        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["dataType"] = operand.value
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["operator"] = operator.value
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["forecastModel"] = forecastModel.value
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["forecastType"] = forecastType.value
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["windowType"] = Window.value
        data["rules"][0]["attributes"]["severity"][0]["conditionList"][0]["forcastType"]["timeWindow"] = timeWindow.value
        data["rules"][0]["attributes"]["metric"][0]["attribute"] = metric_att.value

        if (subtype.value == "4" and data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["key"] == "Tier"):
            data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["mode"] = subtype.value
            data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["value"] = "*"
            data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][1]["mode"] = subtype.value
            data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][1]["value"] = "*"
        
       
        if (subtype.value == "1" and data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["key"] == "Tier"):
            data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["mode"] = subtype.value
            data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][0]["value"] = "tier-1"
            data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][1]["mode"] = subtype.value
            data["rules"][0]["attributes"]["metric"][0]["subject"][0]["tags"][1]["value"] = "server-1"
            subject = data["rules"][0]["attributes"]["metric"][0]["subject"]
            new_tags = {};
            new_tags["tags"] = [
                {
                    "key": "Tier",
                    "value": "alert-tier-1",
                    "mode": "1"
                },
                {
                    "key": "Server",
                    "value": "alert-server-1",
                    "mode": "1"
                },
            ];

            subject.append(new_tags)
        
        # Move the file pointer back to the beginning for writing
        #f.seek(0)

        # Write the updated data to the new file
        #json.dump(data, f, indent=4)
        #url = "https://127.0.0.1:7901/DashboardServer/v2/web/alert/rule/add"
        
        url = "http://127.0.0.1:" + port  + "/alert/rule/add"
        headers = {
          "Content-Type": "application/json"
        }
        
        response = requests.request("post", url, json=data, headers=headers, verify=False)
        
        # Assert the response status code
        assert response.status_code == 200

if __name__ == "__main__":
    pytest.main()

