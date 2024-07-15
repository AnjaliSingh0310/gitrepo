package com.cavisson.tsdb.validation;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.LoggerContext;
import org.apache.logging.log4j.core.config.Configuration;
import org.apache.logging.log4j.core.config.LoggerConfig;

public class TSDBLogger {
  private static final Logger logger = LogManager.getLogger(TSDBLogger.class);

  public static  Logger getLogger() {
    return logger;
  }

  public static void init() {
    LoggerContext ctx = (LoggerContext)LogManager.getContext(false);
    Configuration config = ctx.getConfiguration();
    LoggerConfig loggerConfig = config.getLoggerConfig(LogManager.ROOT_LOGGER_NAME);
    loggerConfig.setLevel(Level.ALL);
  }
  
} 
