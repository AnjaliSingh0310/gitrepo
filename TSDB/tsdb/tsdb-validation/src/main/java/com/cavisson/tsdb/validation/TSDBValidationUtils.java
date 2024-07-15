package com.cavisson.tsdb.validation;

import com.cavisson.tsdb.dto.common.SubjectContext;
import com.cavisson.tsdb.dto.common.SubjectTags;

public class TSDBValidationUtils {
  public static boolean compare(double actual, double baseline, double errorpct) {
    int nanCount = (isnan(actual) ? 1: 0)  + (isnan(baseline) ? 1 : 0);

    if (nanCount == 2) return true;

    if (nanCount == 1) return false; // if any one of the value is nan then return not matched. 

    // TODO: Review here. 
    if (baseline == 0) return true; 
    
    double delta = Math.abs(baseline - actual); // getting absolute value of diff. 

    return ((delta * 100/ baseline)) <= errorpct;
  }

  public static boolean isnan(double value) {
    return value == TSDBValidationConstants.GUI_NAN || Double.isNaN(value);
  }

  public static String subjectToString(SubjectContext subObj) {
    StringBuilder sb = new StringBuilder();
    for (SubjectTags tag: subObj.getTags()) {
      if (sb.length() == 0) {
        sb.append(tag.getKey() + ":" + tag.getValue());
      } else {
        sb.append(">" + tag.getKey() + ":" + tag.getValue());
      }
    }
    return sb.toString();
  }
  
}
