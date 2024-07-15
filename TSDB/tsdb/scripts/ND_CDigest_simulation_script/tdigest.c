#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>

#include "tdigest.h"

#define M_PI 3.14159265358979323846


/*static bool is_very_small(double val) {
     return !(val > .000000001 || val < -.000000001);
}
*/
static int cap_from_compression(double compression) {
     return (6 * (int)(compression)) + 10;
}

static bool should_merge(td_histogram_t *h) {
     return ((h->merged_nodes + h->unmerged_nodes) == h->cap);
}

static int next_node(td_histogram_t *h) {
     return h->merged_nodes + h->unmerged_nodes;
}

int td_centroid_count(td_histogram_t *p_key)
{
  return p_key->merged_nodes + p_key->unmerged_nodes;
}


void merge(td_histogram_t *h);

////////////////////////////////////////////////////////////////////////////////
// Constructors
////////////////////////////////////////////////////////////////////////////////



static size_t td_required_buf_size(double compression) {
     return sizeof(td_histogram_t) + 
          (cap_from_compression(compression) * sizeof(td_node_t));
}

// td_init will initialize a td_histogram_t inside buf which is buf_size bytes.
// If buf_size is too small (smaller than compression + 1) or buf is NULL,
// the returned pointer will be NULL.
//
// In general use td_required_buf_size to figure out what size buffer to
// pass.
static td_histogram_t *td_init(double delta, unsigned int K, size_t buf_size, char *buf) {
     td_histogram_t *h = (td_histogram_t *)(buf);
     if (!h) {
          return NULL;
     }
     memset((void *)(h), 0, buf_size);

    double compression = (double) K;
    if(delta != 0.0) compression /= delta;
     *h = (td_histogram_t) {
          .delta = delta,
          .K = K,
          .compression = compression,
          .cap = (buf_size - sizeof(td_histogram_t)) / sizeof(td_node_t),
          .merged_nodes = 0,
          .merged_count = 0,
          .unmerged_nodes = 0,
          .unmerged_count = 0,
     };
     return h;
}

td_histogram_t *td_new(double delta, unsigned int K)
{
     double compression = (double) K;
     if(delta != 0.0) compression /= delta;
     size_t memsize = td_required_buf_size(compression);
     return td_init(delta, K, memsize, (char *)(malloc(memsize)));
}

void td_free(td_histogram_t *h) {
     free((void *)(h));
}

void td_merge(td_histogram_t *into, td_histogram_t *from) {
     merge(into);
     merge(from);
     int i;
     for ( i = 0; i < from->merged_nodes; i++) {
          td_node_t *n = &from->nodes[i];
          td_add(into, n->mean, n->count);
     }
}

void td_reset(td_histogram_t *h) {
     memset((void *)(&h->nodes[0]), 0, sizeof(td_node_t)*h->cap);
     h->merged_nodes = 0;
     h->merged_count = 0;
     h->unmerged_nodes = 0;
     h->unmerged_count = 0;
}

/*double td_decay(td_histogram_t *h, double factor) {
     merge(h);
     h->unmerged_count *= factor;
     h->merged_count *= factor;
     for (int i = 0; i < h->merged_nodes; i++) {
          h->nodes[i].count *= factor;
     }
}*/

double td_total_count(td_histogram_t *h) {
     return h->merged_count + h->unmerged_count;
}

double td_quantile_of(td_histogram_t *h, double val) {
     merge(h);
     if (h->merged_nodes == 0) {
          return NAN;
     }
     double k = 0;
     int i = 0;
     td_node_t *n = NULL;
     for (i = 0; i < h->merged_nodes; i++) {
          n = &h->nodes[i];
          if (n->mean >= val) {
               break;
          }
          k += n->count;
     }
     if (val == n->mean) {
          // technically this needs to find all of the nodes which contain this value and sum their weight
          double count_at_value = n->count;
          for (i += 1; i < h->merged_nodes && h->nodes[i].mean == n->mean; i++) {
               count_at_value += h->nodes[i].count;
          }
          return (k + (count_at_value/2)) / h->merged_count;
     } else if (val > n->mean) { // past the largest
          return 1;
     } else if (i == 0) {
          return 0;
     }
     // we want to figure out where along the line from the prev node to this node, the value falls
     td_node_t *nr = n;
     td_node_t *nl = n-1;
     k -= (nl->count/2);
     // we say that at zero we're at nl->mean
     // and at (nl->count/2 + nr->count/2) we're at nr
     double m = (nr->mean - nl->mean) / (nl->count/2 + nr->count/2);
     double x = (val - nl->mean) / m;
     return (k + x) / h->merged_count;
}


