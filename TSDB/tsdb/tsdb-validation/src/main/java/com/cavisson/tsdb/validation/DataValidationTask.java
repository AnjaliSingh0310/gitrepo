package com.cavisson.tsdb.validation;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.logging.log4j.Logger;

import com.cavisson.gui.server.external.dto.CheckGraphDataResponseDTO;
import com.cavisson.gui.server.external.utility.RestCallConstant;
import com.cavisson.gui.server.webdashboard.main.GraphDescription;
import com.cavisson.tsdb.adapter.TSDBAdapter;
import com.cavisson.tsdb.bufferresponse.dto.data.SummaryData;
import com.cavisson.tsdb.dto.common.Duration;
import com.cavisson.tsdb.dto.common.SubjectTags;
import com.cavisson.tsdb.dto.common.MeasureCtx;
import com.cavisson.tsdb.dto.common.SubjectContext;
import com.cavisson.tsdb.dto.data.Cctx;
import com.cavisson.tsdb.dto.data.DataContext;
import com.cavisson.tsdb.dto.data.DataContextRequestDTO;
import com.cavisson.tsdb.dto.data.DataResponseDTO;
import com.cavisson.tsdb.dto.data.GraphContext;
import com.cavisson.tsdb.dto.data.ResponseData;
import com.cavisson.tsdb.dto.data.ResponseGraphData;
import com.cavisson.tsdb.dto.data.ResponseMetricData;
import com.cavisson.tsdb.dto.graph.GraphDescriptionCtx;
import com.cavisson.tsdb.dto.group.GroupDescriptionCtx;
import com.cavisson.tsdb.util.TSDBConstant;
import com.cavisson.tsdb.validation.ValidationResultDTO.TestCaseResult;

public class DataValidationTask implements Runnable {

  GroupDescriptionCtx group;
  int testrun;
  TSDBAdapter tsdbAdapter;
  Logger logger;
  long st, et;


  DataValidationTask(GroupDescriptionCtx group, int testrun, TSDBAdapter tsdbAdapter, long st, long et) {
    this.group = group;
    this.testrun = testrun;
    this.tsdbAdapter = tsdbAdapter;
    this.logger = TSDBLogger.getLogger();
    this.st = st;
    this.et = et;
  }

  DataValidationTask(GroupDescriptionCtx group, int testrun, TSDBAdapter tsdbAdapter) {
    this.group = group;
    this.testrun = testrun;
    this.tsdbAdapter = tsdbAdapter;
    this.logger = TSDBLogger.getLogger();

    long stLocal, etLocal;
    etLocal = System.currentTimeMillis();
    stLocal = et - (4 * 3600) * 1000; // Last 4 hour.

    new DataValidationTask(group, testrun, tsdbAdapter, stLocal, etLocal);
  }


  private List<ResponseMetricData> doDataCall(GraphDescriptionCtx graph , long stLocal, long etLocal, int viewBy) {
    DataContextRequestDTO tsdbCtx = new DataContextRequestDTO();
    Duration duration = new Duration();
    DataContext dataCtx = new DataContext();
    GraphContext graphCtx[] = new GraphContext[1];

    String hierarchyTokens[] = group.getHierarchicalComponent().split(">");

    // set subject and measure.
    SubjectContext subject = new SubjectContext();
    SubjectTags subjectTags[] = new SubjectTags[hierarchyTokens.length];

    // get all time series.
    List<ResponseMetricData> graphDataList = new ArrayList<>();

    for (int i = 0; i < subjectTags.length; i++) {
      subjectTags[i] = new SubjectTags();
      SubjectTags tag = subjectTags[i];
      tag.setKey(hierarchyTokens[i]);
      tag.setValue("all");
      tag.setMode((short) 2);
    }

    subject.setTags(new ArrayList<SubjectTags>(Arrays.asList(subjectTags)));

    MeasureCtx measure = new MeasureCtx();

    measure.setMgType(group.getMetricTypeName());
    measure.setMgTypeId(-1);
    measure.setMg(group.getGroupName());
    measure.setMgId(group.getMgId());
    measure.setMetric(graph.getName());
    measure.setMetricId(graph.getMetricId());

    graphCtx[0] = new GraphContext();
    graphCtx[0].setSubject(subject);
    graphCtx[0].setMeasure(measure);
    graphCtx[0].setGlbMetricId("-1");

    dataCtx.setgCtx(graphCtx);

    duration.setViewBy(viewBy);
    duration.setSt(stLocal);
    duration.setEt(etLocal);
    duration.setPreset("SPECIFIED_" + stLocal + "_" + etLocal);

    tsdbCtx.setDuration(duration);
    // setting default data filter value. 
    // int dataFilterMask = 0x003F | 0x0040;
    int dataFilterArr[] = {
      TSDBConstant.DATA_AVG,
      TSDBConstant.DATA_MIN,
      TSDBConstant.DATA_MAX,
      TSDBConstant.DATA_COUNT,
      TSDBConstant.DATA_SUM_COUNT,
      TSDBConstant.DATA_SUM_SQUARE,
      TSDBConstant.DATA_SUMMARY
    };  // Using default for now. // TODO: Remove which are not needed. 
    tsdbCtx.setDataFilter(dataFilterArr);
    tsdbCtx.setDataCtx(dataCtx);
    tsdbCtx.setCctx(new Cctx());
    tsdbCtx.setTr(this.testrun);
    tsdbCtx.setOpType(RestCallConstant.dataOpType);
    tsdbCtx.setClientId(RestCallConstant.defaultID);
    tsdbCtx.setAppId(RestCallConstant.defaultID);

    DataResponseDTO respDTO;
    respDTO = this.tsdbAdapter.getDataDTO(tsdbCtx);
    
    ResponseData rdata = respDTO.getGrpData();

    if (rdata == null || rdata.getMFrequency() == null) {
      logger.error("Invalid response received for data call, group - " +  group.getGroupName());
      return null;
    }

    for (ResponseGraphData respGraphData : respDTO.getGrpData().getMFrequency()) {
      if (respGraphData != null)
        graphDataList.addAll(respGraphData.getData());
    }

    logger.info("Total " + graphDataList.size() + " time series received for group - " + group.getGroupName()
        + " and graph - " + graph.getName());
    
    return graphDataList;
  }

