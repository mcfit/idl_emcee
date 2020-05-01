/* Index used for searching */
/*
   Fields used:
     url, name, type, filename, authors, routine name, comments, parameters,
     categories, and attributes
*/
title = "API Documentation for idl-emcee";
subtitle = "IDL Library for affine-invariant MCMC Ensemble Sampler";
libdata = new Array();
libdataItem = 0;



libdata[libdataItem++] = new Array("./emcee_func_erros.html", "emcee_func_erros.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "emcee_func_erros.pro", "", "", "", "", "          -1", "");
  
  
  libdata[libdataItem++] = new Array("./emcee_func_erros.html#emcee_func_erros", "emcee_func_erros", 'routine in <a href="./emcee_func_erros.html">emcee_func_erros.pro</a>', "emcee_func_erros.pro", "   Ashkbiz Danehkar   ", "emcee_func_erros", "     This function returns the uncertainties of the function outputs      based on the confidence level.   ", "do_plot                 set to plot a normalized histogram of the MCMC chain   output                 the output array returned by the calling function.   mcmc_sim                 the results of the MCMC simulations from emcee_hammer().   clevel                 the confidence level for the the lower and upper limits.                  clevel=0.38292492 ; 0.5-sigma,                  clevel=0.68268949 ; 1.0-sigma,                  clevel=0.86638560 ; 1.5-sigma,                  clevel=0.90       ; 1.645-sigma,                  clevel=0.95       ; 1.960-sigma,                  clevel=0.95449974 ; 2.0-sigma,                  clevel=0.98758067 ; 2.5-sigma,                  clevel=0.99       ; 2.575-sigma,                  clevel=0.99730020 ; 3.0-sigma,                  clevel=0.99953474 ; 3.5-sigma,                  clevel=0.99993666 ; 4.0-sigma,                  clevel=0.99999320 ; 4.5-sigma,                  clevel=0.99999943 ; 5.0-sigma,                  clevel=0.99999996 ; 5.5-sigma,                  clevel=0.999999998; 6.0-sigma.   ", "MCMC Uncertainty", "   0.1.0        15/03/2017, A. Danehkar, IDL code written                  Adopted from chain_hist() of sl_emcee                  by M.A. Nowak included in isisscripts     This library is released under a GNU General Public License.       For example: <span class= code-prompt >IDL&gt;</span> output_error=emcee_func_erros(output, mcmc_sim, clevel)      type=arrays. This function returns uncertainties.   ");
  
  

libdata[libdataItem++] = new Array("./emcee_hammer.html", "emcee_hammer.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "emcee_hammer.pro", "", "", "", "", "          -1", "");
  
  
  libdata[libdataItem++] = new Array("./emcee_hammer.html#emcee_hammer", "emcee_hammer", 'routine in <a href="./emcee_hammer.html">emcee_hammer.pro</a>', "emcee_hammer.pro", "   Ashkbiz Danehkar   ", "emcee_hammer", "     This function runs the affine-invariant MCMC Hammer,      and returns the MCMC simulations   ", "FUNCTARGS                     the function arguments (not used for MCMC)   fcn                     the calling function name   input                     the input parameters array used by the calling function.   input_err_m                     the lower limit uncertainty array of the parameters                      for the calling function.   input_err_p                     the upper limit uncertainty array of the parameters                      for the calling function.   output                     the output array returned by the calling function.   walk_num                     the number of the random walkers   iteration_num                     the number of the MCMC iteration   use_gaussian                      if sets to 1, the walkers are initialized as a gaussian                       over the specified range between the min and max values of                       each free parameter,                       otherwise, the walkers are initialized uniformly over                       the specified range between the min and max values of                       each free parameter.   ", "MCMC", "   0.1.0        15/03/2017, A. Danehkar, IDL code written                  Adopted from emcee() of sl_emcee                  by M.A. Nowak included in isisscripts       01/05/2020, A. Danehkar, function arguments added     This library is released under a GNU General Public License.       For example: <span class= code-prompt >IDL&gt;</span> mcmc_sim=emcee_hammer('myfunc', input, input_err, output, $ <span class= code-prompt >IDL&gt;</span>                        walk_num, iteration_num, use_gaussian)      type=arrays. This function returns the results of the MCMC simulations.   ");
  
  

libdata[libdataItem++] = new Array("./emcee_initialize.html", "emcee_initialize.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "emcee_initialize.pro", "", "", "", "", "          -1", "");
  
  
  libdata[libdataItem++] = new Array("./emcee_initialize.html#emcee_initialize", "emcee_initialize", 'routine in <a href="./emcee_initialize.html">emcee_initialize.pro</a>', "emcee_initialize.pro", "   Ashkbiz Danehkar   ", "emcee_initialize", "     This function returne the initialized walkers for each free parameter.   ", "FUNCTARGS                     the function arguments (not used for MCMC)   fcn                     the calling function name   param                     the input parameters array used by                      the calling function.   param_err_m                     the lower limit uncertainty array of                       the parameters for the calling function.   param_err_p                     the upper limit uncertainty array of                       the parameters for the calling function.   walk_num                     the number of the random walkers.   output_num                     the number of the output array returned                      by the calling function.   use_gaussian                      if sets to 1, the walkers are initialized as a gaussian                       over the specified range between the min and max values of                       each free parameter,                       otherwise, the walkers are initialized uniformly over                       the specified range between the min and max values of                       each free parameter.   ", "MCMC", "   0.1.0        15/03/2017, A. Danehkar, IDL code written                  Adopted from emcee() of sl_emcee                  by M.A. Nowak included in isisscripts       01/05/2020, A. Danehkar, function arguments added     This library is released under a GNU General Public License.       For example: <span class= code-prompt >IDL&gt;</span> x_walk=emcee_initialize(fcn, input, input_err, walk_num, $ <span class= code-prompt >IDL&gt;</span>                         output_num, use_gaussian))      type=arrays. This function returns the initialized walker.   ");
  
  

libdata[libdataItem++] = new Array("./emcee_inv_tot_dist.html", "emcee_inv_tot_dist.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "emcee_inv_tot_dist.pro", "", "", "", "", "          -1", "");
  
  
  libdata[libdataItem++] = new Array("./emcee_inv_tot_dist.html#emcee_inv_tot_dist", "emcee_inv_tot_dist", 'routine in <a href="./emcee_inv_tot_dist.html">emcee_inv_tot_dist.pro</a>', "emcee_inv_tot_dist.pro", "   Ashkbiz Danehkar   ", "emcee_inv_tot_dist", "     This function returne the inverse Cumulative Distribution Function: 1/sqrt(z)      if the random number generator z is between 1/z_a and z_b, is used      to generate for a 1/sqrt(z) probability distribution.   ", "z                the a random number generator for the probability                 distribution 1/sqrt(z).   z_a                the inverse lower limit for the random number                 generator z: 1/z_a &lt;= z.   z_b                the higher limit for the random number                 generator z: z &lt;= b.   ", "MCMC", "   0.1.0        15/03/2017, A. Danehkar, IDL code written                  Adopted from icdf() of sl_emcee                  by M.A. Nowak included in isisscripts     This library is released under a GNU General Public License.       For example: <span class= code-prompt >IDL&gt;</span> z = emcee_inv_tot_dist(random_num, adjust_scale_low, adjust_scale_high);      type=arrays. This function returns the lower and higher                  linear histogram grids (hist_lo, hist_hi)   ");
  
  

libdata[libdataItem++] = new Array("./emcee_linear_grid.html", "emcee_linear_grid.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "emcee_linear_grid.pro", "", "", "", "", "          -1", "");
  
  
  libdata[libdataItem++] = new Array("./emcee_linear_grid.html#emcee_linear_grid", "emcee_linear_grid", 'routine in <a href="./emcee_linear_grid.html">emcee_linear_grid.pro</a>', "emcee_linear_grid.pro", "   Ashkbiz Danehkar   ", "emcee_linear_grid", "     This procedure generates a linear grid of histogram bins.   ", "x_min                 the lower limit.   x_max                 the higher limit.   nbins                 the bins number.   hist_lo                 returns the lower linear histogram grid,   hist_hi                 returns the higher linear histogram grid.   ", "MCMC", "   0.1.0        15/03/2017, A. Danehkar, IDL code written                  Adopted from the S-Lang function linear_grid() in isis.     This library is released under a GNU General Public License.       For example: <span class= code-prompt >IDL&gt;</span> x_min=1 <span class= code-prompt >IDL&gt;</span> x_max=20 <span class= code-prompt >IDL&gt;</span> nbins=1000 <span class= code-prompt >IDL&gt;</span> emcee_linear_grid, x_min, x_max, nbins, lo, hi  ");
  
  

libdata[libdataItem++] = new Array("./emcee_update_walk.html", "emcee_update_walk.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "emcee_update_walk.pro", "", "", "", "", "          -1", "");
  
  
  libdata[libdataItem++] = new Array("./emcee_update_walk.html#emcee_update_walk", "emcee_update_walk", 'routine in <a href="./emcee_update_walk.html">emcee_update_walk.pro</a>', "emcee_update_walk.pro", "   Ashkbiz Danehkar   ", "emcee_update_walk", "     This function creates the trial walker, examines      whether it is acceptable, and returns the updated walker.   ", "FUNCTARGS                     the function arguments   fcn                     the calling function name.   random_num                     the random number.   x_a                     the vector of the parameters                      for a specific walker.   x_b                     the array of the walker parameters.   ", "MCMC", "   0.1.0        15/03/2017, A. Danehkar, IDL code written                  Adopted from update_walker() of sl_emcee                  by M.A. Nowak included in isisscripts       01/05/2020, A. Danehkar, function arguments added     This library is released under a GNU General Public License.       For example: <span class= code-prompt >IDL&gt;</span> x_output[j,*]=emcee_update_walk(fcn,a_random[random_num[j],*],$ <span class= code-prompt >IDL&gt;</span>                                 array_xwalk,x_walk[*,b_walk])      type=arrays. This function returns the updated walker.   ");
  
  