static double my_quantile(double index, double previous_index, double next_index, double previous_mean, double next_mean)
{
  double delta = next_index - previous_index;
  double previous_weight = (next_index - index) / delta;
  double next_weight = (index - previous_index) / delta;

  return previous_mean * previous_weight + next_mean * next_weight;
}

//double TDigest_percentile(TDigest *digest, double q)
double td_value_at(td_histogram_t *h, double q) {
  merge(h);
  if(h->merged_nodes == 0)
    return 0.0;

  int i = 0;
  td_node_t *n = &h->nodes[i];

  if(h->merged_nodes == 1)
    return n->mean;

  td_node_t *center = n;

  i++;
  n = &h->nodes[i];
  td_node_t *leading = n;
   
  if (i == h->merged_nodes - 1) {
    // only two centroids because of size limits
    // both a and b have to have just a single element
    double diff = (leading->mean - center->mean) / 2;
    if (q > 0.75) {
      return leading->mean + diff * (4 * q - 3);
    } else {
      return center->mean + diff * (4 * q - 1);
    }
  } 

  double index = q * (h->merged_count - 1);
  double previous_mean = -999, previous_index = 0;
  long total = 0;
  td_node_t *next = NULL; 

  i = 0;
  while(i < h->merged_nodes)
  {
    if(!next) 
      next = &h->nodes[0];
    else
      next = &h->nodes[++i];

    double next_index = total + (next->count - 1.0) / 2.0;

    if(next_index >= index)
    {
      if(previous_mean ==-999)
      {
        // special case 1: the index we are interested in is before the 1st centroid
        if (next_index == previous_index) {
            return next->mean;
        }

        // assume values grow linearly between index previousIndex=0 and nextIndex2
        td_node_t *next2 = &h->nodes[i+1];
        double next_index2 = total + next->count + (next2->count - 1.0) / 2.0;
        previous_mean = (next_index2 * next->mean - next_index * next2->mean) / (next_index2 - next_index);
      }
      // common case: we found two centroids previous and next so that the desired quantile is
      // after 'previous' but before 'next'
      return my_quantile(index, previous_index, next_index, previous_mean, next->mean);  
    } 
    else if(next == &(h->nodes[(int)(h->merged_nodes) - 1]))
    {
      // special case 2: the index we are interested in is beyond the last centroid
      // again, assume values grow linearly between index previousIndex and (count - 1)
      // which is the highest possible index
      double next_index2 = h->merged_count - 1;
      double next_mean2 = (next->mean * (next_index2 - previous_index) - previous_mean * (next_index2 - next_index)) / (next_index - previous_index);
      return my_quantile(index, next_index, next_index2, next->mean, next_mean2);
    }
    total += next->count;
    previous_mean = next->mean;
    previous_index = next_index;
  }
  return 0.0;
}

void td_add(td_histogram_t *h, double mean, double count) {
     if (should_merge(h)) {
          merge(h);
     }
     h->nodes[next_node(h)] = (td_node_t) {
          .mean = mean,
          .count = count,
     };
     h->unmerged_nodes++;
     h->unmerged_count += count;
}

static int compare_nodes(const void *v1, const void *v2) {
     td_node_t *n1 = (td_node_t *)(v1);
     td_node_t *n2 = (td_node_t *)(v2);
     if (n1->mean < n2->mean) {
          return -1;
     } else if (n1->mean > n2->mean) {
          return 1;
     } else {
          return 0;
     }
}

