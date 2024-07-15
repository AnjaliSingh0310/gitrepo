import pandas as pd
import subprocess
import os
import time
import json
import math

def parse_csv_to_dict(filename):
  # Read the CSV file using pandas, specifying converters for the "types" column
  try:
    df = pd.read_csv(filename, header=0)
    #print (df)
  except FileNotFoundError:
    print(f"Error: File '{filename}' not found.")
    return None

  # Convert the DataFrame to a dictionary
  if not df.empty:  # Check if DataFrame is not empty
    data_dict = df.to_dict(orient='records')
  else:
    print("No data found in the CSV file.")
    data_dict = None  # Or set an empty dictionary

  return data_dict

#function for run the ingestion
def run_ingestion(data):
    with open("alert_ingestion.conf", 'w') as outfile:
        for i in range(0, len(data)):
            ingestion_config = data[i].get('Ingestion Configuraton')
            if isinstance(ingestion_config, float) and math.isnan(ingestion_config):
                     continue
            else:
                 ingestion_obj= json.loads(ingestion_config)
                 print(ingestion_obj)
                 for i in ingestion_obj:
                   outfile.write(i + "\n")

    ns_wdir = os.environ["NS_WDIR"]
    tr_num = get_test_number().strip()
    ingestion_path = os.path.join(ns_wdir, "tsdb_ingestion_ctrl")
    command = [ingestion_path, "-o", "start", "-t", tr_num, "-f", "/home/cavisson/work/TSDB/tsdb/automation/testsuites/alerts/alert_ingestion.conf" ] # Can be a list for complex commands
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output, error = process.communicate()

    if error:
      return error.decode()
    else:
      response = output.decode()
      #vaidate ingestion if run sucessfully or not
      get_str = "register started successfully for profile"
      get_out = response.find(get_str)
      if get_out == -1:
          time.sleep(30)
          process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
          output, error = process.communicate()
          response = output.decode()
          get_out = response.find(get_str)
          if get_out == -1:
              print("Error: Ingestion is not started")
              return -1
          else: 
              return 1
      else:
          return 1




#function for to get the tr number
def get_test_number():
    command = ["bash", "-c","nsu_show_netstorm |  awk 'NR==2 {print $1}'" ] # Can be a list for complex commands
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output, error = process.communicate()

    if error:
      return error.decode()
    else:
      return output.decode()

