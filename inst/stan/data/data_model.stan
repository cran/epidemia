real<lower=0> carry; // carry is only used if link == 2
int<lower=1, upper=3> link; // the link function 1) log, 2) scaled_logit, 3) identity
matrix<lower=0,upper=1> [N2,M] vacc; // proportion of susceptibles vaccinated at each point in time
real<lower=0> pops[M]; // population of each group
int<lower=1> gen_len;
simplex[gen_len] gen; // fixed generation distribution using empirical data
int<lower=0, upper=1> pop_adjust; // whether to perform population adjustment or not
