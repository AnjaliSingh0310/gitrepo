package com.cavisson.tsdb.validation;


public class ValidationResultDTO {
  private static final String Unknown = "Unknown";

  String group = Unknown;
  String graph = Unknown;
  String subject = Unknown; 

  static class TestCaseResult {
    String validationType = Unknown;
    String error = "";
    double time = 0.0; 

    TestCaseResult setValidationType(String validationType) {
      this.validationType = validationType;
      return this;
    }
  
    TestCaseResult setError(String error) {
      this.error = error;
      return this;
    }
  
    TestCaseResult setTime(double time) {
      this.time = time;
      return this;
    }
  }

  TestCaseResult []results; // We will be executing multiple test cases for the same metric. 


  ValidationResultDTO setGroup(String group) {
    this.group = group;
    return this;
  }

  ValidationResultDTO setGraph(String graph) {
    this.graph = graph;
    return this;
  }

  ValidationResultDTO setSubject(String subject) {
    this.subject = subject;
    return this;
  }
}
