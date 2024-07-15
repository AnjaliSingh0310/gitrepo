package com.cavisson.tsdb.validation;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import gnu.getopt.Getopt;
import gnu.getopt.LongOpt;

import com.cavisson.tsdb.adapter.TSDBAdapter;

public class Main {
    private static final Logger logger = LogManager.getLogger(TSDBLogger.class);

    public static void main(String[] args) {
        int testrun = -1;
        // Parsing arguments.
        // Define the long options
        LongOpt[] longopts = new LongOpt[4];
        longopts[0] = new LongOpt("help", LongOpt.NO_ARGUMENT, null, 'h');
        longopts[1] = new LongOpt("testrun", LongOpt.REQUIRED_ARGUMENT, null, 't');
        longopts[2] = new LongOpt("st", LongOpt.REQUIRED_ARGUMENT, null, 's');
        longopts[3] = new LongOpt("et", LongOpt.REQUIRED_ARGUMENT, null, 'e');

        // Create a Getopt object with the argv array and the long options
        Getopt g = new Getopt("validation.sh", args, "ht:s:e:", longopts);

        // Loop over the options
        int c;
        long st = 0, et = 0;
        while ((c = g.getopt()) != -1) {
            switch (c) {
                case 'h':
                    // Handle the help option
                    System.out.println("Usage: validation.sh [-h|--help] [-t|--testrun <testrun>] [-s|--st <starttime>] [-e|--et <endtime>]");
                    System.exit(-1);
                    break;
                case 't':
                    // Handle the outputdir option
                    testrun = Integer.parseInt(g.getOptarg());
                    break;
                case 's':
                    // Handle the maximum option
                    st = Long.parseLong(g.getOptarg());
                    break;
                case 'e':
                    // Handle the maximum option
                    et = Long.parseLong(g.getOptarg());
                    break;
                case '?':
                    // Handle the error case
                    System.out.println("Invalid option or missing argument");
                    break;
            }
        }

        // TODO: Pick CMT by default.

        // Get the index of the first non-option argument
        int index = g.getOptind();

        if (testrun == -1) {
            // try to parse positional arguments.
            if (index != -1 && index < args.length) {
                testrun = Integer.parseInt(args[index]);
            }
        }

        if (testrun == -1) {
            logger.error("Correct testrun is not provided. ");
            System.exit(-1);
        }

        logger.info("Running TSDB Vaidation on TR - " + testrun);

        TSDBAdapter tsdbAdapter = new TSDBAdapter();
        TsdbValidator tv = new TsdbValidator(testrun, tsdbAdapter);
        tv.validate(st, et);

        // exiting here as process was stuck, probablyy some thread pool was not
        // terminated.
        System.exit(0);
    }
}