void merge(td_histogram_t *h) {
     if (h->unmerged_nodes == 0) {
          return;
     }
     int N = h->merged_nodes + h->unmerged_nodes;
     qsort((void *)(h->nodes), N, sizeof(td_node_t), &compare_nodes);
     double total_count = h->merged_count + h->unmerged_count;
     double denom = 2 * M_PI * total_count * log(total_count);
     double normalizer = h->compression / denom;
     int cur = 0;
     double count_so_far = 0;
     int i;
     for ( i = 1; i < N; i++ ) {
          double proposed_count = h->nodes[cur].count + h->nodes[i].count;
          double z = proposed_count * normalizer;
          double q0 = count_so_far / total_count;
          double q2 = (count_so_far + proposed_count) / total_count;
          bool should_add = (z <= (q0 * (1 - q0))) && (z <= (q2 * (1 - q2)));
          if (should_add) {
               h->nodes[cur].count += h->nodes[i].count;
               double delta = h->nodes[i].mean - h->nodes[cur].mean;
               double weighted_delta = (delta * h->nodes[i].count) / h->nodes[cur].count;
               h->nodes[cur].mean += weighted_delta;
          } else {
               count_so_far += h->nodes[cur].count;
               cur++;
               h->nodes[cur] = h->nodes[i];
          }
          if (cur != i) {
               h->nodes[i] = (td_node_t) {
                    .mean = 0,
                    .count = 0,
               };
          }
     }
     h->merged_nodes = cur+1;
     h->merged_count = total_count;
     h->unmerged_nodes = 0;
     h->unmerged_count = 0;
}
/*******************/

void *td_serialize(td_histogram_t *p_key, int mode, char **buf, int *bufmalloclen, int *tdgsz)
{
  if(!buf || !p_key || mode < 1 || mode > 2) 
    return NULL;

  merge(p_key);

  int buflen = *bufmalloclen;

  /* Compute the buf size needed */
  int tentative_buf_size_needed = 16;
  int tmp_tentative_buf_size_needed = 0;

  if(mode == 1)
    tmp_tentative_buf_size_needed = sizeof(double);
  else 
    tmp_tentative_buf_size_needed += sizeof(float);

  tmp_tentative_buf_size_needed += sizeof(int);

  //int ncentroids = p_key->merged_nodes + p_key->unmerged_nodes;
  int ncentroids = td_centroid_count(p_key);


  tentative_buf_size_needed += tmp_tentative_buf_size_needed * ncentroids;

  if(!bufmalloclen || *bufmalloclen < tentative_buf_size_needed)
  {
    *buf = realloc(*buf, tentative_buf_size_needed);
    buflen = tentative_buf_size_needed;
  }

  int index = 0;

  /* #1 - Write mode */
  memcpy(*buf + index, &mode, sizeof(int));
  index += sizeof(int);

  /* #2 - Write Compression Factor */
  double compression = 100.0;

  if(p_key->delta !=0.0) 
    compression = 1.0 / p_key->delta;

  //memcpy(*buf + index, &(p_key->delta), sizeof(double));
  memcpy(*buf + index, &compression, sizeof(double));
  index += sizeof(double);

  /* #3 - Write Number of Centroids */
  memcpy(*buf + index, &ncentroids, sizeof(int));
  index += sizeof(int);

  /* #4 - Now write means for all centroids one by one */
  int i = 0;
  
  double x = 0;
  float ddd = 0;
  td_node_t *c = NULL;
  for(i=0; i<ncentroids; i++)
  {
    c = &p_key->nodes[i];
    switch(mode)
    {
    case 1:
      memcpy(*buf + index, &c->mean, sizeof(double));
      index += sizeof(double);
      break;

    case 2:
      ddd = (float) (c->mean - x);
      memcpy(*buf + index, &ddd, sizeof(float));
      x = c->mean;
      index += sizeof(float);
      break;

    default:
      break;
    }
  }

  /* #5 - Now write counts for all centroids one by one */
  int n; char b;
  for(i=0; i<ncentroids; i++)
  {
    c = &p_key->nodes[i];
    switch(mode)
    {
    case 1:
      memcpy(*buf + index, &c->count, sizeof(int));
      index += sizeof(int);
      break;

    case 2:
      n = c->count;
      while (n < 0 || n > 0x7f) {
        b = (char) (0x80 | (0x7f & n));
        memcpy(*buf + index++, &b, sizeof(char));
        n = n >> 7;
      }
      memcpy(*buf + index++, (char *) &n, sizeof(char));
      break;

    default:
      break;
    }
  }

  *tdgsz = index;
  *bufmalloclen = buflen;
  return *buf;
}

