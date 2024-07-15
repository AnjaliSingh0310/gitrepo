// Socket API 
nsl_decl_var(conn_fd);

nsl_decl_var(read_fd);
nsl_decl_var(write_fd);
nsl_decl_var(read_buf);


nsl_decl_var(cmon_fd);
nsl_decl_var(ndagent2ndc);
nsl_decl_var(ndc_ip_port);
nsl_decl_var(cmon_heartbeat_message);
nsl_decl_var(controller_ip);
nsl_decl_var(controller_port);

nsl_static_var(NDC_IP:1, NDC_Port:2, File=ndc_info.dat, Refresh=SESSION, Mode=SEQUENTIAL, FirstDataLine=1, EncodeMode=All);
nsl_static_var(msg:1, File=message.dat, Refresh=SESSION, Mode=SEQUENTIAL, FirstDataLine=1, EncodeMode=All);
nsl_static_var(CmonVersion:1,TierName:2, File=TierName.txt.seq, Refresh=SESSION, Mode=SEQUENTIAL, EncodeMode=All);
nsl_static_var(ControllerIP:2,ControllerPort:3,BackupIP:4,BackupPort:5,Protocol:6, File=NDCConfigFile.txt.wtr, Refresh=SESSION, Mode=WEIGHTED_RANDOM, FirstDataLine=2, EncodeMode=All);
nsl_decl_var(DV_GDFName);
//nsl_index_file_var(GroupName,NumberOfElement,MonitorType,VectorPrefix,MinVectors,maxVectors,DeleteInterval,AddInterVal,Data, File=GDFConfig.txt.seq, indexVar=DV_GDFName, FirstDataLine=1, EncodeMode=All);

//nsl_static_var(Tier:1, Server:2, IP:3, File=cmon_info.dat, Refresh=SESSION, Mode=SEQUENTIAL, FirstDataLine=1, EncodeMode=All);
//nsl_static_var(GDFName:1,NumberOfElement:2,MonitorType:3,VectorPrefix:4,MinVectors:5,maxVectors:6,DeleteInterval:7,AddInterVal:8,Data:9, File=GDFConfig.txt.seq, Refresh=SESSION, Mode=SEQUENTIAL, FirstDataLine=2, EncodeMode=All);

//nsl_static_var(CmonVersion:1, TierName:2, File=/home/cavisson/work/data_files/TierName.txt, Refresh=SESSION, Mode=SEQUENTIAL, FirstDataLine=1, EncodeMode=All);