  @Override
  public void run() {
    logger.info("Validation started for group - " + group.getGroupName() + "(" + group.getMgId() + ")");

    try {

    for (GraphDescriptionCtx graph: group.getGraph())  {
      if (TsdbValidator.canSkipMetric(group.getMgId(), graph.getMetricId())) {
        logger.debug("Skipping validation for group - " +  group.getGroupName() + ", graph - " +  graph.getName());

        continue; // In case all_metric is not true then also it will attempt to check the next metric. 
      }
      //TODO: Lot of validation is missing. What if duration is more than max query window of (et - st).

      List<ResponseMetricData> graphDataList = null;
      List<ResponseMetricData> uprollGraphDataList = null; 
      try {
      graphDataList = doDataCall(graph, this.st, this.et, 60); // Do query for 1 min freq. 
      

      if (TsdbValidator.appConfig.uproll_validation) {
        uprollGraphDataList = doDataCall(graph, this.st, this.et, 600);
        Comparator<ResponseMetricData> comparator =  new Comparator<ResponseMetricData>() {

          @Override
          public int compare(ResponseMetricData o1, ResponseMetricData o2) {
            String o1_sname = o1.getSubject().getTags().get(0).getsName();
            String o2_sname = o2.getSubject().getTags().get(0).getsName();

            return o1_sname.compareTo(o2_sname);
          }
        };

        // In this case we should sort both the list by subject name.
        Collections.sort(graphDataList, comparator); 
        Collections.sort(uprollGraphDataList, comparator);
      }
    } catch(Exception e) {
      logger.error("Data query failed for mg - " + group.getGroupName() + ", mt - " + graph.getName() + ". Error - ", e);
      if (TsdbValidator.appConfig.analyse_all_mt == false) break; 
      continue; 
    }

      // Let's validate one by one.
      int uprollMetricIdx = 0; 

      for (ResponseMetricData metricData : graphDataList) {
        // Set some log level.
        String subject = metricData.getSubject().getTags().get(0).getsName();
        logger.info(
            String.format("Validating - %s:%s:%s", group.getGroupName(), graph.getName(), subject));


        ValidationResultDTO testCaseResult = new ValidationResultDTO();
        List<ValidationResultDTO.TestCaseResult> iterationResults = new ArrayList<>(); // It can execute multiple validation
                                                                                      // on same metric.

        testCaseResult
            .setGroup(group.getGroupName())
            .setGraph(graph.getName())
            .setSubject(subject);

        // do Range validation.
        rangeValidation(metricData, graph, iterationResults);

        // find uproll Metric. 
        if (TsdbValidator.appConfig.uproll_validation) {
          int matchIdx = -1;
          while (uprollMetricIdx < uprollGraphDataList.size()) {
            String uprollSubject = uprollGraphDataList.get(uprollMetricIdx).getSubject().getTags().get(0).getsName();

            int c = subject.compareTo(uprollSubject);
            
            if (c < 0) continue; // If current subject is smaller then uproll entry then skip. 
            else if (c == 0) {
              matchIdx = uprollMetricIdx++;
              break;
            } // else break;
          }

          if (matchIdx != -1) {
            // do uproll validation. 
            uprollValidation(metricData, uprollGraphDataList.get(matchIdx), graph, iterationResults);
          } else {
            logger.info(
              String.format("Group: %s, Graph: %s, Subject: %s, Uproll metric not found, ignoring uproll validation.", 
              group.getGroupName(), graph.getName(), subject)
            );
          }
        }

        testCaseResult.results = new TestCaseResult[iterationResults.size()];
        testCaseResult.results = iterationResults.toArray(testCaseResult.results);

        ValidationResultBuilder.log(testCaseResult);
      }

      if (TsdbValidator.appConfig.analyse_all_mt == false) {
        break; // As need to process only first metric. 
      }
    }

  } catch(Exception e) {
    logger.error("Exception in validation of group - " + group.getGroupName() + ", error - " , e); 
    return;
  }
    logger.info("Validation compelted for group - " + group.getGroupName() + "(" + group.getMgId() + ")");
  }

