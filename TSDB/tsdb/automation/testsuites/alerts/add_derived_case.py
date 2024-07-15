import requests
import shutil
import pytest
import enum
import json
import os
import setup
import subprocess


#function for find the port of Alert Manager
import Port

# Get the port number from the file
port = Port.get_port_from_file()
tr_num = setup.get_test_number()

i = 800

class SubType(enum.Enum):
    ALL_MODE = "1"
    SPECIFIED_MODE = "2"
    PATTERN_MODE = "3"

class Function(enum.Enum):
    NONE = "0"
    AVG = "1"
    MAX = "2"
    MIN = "3"
    COUNT = "4"
    SUMCOUNT = "5"
    SUM = "6"

class Operators(enum.Enum):
    LOG_2 = "1"
    lOG_10 = "2"
    SAMPLE_DIFF_PCT = "3"
    AWAY_FROM_TIER_AVG = "4"

@pytest.mark.parametrize(
    "subtype",
    SubType,
    ids=[str(sub.value) for sub in SubType],
)
@pytest.mark.parametrize(
    "function",
    Function,
    ids=[str(t.value) for t in Function],
)
@pytest.mark.parametrize(
    "operator",
    Operators,
    ids=[str(op.value) for op in Operators],
)
def test_parameterized_derived_add(subtype, function, operator):
    global i
   

    #if i > 602:
    #    pytest.skip("limit over")

    subject = ""
    if subtype.value == "1":
        subject = "Tier:ALL>Server:ALL>Processor:ALL"
    elif subtype.value == "2":
        subject = "Tier:*>Server:*>Processor:*"
    elif subtype.value == "3":
        subject = "Tier:datacall-tier-1>Server:datacall-server-1>Processor:Processor-1"
      
    command = [
        "tsdb_admin", "--tr", tr_num, "--op", "dc", "--num_derived_metric", "1", "--flag", "1",
        "--dmg_name", f"New0_{i}", "--id", "1", "--group_desc", "my_derived", "--derived_metric_name", "TEST1234",
        "--derived_metric_desc", "Test_for_derived_metr", "--formula", "NA",
        "--agg_type", "1", "--agg_by", "0", "--d_level", "Tier,Server", "--num_variable", "1", "--var_exp", "2",
        "--aggr_fn", function.value, "--unaryfn_count", "1", "--unaryfn", operator.value, "--var_name", "A", "--gctx_len", "1",
        "--subject", subject,
        "--measure", "MGType:System Metrics>MGroup:MPStat Linux>Metric:Steal CPU (%),10010,7"
    ]

    print(f"function {function.value}, operator {operator.value}")
    i += 1
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output, error = process.communicate()
    print(f"output {output}")

if __name__ == "__main__":
    pytest.main()

