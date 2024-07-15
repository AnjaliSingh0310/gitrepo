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
nsl_static_var(CmonVersion:1,TierName:2,Tag:3, File=TierName.txt.seq, Refresh=SESSION, Mode=SEQUENTIAL, ColumnDelimiter=|, EncodeMode=All);
nsl_static_var(ControllerIP:2,ControllerPort:3,BackupIP:4,BackupPort:5,Protocol:6, File=NDCConfigFile.txt.wtr, Refresh=SESSION, Mode=WEIGHTED_RANDOM, FirstDataLine=2, EncodeMode=All);
nsl_decl_var(DV_GDFName);
nsl_date_var(Curr_Date, Format="%ms", Refresh=USE);