  public TestCaseResult rangeValidateField(double[] arr, String fieldName, double min, double max) {
    int i;
    TestCaseResult result = new TestCaseResult().setValidationType(TSDBValidationConstants.RANGE_VALIDATION);
    for (i = 0; i < arr.length; i++) {
      if (arr[i] != TSDBValidationConstants.GUI_NAN) {
        if (arr[i] < min || arr[i] > max) {
          result.setError(
              String.format("%s Out of range, actual %.3f, expected %.3f <> %.3f", fieldName, arr[i], min, max));
          break;
        }
      }
    }

    return result;
  }

  public void rangeValidation(ResponseMetricData graphData, GraphDescriptionCtx graph, List<ValidationResultDTO.TestCaseResult> iterationResults) {
    // get config.
    TSDBValidationConfig config = TSDBValidationConfig.get(group.getMgId(), graph.getMetricId());
    logger.debug("Gdf Id: " + group.getMgId() + "Graph Id: " + graph.getMetricId() + "Min: " + config.min + "Max: " + config.max);

    iterationResults.add(rangeValidateField(graphData.getAvg(), "avg", config.min, config.max));
    iterationResults.add(rangeValidateField(graphData.getMin(), "min", config.min, config.max));
    iterationResults.add(rangeValidateField(graphData.getMax(), "max", config.min, config.max));
    // rangeValidateField(graphData.getAvg(), "count", config.min, config.max,
    // ValidationResultDTO.clone(testCaseResult));

    // Summary Validation.
    // Calculate summary.
    TSDBDataSummary bSummary = TSDBDataSummary.generate(graphData);
    SummaryData aSummary = graphData.getSummary();

    // Do summary comparison only if there is non zero count in summary.
    if (bSummary.count != 0) {
      TestCaseResult result = new TestCaseResult().setValidationType(TSDBValidationConstants.SUMMARY_VALIDATION);

      if (!TSDBValidationUtils.compare(aSummary.getAvg(), bSummary.avg, 0.1)
          ||
          !TSDBValidationUtils.compare(aSummary.getMin(), bSummary.min, 0.1)
          ||
          !TSDBValidationUtils.compare(aSummary.getMax(), bSummary.max, 0.1)
          ||
          !TSDBValidationUtils.compare(aSummary.getCount(), bSummary.count, 0.1)) {
        result.setError(
            String.format("Summary mismatch, expected - (min - %.3f, max - %.3f, avg - %.3f, count - %d)," +
                " actual - (min - %.3f, max - %.3f, avg - %.3f, count - %d)",
                bSummary.min, bSummary.max, bSummary.avg, bSummary.count,
                aSummary.getMin(), aSummary.getMax(), aSummary.getAvg(), (int) aSummary.getCount()));
      }
  
      iterationResults.add(result);
    } 
  }

  
  // It will perform uproll Validation. 
  // 1. sample wise [TODO: ]
  // 2. Uproll Validation
  public void uprollValidation(ResponseMetricData graphData, ResponseMetricData uprollGraphData, GraphDescriptionCtx graph, List<ValidationResultDTO.TestCaseResult> iterationResults) {
    SummaryData nativeSummary = graphData.getSummary();
    SummaryData uprollSummary = uprollGraphData.getSummary();

    if (nativeSummary.getCount() != 0) {
      TestCaseResult result = new TestCaseResult().setValidationType(TSDBValidationConstants.UPROLL_SUMMARY_VALIDATION);

      if (!TSDBValidationUtils.compare(nativeSummary.getAvg(), uprollSummary.getAvg(), 0.1)
      ||
      !TSDBValidationUtils.compare(nativeSummary.getMin(), uprollSummary.getMin(), 0.1)
      ||
      !TSDBValidationUtils.compare(nativeSummary.getMax(), uprollSummary.getMax(), 0.1)
      ||
      !TSDBValidationUtils.compare(nativeSummary.getCount(), uprollSummary.getCount(), 0.1)) {
        result.setError(
          String.format("Uproll Summary mismatch, native summary - (min - %.3f, max - %.3f, avg - %.3f, count - %d)," +
            " uproll summary - (min - %.3f, max - %.3f, avg - %.3f, count - %d)",
            nativeSummary.getMin(), nativeSummary.getMax(), nativeSummary.getAvg(), (long) nativeSummary.getCount(),
            uprollSummary.getMin(), uprollSummary.getMax(), uprollSummary.getAvg(), (long) uprollSummary.getCount()));
      }

      iterationResults.add(result);
    }
  }
}
