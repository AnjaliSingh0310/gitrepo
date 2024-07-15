nsl_decl_var(rec_buffer);
nsl_decl_var(SubjectMode);
nsl_decl_var(CallMode);
nsl_decl_var(MetricDataMode);
nsl_decl_var(MonitorGroup);
nsl_decl_var(TSDB_RES_Time_TX);
nsl_decl_var(buffer);
nsl_decl_var(msg_len);
nsl_decl_var(send_data);
nsl_decl_var(TSDB_HOST);
nsl_decl_var(MIN_CUSTOM_HRS_BACK);
nsl_decl_var(MAX_CUSTOM_HRS_BACK);
nsl_decl_var(MAX_CUSTOM_DURATION);
nsl_decl_var(MIN_CUSTOM_DURATION);
nsl_decl_var(MIN_TIME_PERIOD);
nsl_decl_var(MAX_TIME_PERIOD);
nsl_decl_var(MetricCount);
nsl_decl_var(FILTER_TYPE);
nsl_decl_var(METRIC_FILTER_OPTION);
nsl_decl_var(MIN_OP_NUMBER);
nsl_decl_var(MAX_OP_NUMBER);
nsl_decl_var(INCREMENTAL_MODE);
nsl_decl_var(INCREMENTAL_Freq);
nsl_decl_var(ALERT_NUM_OF_RULES);
nsl_decl_var(ALERT_MT_ATTR);
nsl_decl_var(Time_Window);
nsl_decl_var(Check_Status_Time);
//nsl_decl_var(Num_Severity);
//nsl_decl_var(cond_type);
nsl_decl_var(num_cond);
nsl_static_var(ControllerIP:1,ControllerPort:2, File=tsdb_machine_info.seq, Refresh=SESSION, Mode=SEQUENTIAL, FirstDataLine=2, EncodeMode=All);
nsl_static_var(ALERT_OPEARTION:1,RULE_ID:2,RULE_NAME:3,Num_schedules:4,schedule_type:5,Num_Severity:6,Condition_Name:7,cond_type:8,Num_Test_Case:9, File=alert_config.txt.seq, Refresh=SESSION, Mode=SEQUENTIAL, FirstDataLine=2, ColumnDelimiter=|, EncodeMode=All);
nsl_static_var(Metric_ID:1, subject:3, measure:4, GDF_ID:5, Graph_ID:6, File=tsdb_metrics.txt, Refresh=SESSION, Mode=SEQUENTIAL, FirstDataLine=2, EncodeMode=All);
nsl_index_file_var(Min_Value,Max_Value, File=MonitorGroup.txt, indexVar=MonitorGroup, FirstDataLine=2, HeaderLine=1, EncodeMode=All);
//nsl_static_var(Metric_ID:1, subject1:3, measure1:4, GDF_ID:5, Graph_ID:6, File=tsdb_metrics.txt, Refresh=SESSION, Mode=SEQUENTIAL, FirstDataLine=4, EncodeMode=All);