td_histogram_t *td_deserialize(char *buf, unsigned int K)
{
  if(!buf)
    return NULL;

  if(K == 0) K = 100;

  td_histogram_t *tdigest;

  int mode = 0, ncentroids = 0;

  int index = 0;

  /* #1 - Read mode */
  memcpy(&mode, buf + index, sizeof(int));
  index += sizeof(int);

  /* #2 - read Compression Factor */
  double compression;

  memcpy(&compression, buf + index, sizeof(double));
  index += sizeof(double);

  /* #3 - Read Number of Centroids */
  memcpy(&ncentroids, buf + index, sizeof(int));
  index += sizeof(int);

  /* #4 - Now Create a new td_histogram_t */
  double delta = 1.0/100.0;
  if(compression != 0.0) delta = 1.0/compression;
  tdigest = td_new(delta, K);

  /* #5 - Now read means for all centroids one by one */
  int i;

  double  *c_mean_arr = (double*) malloc(ncentroids * sizeof(double));
  double x = 0.0;
  float diff = 0.0;
  for(i=0; i<ncentroids; i++)
  {
    switch(mode)
    {
    case 1:
      memcpy(&c_mean_arr[i], buf + index, sizeof(double));
      index += sizeof(double);
      break;

    case 2:
      memcpy(&diff, buf + index, sizeof(float));
      c_mean_arr[i] = x + diff;
      x = c_mean_arr[i];
      index += sizeof(float);
      break;

    default:
      break;
    }
  }

  /* #6 - Now read counts for all centroids one by one and add in the tdigest*/
  char b;
  int count = 0;
  for(i=0; i<ncentroids; i++)
  {
    switch(mode)
    {
    case 1:
      memcpy(&count, buf + index, sizeof(int));
      index += sizeof(int);
      break;

    case 2:
      count = 0;
      char segarr[5]; /* 7 bit segments */
      int seg_index = 0;
      while (1)
      {
        memcpy(&b, buf + index, sizeof(char));
        segarr[seg_index] = b & 0x7f;
        seg_index++; index++;
        if(!(b & 0x80))
          break;
      }
      int j;
      for(j=seg_index -1; j>=0; j--)
      {
        count = count << 7;
        count += segarr[j];
      }
      break;

    default:
      break;
    }
    td_add(tdigest, c_mean_arr[i], count);
  }

  free(c_mean_arr); 
  return tdigest;
}

/* For printing debug information about serialized tdigest */
int td_debug(char *buf)
{
  if(!buf)
    return -1;

  int mode = 0, ncentroids = 0;

  int index = 0;

  printf("Mode = %d, ", *((int *)(buf + index)));
  mode = *((int *)(buf + index));
  index += sizeof(int);

  printf("Compression = %f, ", *((double *)(buf + index)));
  index += sizeof(double);

  printf("Num Centroids = %d\n", *((int *)(buf + index)));
  ncentroids = *((int *)(buf + index));
  index += sizeof(int);


  int i;
  double *c_mean_arr = (double*) malloc(ncentroids * sizeof(double));
  double x = 0.0;
  float diff = 0.0;
  for(i=0; i<ncentroids; i++)
  {
    switch(mode)
    {
    case 1:
      memcpy(&c_mean_arr[i], buf + index, sizeof(double));
      index += sizeof(double);
      break;

    case 2:
      memcpy(&diff, buf + index, sizeof(float));
      c_mean_arr[i] = x + diff;
      x = c_mean_arr[i];
      index += sizeof(float);
      break;

    default:
      break;
    }
  }

  printf("Centroid# |    Mean    |  Count\n");
  printf("==========|============|========\n");
  char b;
  int count = 0;
  double prev_mean = -1;
  int prev_count = -1;
  char flag_printed_astrisk = 0;
  int total_data_count = 0;

  for(i=0; i<ncentroids; i++)
  {
    switch(mode)
    {
    case 1:
      memcpy(&count, buf + index, sizeof(int));
      index += sizeof(int);
      break;

    case 2:
      count = 0;
      char segarr[5]; /* 7 bit segments */
      int seg_index = 0;
      while (1)
      {
        memcpy(&b, buf + index, sizeof(char));
        segarr[seg_index] = b & 0x7f;
        seg_index++; index++;
        if(!(b & 0x80))
          break;
      }
      int j;
      for(j=seg_index -1; j>=0; j--)
      {
        count = count << 7;
        count += segarr[j];
      }
      break;

    default:
      break;
    }
    if(prev_mean != c_mean_arr[i] || prev_count != count)
    {
      printf("%9d | %10f | %4d\n", i, c_mean_arr[i], count);
      flag_printed_astrisk = 0;
      prev_mean = c_mean_arr[i];
      prev_count = count;
    }
    else if (!flag_printed_astrisk)
    {
      printf("***\n");
      flag_printed_astrisk = 1;
    }
    total_data_count += count;
  }
  printf("Total data count = %d\n", total_data_count); 
  free(c_mean_arr);
  return 0;
}

