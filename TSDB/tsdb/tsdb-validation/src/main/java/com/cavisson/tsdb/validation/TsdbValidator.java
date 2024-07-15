package com.cavisson.tsdb.validation;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.Logger;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

import com.cavisson.gui.server.external.utility.RestCallConstant;
import com.cavisson.tsdb.adapter.TSDBAdapter;
import com.cavisson.tsdb.dto.group.GroupDescriptionCtx;
import com.cavisson.tsdb.dto.group.GroupRequestDTO;
import com.cavisson.tsdb.validation.TSDBValidationYamlConfig.SkipMetrics;
import com.cavisson.tsdb.dto.common.Duration;

public class TsdbValidator {
  int testrun;
  TSDBAdapter tsdbAdapter;
  List<GroupDescriptionCtx> groups;
  ExecutorService executorService; 
  // TODO: It should be configurable. 
  private static final int MAX_THREAD = 8;
  Logger logger;
  static TSDBValidationYamlConfig appConfig = new TSDBValidationYamlConfig(); 
  
  public static final String TSDBValidationConfigFile = "TSDBValidationConfig.csv";
  public static final String TSDBPropertyFile = "TSDBValidation.yaml"; // This file will have global level configuration. 


  TsdbValidator(int testrun, TSDBAdapter tsdbAdapter) {
    this.testrun = testrun;
    this.tsdbAdapter = tsdbAdapter;
    this.logger = TSDBLogger.getLogger();

    logger.info("TsdbValidator Called");
  }


  void loadGroups() {
    logger.info("Loading groups");
    GroupRequestDTO grd = new GroupRequestDTO();
    grd.setAppId(RestCallConstant.defaultID);
    grd.setClientId(RestCallConstant.defaultID);
    grd.setOpType(RestCallConstant.groupOpType);
    grd.setTr(testrun);

    Duration duration = new Duration();

    // Adding duration because internally code it is needed. 
    long st, et;
    et = System.currentTimeMillis();
    st = et - 4 * 3600; // Last 4 hour. 
    duration.setViewBy(60);
    duration.setSt(st);
    duration.setEt(et);
    duration.setPreset("SPECIFIED_" +  st + "_" + et);
    
    grd.setDuration(duration);
    grd.setReqMetrics((byte)0x01);  // It is done to include graphs in result. 
    
    groups = this.tsdbAdapter.getGroupDTO(grd).getGroup();

    logger.info("Total groups - " +  groups.size());
  }

  void doDataCallValidation(long st, long et) {
    logger.info("Calling doDataCallValidation");

    this.executorService = Executors.newFixedThreadPool(MAX_THREAD);

    for (GroupDescriptionCtx group : this.groups) {
      // If complete group is filted then skip. 
      if (canSkipMetric(group.getMgId(), -1) == false) {
        DataValidationTask task = new DataValidationTask(group, testrun, tsdbAdapter, st, et);

        this.executorService.submit(task);
      }
    }

    while (true) {
      this.executorService.shutdown();
      try {
        this.executorService.awaitTermination(1, TimeUnit.DAYS);
        break;
      } catch (InterruptedException e) {
        continue;        
      }
    }

    logger.info("All Validation tasks completed, Generating report. ");

    ValidationResultBuilder.generateReport();

    // TODO: print report name. 
    logger.info("Report Generated. ");
    
  }

  // Configuration format would be as below - 
  void loadConfiguration() {
    String nsWdir = System.getenv("NS_WDIR");
    File configFile = null;

    if (nsWdir != null) {
      
      if ((configFile = new File(nsWdir + "/" +  TSDBPropertyFile)).exists() == false) {
        if ((configFile = new File(nsWdir + "/webapps/sys/" + TSDBPropertyFile)).exists() == false) {
          configFile = null;
        }
      }
    }

    if (configFile == null) {
      if ((configFile = new File(System.getProperty("user.dir") + "/" + TSDBPropertyFile)).exists() == false) {
        return;
      }
    }

    // Parse Yaml. 
    // Reference - https://www.baeldung.com/java-snake-yaml
    try {
      // We can not use commented approach as for this approach, file should be relative to classpath. 
      //Yaml yaml = new Yaml();
      //InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream(configFile.getName());

      Yaml yaml = new Yaml(new Constructor(TSDBValidationYamlConfig.class));
      appConfig = (TSDBValidationYamlConfig) yaml.load(new FileInputStream(configFile));

      logger.info(
        String.format("%s file os loaded. uproll_validation = %b, summary_validation = %b, analyse_all_mt = %b, skip_metrics = %d, report.mail = %b",
        TSDBPropertyFile, appConfig.uproll_validation, appConfig.summary_validation, appConfig.analyse_all_mt, 
        appConfig.skip_metrics != null ? appConfig.skip_metrics.size(): 0, appConfig.report.mail)
      );
    } catch(Exception e) {
      logger.error("Failed to load configuration file - " +  appConfig +", error - " , e);
      System.exit(-1);
    }
  }
  
  // 
  void loadRangeConfiguration() {
    logger.info("Loading Validation configurations.");
    String nsWdir = System.getenv("NS_WDIR");
    File configFile = null;

    if (nsWdir != null) {
      
      if ((configFile = new File(nsWdir + "/" +  TSDBValidationConfigFile)).exists() == false) {
        if ((configFile = new File(nsWdir + "/webapps/sys/" + TSDBValidationConfigFile)).exists() == false) {
          configFile = null;
        }
      }
    }

    if (configFile == null) {
      if ((configFile = new File(System.getProperty("user.dir") + "/" + TSDBValidationConfigFile)).exists() == false) {
        return;
      }
    }

    try {
      String configData = FileUtils.readFileToString(configFile, StandardCharsets.UTF_8);

      String lines[] = configData.split("\n");
      String fields[];

      for (String line : lines) {
        if ((line = line.trim()).length() == 0) return;

        fields = line.split(",");
        // GroupId|GraphId|min|max|.... 
        if (fields.length >= 4) { // min. 4 fields are required.

          try {
            TSDBValidationConfig.set(
              Integer.parseInt(fields[0]),
              Integer.parseInt(fields[1]),
              new TSDBValidationConfig(Float.parseFloat(fields[2]), Float.parseFloat(fields[3]))
            );
          } catch(Exception e) {

          }
        }
      }

    } catch(Exception e) {
      logger.error("Failed to load config file - " + configFile.getName());
    }
    

    
    
    
  }

  static Map<String, Boolean> blackListMetricMap = new HashMap();
  void buildBlackListMetricMap() {
    if (appConfig.skip_metrics != null) {
      for (SkipMetrics mt: appConfig.skip_metrics) {
        // In case mtid is -1 then all the metric of that group will be ignored. 
        blackListMetricMap.put(mt.mgid + ":" + mt.mtid, true);
      }
    }
  }

  public static boolean canSkipMetric(int mgid, int mtid) {
    return blackListMetricMap.containsKey(mgid +  ":-1") || 
        blackListMetricMap.containsKey(mgid + ":" + mtid);
  }

  void validate(long st, long et) {
    // clean already collected result if any. 
    ValidationResultBuilder.reset();

    // load Groups. 
    loadGroups();

    loadConfiguration();

    // load range configuration if present. 
    loadRangeConfiguration();

    buildBlackListMetricMap();
    
    // Start Validation. 
    doDataCallValidation(st, et);
  }
  
}
