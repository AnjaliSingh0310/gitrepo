/***************************************************************************************************
*
*    File     : nslb_t_digest_quantile.c
* 
*    Synopsis : This module contains library functions for computing the percentiles using t-digest algorithm
* 
*    Author   : Manmeet Singh Bhatia
* 
*    Date     : Feb-2019
* 
*    Copyright (C) Cavisson Systems 2019
*
****************************************************************************************************/ 
#include "nslb_t_digest_quantile.h"
#include "tdigest.h"
#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#ifdef __unix__
#include <libgen.h>
#include <sys/time.h>
#include <unistd.h>
#include <getopt.h>
#endif
#include <string.h>
#include "tdigest.c"

extern void TDigest_add(tdg_key **digest, double x, int w);

void t_digest_init(tdg_key **p_key, double delta, unsigned int K)
{
*p_key = td_new(delta, K);
}

void t_digest_insert(tdg_key **p_key, double mean, int count)
{
  td_add(*p_key, mean, count);
}

void nslb_t_digest_merge(tdg_key **p_key1, tdg_key *p_key2)
{
  td_merge(*p_key1, p_key2);
}

double nslb_t_digest_getquantile_at(tdg_key *p_key, double quantile)
{
  return td_value_at(p_key, quantile);
}

double nslb_t_digest_getquantile_of(tdg_key *p_key, double value)
{
  return td_quantile_of(p_key, value);
}

void nslb_t_digest_reset(tdg_key *p_key)
{
  td_reset(p_key);
}

void nslb_t_digest_destroy(tdg_key *p_key)
{
  td_free(p_key);
}

void *t_digest_serialize(tdg_key *p_key, int mode, char **buf, int *bufmalloclen, int *tdgsz)
{
  return td_serialize(p_key, mode, buf, bufmalloclen, tdgsz);
}

int nslb_t_digest_get_ncentroids(tdg_key *p_key)
{
  int ret = p_key->merged_nodes + p_key->unmerged_nodes;
  return ret;
}

int nslb_t_digest_get_data_count(tdg_key *p_key)
{
  return td_total_count(p_key);
}

tdg_key *nslb_t_digest_deserialize(char *buf, unsigned int K)
{
  return td_deserialize(buf, K);
}

int nslb_t_digest_debug(char *buf)
{
  return td_debug(buf);
}

int nslb_t_digest_debug_ex(char *buf, char *out_buf)
{
  return td_debug_dump_output_in_buf(buf, out_buf);
}

#ifdef TEST_TDIGEST

/* Compile using:
gcc -Wall -g nslb_t_digest_quantile.c tdigest.c -DTEST_TDIGEST -lm 
*/

static unsigned long get_ms_stamp() {

  struct timeval want_time;
  unsigned long timestamp;

  gettimeofday(&want_time, NULL);
  timestamp = (want_time.tv_sec )*1000 + (want_time.tv_usec / 1000);

  return timestamp;
}

static inline void print_usage_and_exit(char *progname)
  {
    /*      "file"     "file2"    "ser_mode"    "quantile"    "dump"    "delta"    "K"    "deserialize"   */
    fprintf(stderr, "\nERROR: Incorrect Usage. \n\nUsage:\n  %s "
                    "--file <datafilename> "
                    "[--file2 <datafile2>] "
                    "--ser_mode <1/2> "
                    "--quantile <quantile> "
                    "--dump <0/1> "
                    "--delta <delta> "
                    "--K <K> "
                    "--deserialize <0/1> \n\n"
                    "Where data file should contain newline separated data.\n\n", progname);
    fprintf(stderr, "Example:\n  %s --file 200kdata.txt --quantile 0.9 --ser_mode 2 --delta 0.01 --K 100 --dump 0\n\n", progname);
    fprintf(stderr, "Where,\n  - \"200kdata.txt\" is a file containing newline separated data set whose quantile is to be computed. \n  - 0.9 is the quantile (90th percentile) that has to be computed.\n\n");
    exit(1);
  }


