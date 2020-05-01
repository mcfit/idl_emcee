; docformat = 'rst'

function emcee_update_walk, fcn, random_num, x_a, x_b, $
                       FUNCTARGS=fcnargs
;+
;     This function creates the trial walker, examines 
;     whether it is acceptable, and returns the updated walker.
;
; :Returns:
;    type=arrays. This function returns the updated walker.
;
; :Keywords:
;     FUNCTARGS    :  in, optional, type=parameter
;                     the function arguments
;
; :Params:
;     fcn          :  in, required, type=string
;                     the calling function name.
;
;     random_num   :  in, required, type=integer
;                     the random number.
;
;     x_a          :  in, required, type=arrays
;                     the vector of the parameters 
;                     for a specific walker.
;
;     x_b          :  in, required, type=arrays
;                     the array of the walker parameters.
;
; :Examples:
;    For example::
;
;     IDL> x_output[j,*]=emcee_update_walk(fcn,a_random[random_num[j],*],$
;     IDL>                                 array_xwalk,x_walk[*,b_walk])
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
;                 Adopted from update_walker() of sl_emcee 
;                 by M.A. Nowak included in isisscripts
;
;     01/05/2020, A. Danehkar, function arguments added 
;-
  adjust_scale_low = 2.0
  adjust_scale_high = 2.0
  temp=size(x_b,/DIMENSIONS)
  par_num=temp[0]
  b_num=temp[1]
  x_chosen = x_b[*,long(random_num[0]*b_num)]
  ; print, long(random_num[0]*b_num)
  z = emcee_inv_tot_dist(random_num[1],adjust_scale_low,adjust_scale_high);
  x_chosen = x_chosen + z*(x_a-x_chosen)
  if keyword_set(fcnargs) then x_output = call_function(fcn, x_chosen, FUNCTARGS=fcnargs) else x_output = call_function(fcn, x_chosen)
  return, x_output
end
