package com.cavisson.tsdb.validation;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.util.HashMap;
import java.util.Map;

public class TSDBValidationConfig {
  public double min;
  public double max;

  private static final Logger logger = LogManager.getLogger(TSDBLogger.class);
  private static TSDBValidationConfig defaultConfig = null;

  TSDBValidationConfig(double min, double max) {
    this.min = min;
    this.max = max;
  }

  private static TSDBValidationConfig getDefaultConfig() {
    if (defaultConfig != null) return defaultConfig;

    synchronized(TSDBValidationConfig.class) {  //TODO: simplify it
      if (defaultConfig == null) {
        defaultConfig = new TSDBValidationConfig(0.0, 214748364700.0);
      }
    }

    return defaultConfig;
  }

  private static Map<String, TSDBValidationConfig> configMap = new HashMap<>();

  public static TSDBValidationConfig get(int groupId, int graphId) {

    TSDBValidationConfig config =  configMap.get(groupId + "_" + graphId);

    logger.debug("Check config file for Gdf Id: " + groupId + "and graph Id: " + graphId);
    if (config == null)
      config = getDefaultConfig();
    else
      logger.debug("Config File is found, for Gdf Id: " + groupId + "and graph Id: " + graphId);
    return config;
  }

  public static void set(int groupId, int graphId, TSDBValidationConfig config) {
    configMap.put(groupId + "_" + graphId, config);
    logger.debug("Configuration is given for Gdf Id: " + groupId + "and graph Id: " + graphId);
  }
}