int main (int argc, char **argv)
{
  char line[1024], ch;
  unsigned long t1, t2;

  static struct option long_options[] =
  {
    {"file", required_argument, NULL, 'f'},
    {"file2", required_argument, NULL, 'F'},
    {"ser_mode", required_argument, NULL, 'm'},
    {"quantile", required_argument, NULL, 'q'},
    {"dump", required_argument, NULL, 'd'},
    {"delta", required_argument, NULL, 'D'},
    {"K", required_argument, NULL, 'K'},
    {"deserialize", required_argument, NULL, 'u'},
    {NULL, 0, NULL, 0}
  };

  char filename[512] = "";
  char filename2[512] = "";
  int ser_mode = 0;
  double tdigest_quantile = 0.99;
  int dumpflag = 0;
  double tdigest_delta = 0.01;
  int tdigest_K = 100;
  int deser_flag = 0;
  while ((ch = getopt_long(argc, argv, "f:F:m:q:d:D:K:u:", long_options, NULL)) != -1)
  {
    // check to see if a single character or long option came through
    switch (ch)
    {
      case 'f':
        strcpy(filename, optarg);
        break;
      case 'F':
        strcpy(filename2, optarg);
        break;
      case 'm':
        ser_mode = atoi(optarg);
        break;
      case 'q':
        tdigest_quantile = atof(optarg);
        break;
      case 'd':
        dumpflag = atoi(optarg);
        break;
      case 'D':
        tdigest_delta = atof(optarg);
        break;
      case 'K':
        tdigest_K = atoi(optarg);
        break;
      case 'u':
        deser_flag = atoi(optarg);
        break;
      default:
        print_usage_and_exit(basename(argv[0]));
        break;
    }
  }

  /*      "file"     "file2"    "ser_mode"    "quantile"    "dump"    "delta"    "K"    "deserialize"   */
  printf("\nfilename = %s\n", filename);
  if(filename2[0]) printf("filename2 = %s\n", filename2);
  printf("ser_mode = %d\n", ser_mode);
  printf("tdigest_quantile = %f\n", tdigest_quantile);
  printf("dumpflag = %d\n", dumpflag);
  printf("tdigest_delta = %f\n", tdigest_delta);
  printf("tdigest_K = %d\n", tdigest_K);
  printf("deser_flag = %d\n\n", deser_flag);

  if(!filename[0])
   print_usage_and_exit(basename(argv[0]));

  t1 = get_ms_stamp();
  FILE *fp = fopen(filename, "r");
  if (!fp)
  {
    fprintf(stderr, "ERROR: Could not open file %s for reading\n",  filename);
    return 1;
  }

  tdg_key *p_key;  
  t_digest_init(&p_key, tdigest_delta, tdigest_K);
  int count = 0;

  double *arr=NULL;
  int arr_malloc_sz = 0, arr_sz = 0;
 
  while(fgets(line, 1023, fp))
  {
    if(arr_sz >= arr_malloc_sz)
    {
      arr = (double *) realloc(arr, (arr_malloc_sz + 512) * sizeof(double));
      if(!arr)
      {
        fprintf(stderr, "FATAL ERROR! could not allocate memory for integer array!\n");
        exit (1);
      }
      arr_malloc_sz += 512;
    }
  
    arr[arr_sz++] = atof(line);
  }

  t2 = get_ms_stamp();
  printf("Total values read: %d, time taken to read the data = %ld msec\n", arr_sz, t2 - t1);

  t1 = get_ms_stamp();
  for(count= 0; count<arr_sz; count++)
    t_digest_insert(&p_key, arr[count], 1);
  t2 = get_ms_stamp();
  printf("Time taken to insert data in T Digest = %ld msec\n", t2 - t1);

  t1 = get_ms_stamp();
  double percentile = nslb_t_digest_getquantile_at(p_key, tdigest_quantile);
  t2 = get_ms_stamp();
  

  printf("Total values processed: %d, Percentile = %f, time taken to calculate percentile = %ld msec\n", count, percentile, t2 - t1);
  

  if(filename2[0])
  {
    fclose(fp);
    fp = fopen(filename2, "r");
    if (!fp)
    {
      fprintf(stderr, "ERROR: Could not open file %s for reading\n", filename2); 
      return 1;
    }

    tdg_key *p_key2;  
    t_digest_init(&p_key2, tdigest_delta, tdigest_K);
    //TDigest *t = TDigest_create(0.01, 100);
    count = 0;
    while(fgets(line, 1023, fp))
    {
      t_digest_insert(&p_key2, atof(line), 1);
      //TDigest_add(&t, atof(line), 1);
      count++;
    }
    printf("Total values in second digest: %d\n", count);
    t1 = get_ms_stamp();
    nslb_t_digest_merge(&p_key, p_key2);
    t2 = get_ms_stamp();
    printf("Percentile of merged digest= %f, time for merge = %ld msec\n", nslb_t_digest_getquantile_at(p_key, tdigest_quantile), t2 - t1);
  }
  char *buf = malloc(10);
  int malloclen = 10, sz = 0, i;

  if(ser_mode)
  {
    /* Serialize */  
    t1 = get_ms_stamp();
    buf = t_digest_serialize(p_key, ser_mode, &buf, &malloclen, &sz);
    t2 = get_ms_stamp();
 
    printf("mode = %d, tdigest_delta = %f, tdigest_K = %d, malloclen = %d, sz = %d, ncentroids = %d, data count = %d, time taken to serialize = %ld msec\n", ser_mode, tdigest_delta, tdigest_K, malloclen, sz, nslb_t_digest_get_ncentroids(p_key), nslb_t_digest_get_data_count(p_key), t2 - t1);
 
    if(dumpflag)
    {
      printf("buffer dump:\n");
      for(i=0; i <sz; i++)
      {
        if(i && i % 8 == 0) printf("  ");
        if(i && i % 16 == 0) printf("\n");
        printf("%02x  ", ((char)buf[i]) & 0xff);
      }
      printf("\n");
 
      /* Dump to file */
      char outfilename[512];
      sprintf(outfilename, "%s.%s.tdg", filename, (ser_mode==1)?"asBytes":"asSmallBytes");
      FILE *wfp = fopen(outfilename, "w");
      if (!wfp)
      {
        fprintf(stderr, "\nERROR: Could not open file %s for writing\n",  outfilename);
      }
      else
      {
        fwrite(buf, 1, sz, wfp);
        fclose(wfp);
        wfp = NULL;
        
        printf("\nSuccessfully written to output file %s\n", outfilename);
      }
    }
 
    
    if(deser_flag)
    {
      /* De-Serialize */  
      t1 = get_ms_stamp();
      tdg_key *tdg2 = nslb_t_digest_deserialize(buf, tdigest_K);
      t2 = get_ms_stamp();
  
      printf("\n\nDe-serialize: ncentroids = %d, data count = %d, time taken to de-serialize = %ld msec, \n", nslb_t_digest_get_ncentroids(tdg2), nslb_t_digest_get_data_count(p_key), t2 - t1);
      printf("Percentile of de-serialized digest= %f\n", nslb_t_digest_getquantile_at(tdg2, tdigest_quantile));
    }
  }
 
}
#endif
