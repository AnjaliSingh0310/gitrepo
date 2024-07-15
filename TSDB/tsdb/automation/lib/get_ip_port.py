import os
import lxml.etree as ET

#get server ip
cmd_ip = "hostname -I | awk '{print $1}'"

with os.popen(cmd_ip,'r') as file_ip:
    ip = file_ip.read().strip()

#get tomcat ssl port
tomcat_conf = os.environ['TOMCAT_DIR']+"/conf/server.xml"
xslt_file = os.environ['GENERIC_LIB']+"/port.xsl"
dom = ET.parse(tomcat_conf)
xslt = ET.parse(xslt_file)
transform = ET.XSLT(xslt)
newdom = transform(dom)
port = int(str(newdom).split('\n')[1])

print("{}:{}".format(ip,port))
