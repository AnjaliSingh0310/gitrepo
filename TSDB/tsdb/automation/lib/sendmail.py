import smtplib, ssl, os
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

sender = "automation@cavisson.com"
receivers = [ "prakhar.gupta@cavisson.com" ,  "sandeep.gupta@cavisson.com" , "arun.goel@cavisson.com" , "roshan.gupta@cavisson.com" ]
cc_receivers = [ "roshan.gupta@cavisson.com" ]
password = "M@tion!Cav2021"

with open("report.html","r") as reader:
    content = reader.read()

version_file = os.environ['NS_WDIR']+"/etc/version"
info = list()
with open(version_file,'r') as build_info:
    info = build_info.readlines()

version = info[0].split(' ')[1].strip()
build = info[1].split(' ')[1].strip()

message = MIMEMultipart("alternative")
message["Subject"] = "Perf Suit Automation || TSDB || Build Smoke Status Report | Build:"+version+"#"+build
#message["Subject"] = "TSDB Automation Report | Build:"+version+"#"+build+"(patch)"
message["From"] = sender
message["To"] = (',').join(receivers)
message["Cc"] = (',').join(cc_receivers)

body = MIMEText(content, "html")
message.attach(body)

context = ssl.create_default_context()
with smtplib.SMTP("websrv.cavisson.com", 587) as server:
    server.starttls(context=context)
    server.login(sender, password)
    for receiver in receivers:
        server.sendmail(sender, receiver, message.as_string())
