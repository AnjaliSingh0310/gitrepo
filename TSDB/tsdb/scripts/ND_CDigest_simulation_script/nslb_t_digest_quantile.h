/***************************************************************************************************
*
*    File     : nslb_t_digest_quantile.h
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
#ifndef NSLB_T_DIGEST_QUANTILE_H
#define NSLB_T_DIGEST_QUANTILE_H
#include <stddef.h>
#include "tdigest.h"


#define tdg_key td_histogram_t

//delta: The compression factor, the max fraction of mass that can be owned by one centroid (bigger, up to 1.0, means more compression).
//K:     A size threshold that triggers recompression as the TDigest grows during input

extern void t_digest_insert(tdg_key **p_key, double mean, int count);
extern void nslb_t_digest_merge(tdg_key **p_key1, tdg_key *p_key2);
extern double nslb_t_digest_getquantile_at(tdg_key *p_key, double quantile);
extern void nslb_t_digest_destroy(tdg_key *p_key);
extern void nslb_t_digest_reset(tdg_key *p_key);
extern tdg_key *nslb_t_digest_deserialize(char *buf, unsigned int K);
extern void *t_digest_serialize(tdg_key *p_key, int mode, char **buf, int *bufmalloclen, int *tdgsz);
extern int nslb_t_digest_get_ncentroids(tdg_key *p_key);
extern void t_digest_init(tdg_key **p_key, double delta, unsigned int K);
extern int nslb_t_digest_get_data_count(tdg_key *p_key);
extern int nslb_t_digest_debug(char *buf);
extern int nslb_t_digest_debug_ex(char *buf, char *out_buf);
extern double nslb_t_digest_getquantile_of(tdg_key *p_key, double value);
#endif
