; docformat = 'rst'

function emcee_initialize, fcn, param, param_err_m, param_err_p, $
                          walk_num, output_num, use_gaussian, $
                          FUNCTARGS=fcnargs
;+
;     This function returne the initialized walkers for each free parameter.
;
; :Returns:
;    type=arrays. This function returns the initialized walker.
;
; :Keywords:
;     FUNCTARGS    :  in, not required, type=parameter
;                     the function arguments (not used for MCMC)
;
;
; :Params:
;     fcn          :  in, required, type=string
;                     the calling function name
;
;     param        :  in, required, type=arrays
;                     the input parameters array used by 
;                     the calling function.
;
;     param_err_m  :  in, required, type=arrays 
;                     the lower limit uncertainty array of
;                      the parameters for the calling function.
;
;     param_err_p  :  in, required, type=arrays
;                     the upper limit uncertainty array of 
;                      the parameters for the calling function.
;
;     walk_num     :  in, required, type=integer
;                     the number of the random walkers.
;
;     output_num   :  in, required, type=integer
;                     the number of the output array returned 
;                     by the calling function.
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
;     IDL> x_walk=emcee_initialize(fcn, input, input_err, walk_num, $
;     IDL>                         output_num, use_gaussian))
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
  temp=size(param,/DIMENSIONS)
  param_num=temp[0]
  x_point=dblarr(param_num)
  x_low=dblarr(param_num)
  x_high=dblarr(param_num)
  x_start=dblarr(param_num, walk_num*param_num)
  x_out=dblarr(walk_num*param_num, output_num)
  for i=0, param_num-1 do begin
    x_point[i] = param[i]
    x_low[i]   = param[i]+param_err_m[i]
    x_high[i]  = param[i]+param_err_p[i]
    ;x_low[i]   = param[i]-param_err[i]
    ;x_high[i]  = param[i]+param_err[i]
  endfor
  use_gaussian=1
  if use_gaussian eq 1 then begin
    scale1=1./3.
  endif else begin
    scale1=1.
  endelse
  for j=0L, walk_num*param_num-1 do begin
    for i=0L, param_num-1 do begin
      if use_gaussian eq 1 then begin
        sigma1 = randomn(seed)
        if sigma1 lt 0 then begin
          x_start[i,j] = x_point[i] + sigma1*scale1*(x_point[i]-x_low[i])
        endif else begin
          x_start[i,j] = x_point[i] + sigma1*scale1*(x_high[i]-x_point[i])
        endelse
      endif else begin
        sigma1 = randomu(seed)
        x_start[i,j] = (1-scale1)*x_point[i] + scale1*(x_low[i]+(x_high[i]-x_low[i])*sigma1)
      endelse
      if x_start[i,j] lt x_low[i] then x_start[i,j] = x_low[i];
      if x_start[i,j] gt x_high[i] then x_start[i,j] = x_high[i];
    endfor
    ;x_out[j,*] = call_function(fcn, x_start[*,j])
  endfor  
  return, x_start
end 
