// flag indicating whether to draw from the prior
int<lower=0,upper=1> prior_PD;  // 1 = yes

// intercept
int<lower=0,upper=1> has_intercept;  // 1 = yes

// prior family: 0 = none, 1 = normal, 2 = student_t, 3 = hs, 4 = hs_plus, 
//   5 = laplace, 6 = lasso, 7 = product_normal
int<lower=0,upper=8> prior_dist;
int<lower=0,upper=2> prior_dist_for_intercept[has_intercept];
