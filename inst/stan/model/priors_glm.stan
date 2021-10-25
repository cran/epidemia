  
  // Log-priors for coefficients
       if (prior_dist == 1) target += normal_lpdf(z_beta | 0, 1);
  else if (prior_dist == 2) target += normal_lpdf(z_beta | 0, 1); // Student t via Cornish-Fisher expansion
  else if (prior_dist == 3) { // hs
    real log_half = -0.693147180559945286;
    target += normal_lpdf(z_beta | 0, 1);
    target += normal_lpdf(local[1] | 0, 1) - log_half;
    target += inv_gamma_lpdf(local[2] | 0.5 * prior_df, 0.5 * prior_df);
    target += normal_lpdf(global[1] | 0, 1) - log_half;
    target += inv_gamma_lpdf(global[2] | 0.5 * global_prior_df, 0.5 * global_prior_df);
    target += inv_gamma_lpdf(caux | 0.5 * slab_df, 0.5 * slab_df);
  }
  else if (prior_dist == 4) { // hs+
    real log_half = -0.693147180559945286;
    target += normal_lpdf(z_beta | 0, 1);
    target += normal_lpdf(local[1] | 0, 1) - log_half;
    target += inv_gamma_lpdf(local[2] | 0.5 * prior_df, 0.5 * prior_df);
    target += normal_lpdf(local[3] | 0, 1) - log_half;
    // unorthodox useage of prior_scale as another df hyperparameter
    target += inv_gamma_lpdf(local[4] | 0.5 * prior_scale, 0.5 * prior_scale);
    target += normal_lpdf(global[1] | 0, 1) - log_half;
    target += inv_gamma_lpdf(global[2] | 0.5 * global_prior_df, 0.5 * global_prior_df);
    target += inv_gamma_lpdf(caux | 0.5 * slab_df, 0.5 * slab_df);
  }
  else if (prior_dist == 5) { // laplace
    target += normal_lpdf(z_beta | 0, 1);
    target += exponential_lpdf(mix[1] | 1);
  }
  else if (prior_dist == 6) { // lasso
    target += normal_lpdf(z_beta | 0, 1);
    target += exponential_lpdf(mix[1] | 1);
    target += chi_square_lpdf(one_over_lambda[1] | prior_df[1]);
  }
  else if (prior_dist == 7) { // product_normal
    target += normal_lpdf(z_beta | 0, 1);
  }
  else if (prior_dist == 8) { // shifted gamma
    target += gamma_lpdf(-z_beta | prior_shape, 1.0 ./ prior_scale);
  }
  /* else prior_dist is 0 and nothing is added */
  
  if (has_intercept == 1) {
    if (prior_dist_for_intercept[1] == 1)  // normal
      target += normal_lpdf(gamma_raw | 0, 1);
    else if (prior_dist_for_intercept[1] == 2)  // student_t
      target += student_t_lpdf(gamma_raw | prior_df_for_intercept[1], 0, 1);
  }

