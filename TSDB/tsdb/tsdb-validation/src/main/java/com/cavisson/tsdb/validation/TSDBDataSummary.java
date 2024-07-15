package com.cavisson.tsdb.validation;

import com.cavisson.tsdb.dto.data.ResponseMetricData;

public class TSDBDataSummary {
    double min = Double.MAX_VALUE;
    double avg;
    double max; 
    long count; 
    // TODO: keep other fields as well.
    
    public static TSDBDataSummary generate(ResponseMetricData timeseries) {
      TSDBDataSummary summary = new TSDBDataSummary();

      int i = 0;
      double avgArr[] = timeseries.getAvg();
      double minArr[] = timeseries.getMin();
      double maxArr[] = timeseries.getMax();
      double countArr[] = timeseries.getCount();
      
      double sum = 0;
    
      for (; i < avgArr.length; i++) {
          if ((countArr[i] != 0 && countArr[i] != TSDBValidationConstants.GUI_NAN)
                && 
              (avgArr[i] != TSDBValidationConstants.GUI_NAN)  // As a saftey check. 
              ) {


            summary.count += countArr[i];
            sum += (countArr[i] * avgArr[i]);

            if (summary.min > minArr[i]) {
              summary.min = minArr[i];
            }

            if (summary.max < maxArr[i]) {
              summary.max = maxArr[i];
            }
          }
      }

      if (summary.count != TSDBValidationConstants.GUI_NAN && summary.count != 0)
        summary.avg = sum / summary.count;

      return summary;
    }
}
