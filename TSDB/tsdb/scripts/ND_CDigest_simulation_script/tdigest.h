#ifndef _T_DIGEST_H_
#define _T_DIGEST_H_

////////////////////////////////////////////////////////////////////////////////
// tdigest
//
// Copyright (c) 2018 Andrew Werner, All rights reserved.
//
// tdigest is an implementation of Ted Dunning's streaming quantile estimation
// data structure. 
// This implementation is intended to be like the new MergingHistogram.
// It focuses on being in portable C that should be easy to integrate into other
// languages. In particular it provides mechanisms to preallocate all memory 
// at construction time.
//
// The implementation is a direct descendent of 
//  https://github.com/tdunning/t-digest/
//
// TODO: add a Ted Dunning Copyright notice.
//
////////////////////////////////////////////////////////////////////////////////

#include <stdlib.h>

typedef struct td_node {
     double mean;
     double count;
} td_node_t;


struct td_histogram {
     // compression is a setting used to configure the size of centroids when merged.
     double delta; 
     int K;
     double compression; 
     
     // cap is the total size of nodes
     int cap;
     // merged_nodes is the number of merged nodes at the front of nodes.
     int merged_nodes;
     // unmerged_nodes is the number of buffered nodes.
     int unmerged_nodes;
     
     double merged_count;
     double unmerged_count;
     
     td_node_t nodes[0];
};


typedef struct td_histogram td_histogram_t;

// td_new allocates a new histogram.
// It is similar to init but assumes that it can use malloc.
td_histogram_t *td_new(double delta, unsigned int K);

// td_free frees the memory associated with h.
void td_free(td_histogram_t *h);

// td_add adds val to h with the specified count.
void td_add(td_histogram_t *h, double val, double count);

// td_merge merges the data from from into into.
void td_merge(td_histogram_t *into, td_histogram_t *from);
void merge(td_histogram_t *h) ;

// td_reset resets a histogram.
void td_reset(td_histogram_t *h);

// td_value_at queries h for the value at q.
// If q is not in [0, 1], NAN will be returned.
double td_value_at(td_histogram_t *h, double q);

// td_value_at queries h for the quantile of val.
// The returned value will be in [0, 1].
double td_quantile_of(td_histogram_t *h, double val);

// td_total_count returns the total count contained in h.
double td_total_count(td_histogram_t *h);

// td_decay multiplies all countes by factor.
double td_decay(td_histogram_t *h, double factor);

td_histogram_t *td_deserialize(char *buf, unsigned int K);
void *td_serialize(td_histogram_t *p_key, int mode, char **buf, int *bufmalloclen, int *tdgsz);
int td_debug(char *buf);
int td_debug_dump_output_in_buf(char *buf, char *out_buf);
int td_centroid_count(td_histogram_t *p_key);
#endif

