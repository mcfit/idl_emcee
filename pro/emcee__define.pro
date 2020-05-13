; docformat = 'rst'

;+
;     "Unit for affine-invariant MCMC Hammer (emcee)": 
;     This obejct library can be used to create the 
;     affine-invariant Markov chain Monte Carlo (MCMC) 
;     ensemble sampler, which can be used to propagate
;     uncertainties into the given function.
;
; :Examples:
;    For example::
;
;     IDL> mc=obj_new('emcee')
;     IDL> mcmc_sim=mc->hammer('myfunc', input, input_err_m, input_err_p, output)
;     IDL> output_error=mc->func_erros(output, mcmc_sim)
;          
;
; :Categories:
;   MCMC, Uncertainty
;
; :Dirs:
;  ./
;      Main routines
;
; :Author:
;   Ashkbiz Danehkar
;
; :Copyright:
;   This library is released under a GNU General Public License.
;
; :Version:
;   0.2.0
;
; :History:
;
;     12/05/2020, A. Danehkar, Create object-oriented programming (OOP).
;-
function emcee::init
  self.walk_num=30
  self.iteration_num=500
  self.use_gaussian=0 ; uniform distribution from min value to max value
  ;self.use_gaussian=1 ; gaussian distribution from min value to max value
  self.clevel=0.90   ; 1.645-sigma,
  ;self.clevel=0.38292492 ; 0.5-sigma,
  ;self.clevel=0.68268949 ; 1.0-sigma,
  ;self.clevel=0.86638560 ; 1.5-sigma,
  ;self.clevel=0.90       ; 1.645-sigma,
  ;self.clevel=0.95       ; 1.960-sigma,
  ;self.clevel=0.95449974 ; 2.0-sigma,
  ;self.clevel=0.98758067 ; 2.5-sigma,
  ;self.clevel=0.99       ; 2.575-sigma,
  ;self.clevel=0.99730020 ; 3.0-sigma,
  ;self.clevel=0.99953474 ; 3.5-sigma,
  ;self.clevel=0.99993666 ; 4.0-sigma,
  ;self.clevel=0.99999320 ; 4.5-sigma,
  ;self.clevel=0.99999943 ; 5.0-sigma,
  ;self.clevel=0.99999996 ; 5.5-sigma,
  ;self.clevel=0.999999998; 6.0-sigma.
  return,1
end

function emcee::free
  return,1
end

function emcee::hammer, fcn, input, input_err_m, input_err_p, output, $
                        walk_num=walk_num, iteration_num=iteration_num, use_gaussian=use_gaussian, $
                        FUNCTARGS=fcnargs
;+
;     This function runs the affine-invariant MCMC Hammer, 
;     and returns the MCMC simulations
;
; :Returns:
;    type=arrays. This function returns the results of the MCMC simulations.
;
; :Keywords:
;     FUNCTARGS    :  in, not required, type=parameter
;                     the function arguments (not used for MCMC)
;
; :Params:
;     fcn          :  in, required, type=string
;                     the calling function name
;
;     input        :  in, required, type=float
;                     the input parameters array used by the calling function.
;
;     input_err_m  :  in, required, type=float
;                     the lower limit uncertainty array of the parameters 
;                     for the calling function.
;
;     input_err_p  :  in, required, type=float
;                     the upper limit uncertainty array of the parameters 
;                     for the calling function.
;
;     output       :  in, required, type=arrays
;                     the output array returned by the calling function.
;
;     walk_num     :  in, required, type=integer
;                     the number of the random walkers 
;
;     iteration_num:  in, required, type=integer
;                     the number of the MCMC iteration
;
;     use_gaussian  :  in, required, type=boolean
;                      if sets to 1, the walkers are initialized as a gaussian 
;                      over the specified range between the min and max values of 
;                      each free parameter, 
;                      otherwise, the walkers are initialized uniformly over 
;                      the specified range between the min and max values of 
;                      each free parameter.
;    
; :Examples:
;    For example::
;
;     IDL> mc=obj_new('emcee')
;     IDL> mcmc_sim=mc->hammer('myfunc', input, input_err, output, $
;     IDL>                      walk_num=walk_num, iteration_num=iteration_num, $
;     IDL>                      use_gaussian=use_gaussian)
;
; :Categories:
;   MCMC
;
; :Dirs:
;  ./
;      Main routines
;
; :Author:
;   Ashkbiz Danehkar
;
; :Copyright:
;   This library is released under a GNU General Public License.
;
; :Version:
;   0.2.0
;
; :History:
;     15/03/2017, A. Danehkar, IDL code written
;                 Adopted from emcee() of sl_emcee 
;                 by M.A. Nowak included in isisscripts
;
;     01/05/2020, A. Danehkar, function arguments added
;     
;     12/05/2020, A. Danehkar, Move to object-oriented programming (OOP).
;-
  if keyword_set(walk_num) eq 1 then begin
    self.walk_num = walk_num
  endif
  if keyword_set(iteration_num) eq 1 then begin
    self.iteration_num = iteration_num
  endif
  if keyword_set(use_gaussian) eq 1 then begin
    self.use_gaussian = use_gaussian
  endif
  mcmc_sim=emcee_hammer(fcn, input, input_err_m, input_err_p, output, $
                        self.walk_num, self.iteration_num, self.use_gaussian, $
                        FUNCTARGS=fcnargs)
  return, mcmc_sim                        
