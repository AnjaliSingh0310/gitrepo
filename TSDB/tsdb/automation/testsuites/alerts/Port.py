import os

#function for find the port of Alert Manager
def get_port_from_file():
  file_path = "/home/cavisson/work/AlertManager/alert_manager.env"
  if not os.path.exists(file_path):
    return None

  with open(file_path, 'r') as f:
    for line in f:
      if line.startswith("export ALERT_MANAGER_PORT="):
        # Extract the port number from the line
        port_str = line.split("=")[1].strip()
        if port_str:
          print(port_str)
          return port_str
        else:
          assert 0  # Port not found in the file then we assert

