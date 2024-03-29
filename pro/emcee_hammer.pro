; docformat = 'rst'

function emcee_hammer, fcn, input, input_err_m, input_err_p, output, $
                      walk_num, iteration_num, use_gaussian, $
                      print_progress=print_progress, FUNCTARGS=fcnargs
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
;     print_progress  :  in, not required, type=parameter
;                     print the progress percentage of the MCMC sampler.  
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
;     IDL> mcmc_sim=emcee_hammer('myfunc', input, input_err, output, $
;     IDL>                        walk_num, iteration_num, use_gaussian)
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
;   0.1.0
;
; :History:
;     15/03/2017, A. Danehkar, IDL code written
;                 Adopted from emcee() of sl_emcee 
;                 by M.A. Nowak included in isisscripts
;
;     01/05/2020, A. Danehkar, function arguments added 
;-
  temp=size(output,/DIMENSIONS)
  output_num=temp[0]
  x_walk=emcee_initialize(fcn, input, input_err_m, input_err_p, $
                        walk_num, output_num, use_gaussian, $
                        FUNCTARGS=fcnargs)
  temp=size(input,/DIMENSIONS)
  input_num=temp[0]
    
  total_walk_num = walk_num*input_num
  a_walk=long(indgen(total_walk_num/2+(total_walk_num mod 2))*2)
  b_walk=long(indgen(total_walk_num/2)*2 + 1)
  
  temp=size(a_walk,/DIMENSIONS)
  a_num=temp[0]
  temp=size(b_walk,/DIMENSIONS)
  b_num=temp[0]
  
  array_xwalk = dblarr(input_num);
  x_output = dblarr(max([a_num,b_num]),output_num);
  
  a_random=dblarr(iteration_num*a_num,3)
  b_random=dblarr(iteration_num*b_num,3)
  for i=0L, iteration_num*a_num-1 do begin
    a_random[i,0]=randomu(seed)
    a_random[i,1]=randomu(seed)
    a_random[i,2]=randomu(seed)
  endfor
  for i=0L, iteration_num*b_num-1 do begin
    b_random[i,0]=randomu(seed)
    b_random[i,1]=randomu(seed)
    b_random[i,2]=randomu(seed)
  endfor
  x_out=dblarr(a_num+b_num,output_num)
  mcmc_sim=dblarr(iteration_num,a_num+b_num,output_num)
  ;sim1=dblarr(iteration_num,a_num+b_num)
  print_progress_step=iteration_num/10
  if (i mod print_progress_step eq 0) then begin
     print, 'Progress (%):', Format='(A,$)'
  endif
  for i=0L, iteration_num-1 do begin
    ; first half of walkers 
    random_num = i*a_num+indgen(a_num)
    for j=0L, a_num-1 do begin
       array_xwalk= x_walk[*,a_walk[j]]
       x_output[j,*]=emcee_update_walk(fcn,a_random[random_num[j],*],array_xwalk,x_walk[*,b_walk], $
                        FUNCTARGS=fcnargs)
    endfor
    for j=0L, a_num-1 do begin
       x_out[a_walk[j],*] = x_output[j,*];
    endfor
    ; second half of walkers 
    random_num = i*b_num+indgen(b_num)
    for j=0L, b_num-1 do begin
       array_xwalk= x_walk[*,b_walk[j]]
       x_output[j,*]=emcee_update_walk(fcn,b_random[random_num[j],*],array_xwalk,x_walk[*,a_walk], $
                        FUNCTARGS=fcnargs)
    endfor
    for j=0L, b_num-1 do begin
       x_out[b_walk[j],*] = x_output[j,*];
    endfor
    for j=0L, output_num-1 do begin
       mcmc_sim[i,*,j]=x_out[*,j]
    endfor
    if keyword_set(print_progress) then begin
       if (i mod print_progress_step eq 0) then begin
          print, ' '+strtrim(string(long(float(i)/float(iteration_num)*100)),2), Format='(A,$)'
       endif
    endif
  endfor
  if keyword_set(print_progress) then begin
     print, ' 100'
  endif
  return, mcmc_sim
end
