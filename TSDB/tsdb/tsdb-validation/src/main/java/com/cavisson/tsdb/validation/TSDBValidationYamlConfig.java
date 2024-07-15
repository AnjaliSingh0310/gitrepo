package com.cavisson.tsdb.validation;

import java.util.List;
import java.util.ArrayList;

public class TSDBValidationYamlConfig {
  boolean uproll_validation = true;
  boolean summary_validation = true;
  String log_level = "INFO";
  boolean analyse_all_mt = false;

  public static class SkipMetrics {
    int mgid;
    int mtid;
    public int getMgid() {
      return mgid;
    }
    public void setMgid(int mgid) {
      this.mgid = mgid;
    }
    public int getMtid() {
      return mtid;
    }
    public void setMtid(int mtid) {
      this.mtid = mtid;
    }
  }

  public static class Report {
    boolean mail = false;
    List<String> rcpt = null;
    public boolean isMail() {
      return mail;
    }
    public void setMail(boolean mail) {
      this.mail = mail;
    }
    public List<String> getRcpt() {
      return rcpt;
    }
    public void setRcpt(List<String> rcpt) {
      this.rcpt = rcpt;
    }
  }

  List<SkipMetrics> skip_metrics = new ArrayList();
  Report report = new Report();
  public boolean isUproll_validation() {
    return uproll_validation;
  }
  public void setUproll_validation(boolean uproll_validation) {
    this.uproll_validation = uproll_validation;
  }
  public boolean isSummary_validation() {
    return summary_validation;
  }
  public void setSummary_validation(boolean summary_validation) {
    this.summary_validation = summary_validation;
  }
  public String getLog_level() {
    return log_level;
  }
  public void setLog_level(String log_level) {
    this.log_level = log_level;
  }
  public boolean isAnalyse_all_mt() {
    return analyse_all_mt;
  }
  public void setAnalyse_all_mt(boolean analyse_all_mt) {
    this.analyse_all_mt = analyse_all_mt;
  }
  public List<SkipMetrics> getSkip_metrics() {
    return skip_metrics;
  }
  public void setSkip_metrics(List<SkipMetrics> skip_metrics) {
    this.skip_metrics = skip_metrics;
  }
  public Report getReport() {
    return report;
  }
  public void setReport(Report report) {
    this.report = report;
  }

  
}