end

function emcee::func_erros, output, mcmc_sim, clevel=clevel, do_plot=do_plot, $
                            image_output_path=image_output_path
;+
;     This function returns the uncertainties of the function outputs 
;     based on the confidence level.
;
; :Returns:
;    type=arrays. This function returns uncertainties.
;
; :Keywords:
;     do_plot  :  in, optional, type=boolean
;                 set to plot a normalized histogram of the MCMC chain
;
;     image_output_path    :    in, optional, type=string
;                               the image output path
;
; :Params:
;     output   :  in, required, type=arrays   
;                 the output array returned by the calling function.
;     
;     mcmc_sim :  in, required, type=arrays  
;                 the results of the MCMC simulations from emcee_hammer().
;     
;     clevel   :  in, required, type=float
;                 the confidence level for the the lower and upper limits. 
;                 clevel=0.38292492 ; 0.5-sigma, 
;                 clevel=0.68268949 ; 1.0-sigma, 
;                 clevel=0.86638560 ; 1.5-sigma, 
;                 clevel=0.90       ; 1.645-sigma, 
;                 clevel=0.95       ; 1.960-sigma, 
;                 clevel=0.95449974 ; 2.0-sigma, 
;                 clevel=0.98758067 ; 2.5-sigma, 
;                 clevel=0.99       ; 2.575-sigma, 
;                 clevel=0.99730020 ; 3.0-sigma, 
;                 clevel=0.99953474 ; 3.5-sigma, 
;                 clevel=0.99993666 ; 4.0-sigma, 
;                 clevel=0.99999320 ; 4.5-sigma, 
;                 clevel=0.99999943 ; 5.0-sigma, 
;                 clevel=0.99999996 ; 5.5-sigma, 
;                 clevel=0.999999998; 6.0-sigma.
;    
; :Examples:
;    For example::
;
;     IDL> mc=obj_new('emcee')
;     IDL> mcmc_sim=mc->hammer('myfunc', input, input_err, output)
;     IDL> output_error=mc->func_erros(output, mcmc_sim, clevel=clevel)
;
; :Categories:
;   MCMC, Uncertainty
;
; :Dirs:
;  ./
;      Main routines
;
; :Author:
;   Ashkbiz Danehkar
;
; :Copyright:
;   This library is released under a GNU General Public License.
;
; :Version:
;   0.2.0
;
; :History:
;     15/03/2017, A. Danehkar, IDL code written
;                 Adopted from chain_hist() of sl_emcee 
;                 by M.A. Nowak included in isisscripts
;     
;     12/05/2020, A. Danehkar, Move to object-oriented programming (OOP).
;-
  if keyword_set(clevel) eq 1 then begin
    self.clevel = clevel
  endif              
  output_error=emcee_func_erros(output, mcmc_sim, self.clevel, $
                                do_plot=do_plot, image_output_path=image_output_path)    
  return, output_error                 
end              
;-------------
pro emcee::set_walk_num, walk_num
  if walk_num ne '' then self.walk_num=walk_num else print, 'Error: walk_num is not given'
  return
end

function emcee::get_walk_num
  if self.walk_num ne '' then walk_num=self.walk_num else print, 'Error: walk_num is not given'
  return, walk_num
end
;-------------
pro emcee::set_iteration_num, iteration_num
  if iteration_num ne '' then self.iteration_num=iteration_num else print, 'Error: iteration_num is not given'
  return
end

function emcee::get_iteration_num
  if self.iteration_num ne '' then iteration_num=self.iteration_num else print, 'Error: iteration_num is not given'
  return, iteration_num
end
;-------------
pro emcee::set_use_gaussian, use_gaussian
  if use_gaussian ne '' then self.use_gaussian=use_gaussian else print, 'Error: use_gaussian is not given'
  return
end

function emcee::get_use_gaussian
  if self.use_gaussian ne '' then use_gaussian=self.use_gaussian else print, 'Error: use_gaussian is not given'
  return, use_gaussian
end
;-------------
pro emcee::set_clevel, clevel
  if clevel ne '' then self.clevel=clevel else print, 'Error: clevel is not given'
  return
end

function emcee::get_clevel
  if self.clevel ne '' then clevel=self.clevel else print, 'Error: clevel is not given'
  return, clevel
end
;------------------------------------------------------------------
pro emcee__define
  void={emcee, walk_num:30, iteration_num:500, $
          use_gaussian:0, clevel:0.90}
  return 
end
