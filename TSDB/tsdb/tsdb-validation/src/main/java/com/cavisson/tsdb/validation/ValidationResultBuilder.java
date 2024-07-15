package com.cavisson.tsdb.validation;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.logging.log4j.Logger;

import com.cavisson.tsdb.validation.ValidationResultDTO.TestCaseResult;

// It will generate xml 
public class ValidationResultBuilder {
  private static List<ValidationResultDTO> logs = Collections.synchronizedList(new ArrayList<>());

  private static final String INDENT1 = "  ";
  private static final String INDENT2 = "    ";
  private static final String INDENT3 = "      ";
  private static final String INDENT4 = "        ";
  private static final String INDENT5 = "          ";

  public static void reset() {
    logs.clear();
  }

  //TODO: Currently keeping in memory later, we will try to write into disk to avoid keeping in memory. 
  public static void log(ValidationResultDTO result) {
    logs.add(result);
  }

  // Generating report in junit xml format which can further be converted to html.
  // References - https://inorton.gitlab.io/-/junit2html/-/jobs/6057019437/artifacts/junit2html-merged-example.xml
  public static void generateReport() {
    Logger logger = TSDBLogger.getLogger();

    // sort logs by group and graph. 
    Collections.sort(logs, new Comparator<ValidationResultDTO>() {
      @Override
      public int compare(ValidationResultDTO o1, ValidationResultDTO o2) {
        int grpCopRet = o1.group.compareTo(o2.group);

        if (grpCopRet == 0) {
          return o1.graph.compareTo(o2.graph);
        }

        return grpCopRet;        
      }
    });

    String outputFile = "TSDBValidation_" + System.currentTimeMillis() + ".xml";

    
    PrintWriter writer = null;
    try {

      writer = new PrintWriter(new File(outputFile)); 


      writer.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
      writer.println("<testsuites>");
      
      String lastGroup  = "";
      String lastGraph = "";
      int numCasesAdded = 0;
      ValidationResultDTO log;
      final int COUNTING_PASS = 0;
      final int LOGGING_PASS  = 1;
      int pass_mode = COUNTING_PASS; // There will be two pass, 0 - just to get summary and 1 to do the actual logging.
      int total_cases = 0, failed_cases = 0, pass_cases = 0; // Note: all counts may not required, but keeping it as placeholder.   
      int last_idx = 0, till = 0; 
      int all_total_cases = 0, all_failed_cases = 0, all_pass_cases = 0; 
      for (int i = 0; i < logs.size(); i++) {
        log = logs.get(i);

        if (pass_mode == COUNTING_PASS) {
          // Check if mismatch. 
          if (i != last_idx && (!lastGraph.equals(log.graph) || !lastGroup.equals(log.group))) {
            // process these logs again for logging. 
            till = i - 1;
            i = last_idx -1; 
            pass_mode = LOGGING_PASS;
            continue; 
          }

          lastGraph = log.graph;
          lastGroup = log.group;

          // update stats. 
          for (TestCaseResult res : log.results)  {
            total_cases ++;
            all_total_cases++;
            if (res.error.length() == 0) {
              pass_cases++;
              all_pass_cases++;
            } else {
              failed_cases++;
              all_failed_cases++;
            }
          }

          continue;
        } 

        // LOGGING_PASS. 
        if (i == last_idx) { // add new testsuite. 
          writer.println( 
            // Note: Keeping errors and skipped as 0, later we can set these as well accordingly. 
            String.format("%s<testsuite name=\"%s.%s\" tests=\"%d\" passed=\"%d\" failures=\"%d\" errors=\"0\" skipped=\"0\">",
              INDENT1, log.group, log.graph, total_cases, pass_cases, failed_cases)
          );
        }

        for (TestCaseResult res : log.results) {
          if (res.error.equals("")) {
            writer.println(
              String.format("%s<testcase classname=\"%s\" name=\"%s\"/>", INDENT2, log.subject, res.validationType)
            );
          } else {
            writer.println(
              String.format("%s<testcase classname=\"%s\" name=\"%s\"><failure message=\"%s\">\"%s\"</failure></testcase>",
              INDENT2, log.subject, res.validationType, res.error, res.error)
            );
          }
  
          numCasesAdded++;
        }

        if (i == till) {
          // End test suite. 
          writer.println(INDENT1 + "</testsuite>");

          // Change state. 
          last_idx = i + 1; 
          pass_mode = COUNTING_PASS;
          // reset counters 
          total_cases = 
          failed_cases = 
          pass_cases = 0;
        }
      }

      // End Pending Tags. 
      writer.println("</testsuites>");

      // TODO: Need to update summary in xml file too. 
      logger.info(String.format("Total cases - %d, Pass - %d, Failed - %d, Skipped - %d", 
        all_total_cases, all_pass_cases, all_failed_cases, 0));

    } catch(Exception e) {
      logger.error("Failed to generate report, Exception - ", e);
    } finally {
      if (writer != null) {
        writer.close();
      }
    }
  }
}