/* For printing debug information about serialized tdigest */
int td_debug_dump_output_in_buf(char *buf, char *out_buf)
{
  if(!buf || !out_buf)
    return -1;

  int mode = 0, ncentroids = 0;
  int index = 0;
  int len = 0, length = 0; 
  
  mode = *((int *)(buf + index));
  length = sprintf(out_buf + len, "Mode = %d, ", mode);
  len    = len + length;
  index += sizeof(int);

  length = sprintf(out_buf + len, "Compression = %f, ", *((double *)(buf + index)));
  len    = len + length;
  index += sizeof(double);

  ncentroids = *((int *)(buf + index));
  length = sprintf(out_buf + len, "Num Centroids = %d\n", ncentroids);
  len    = len + length;
  index += sizeof(int);

  int i;
  double *c_mean_arr = (double*) malloc(ncentroids * sizeof(double));
  double x = 0.0;
  float diff = 0.0;
  for(i=0; i<ncentroids; i++)
  {
    switch(mode)
    {
    case 1:
      memcpy(&c_mean_arr[i], buf + index, sizeof(double));
      index += sizeof(double);
      break;

    case 2:
      memcpy(&diff, buf + index, sizeof(float));
      c_mean_arr[i] = x + diff;
      x = c_mean_arr[i];
      index += sizeof(float);
      break;
    default:
      break;
    }
  }

  length = sprintf(out_buf + len, "Centroid# |    Mean    |  Count\n==========|============|========\n");
  len    = len + length;

  char b;
  int count = 0;
  double prev_mean = -1;
  int prev_count = -1;
  char flag_printed_astrisk = 0;
  int total_data_count = 0;

  for(i=0; i<ncentroids; i++)
  {
    switch(mode)
    {
    case 1:
      memcpy(&count, buf + index, sizeof(int));
      index += sizeof(int);
      break;

    case 2:
      count = 0;
      char segarr[5]; /* 7 bit segments */
      int seg_index = 0;
      while (1)
      {
        memcpy(&b, buf + index, sizeof(char));
        segarr[seg_index] = b & 0x7f;
        seg_index++; index++;
        if(!(b & 0x80))
          break;
      }
      int j;
      for(j=seg_index -1; j>=0; j--)
      {
        count = count << 7;
        count += segarr[j];
      }
      break;

    default:
      break;
    }
    if(prev_mean != c_mean_arr[i] || prev_count != count)
    {
      length = sprintf(out_buf + len, "%9d | %10f | %4d\n", i, c_mean_arr[i], count);
      len = len + length;
      flag_printed_astrisk = 0;
      prev_mean = c_mean_arr[i];
      prev_count = count;
    }
    else if (!flag_printed_astrisk)
    {
      length = sprintf(out_buf + len, "***\n");
      len = len + length;
      flag_printed_astrisk = 1;
    }
    total_data_count += count;
  }
  sprintf(out_buf +len, "Total Data Count = %d\n", total_data_count); 
  free(c_mean_arr);
  return 0;
}
