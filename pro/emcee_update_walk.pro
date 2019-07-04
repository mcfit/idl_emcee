; docformat = 'rst'

function emcee_update_walk, fcn, random_num, x_a, x_b, $
                      par2=par2, par3=par3, par4=par4, par5=par5, $
                      par6=par6, par7=par7, par8=par8, par9=par9
;+
;     This function creates the trial walker, examines 
;     whether it is acceptable, and returns the updated walker.
;
; :Returns:
;    type=arrays. This function returns the updated walker.
;
; :Keywords:
;     par2         :  in, optional, type=parameter
;                     the second fixed parameters
;
;     par3         :  in, optional, type=parameter
;                     the thrid fixed parameters
;
;     parx         :  in, optional, type=parameter
;                     the x-th fixed parameters
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
;-

;, x_input, x_output, change_done
  adjust_scale_low = 2.0
  adjust_scale_high = 2.0
  temp=size(x_b,/DIMENSIONS)
  par_num=temp[0]
  b_num=temp[1]
  x_chosen = x_b[*,long(random_num[0]*b_num)]
  ; print, long(random_num[0]*b_num)
  z = emcee_inv_tot_dist(random_num[1],adjust_scale_low,adjust_scale_high);
  x_chosen = x_chosen + z*(x_a-x_chosen)
  st1 = keyword_set(par2) and not keyword_set(par3) and not keyword_set(par4) and not keyword_set(par5) and $
        not keyword_set(par6) and not keyword_set(par7) and not keyword_set(par8) and not keyword_set(par9) 
  st2 = keyword_set(par2) and keyword_set(par3) and not keyword_set(par4) and not keyword_set(par5) and $
        not keyword_set(par6) and not keyword_set(par7) and not keyword_set(par8) and not keyword_set(par9)
  st3 = keyword_set(par2) and keyword_set(par3) and keyword_set(par4) and not keyword_set(par5) and $
        not keyword_set(par6) and not keyword_set(par7) and not keyword_set(par8) and not keyword_set(par9)
  st4 = keyword_set(par2) and keyword_set(par3) and keyword_set(par4) and keyword_set(par5) and $
        not keyword_set(par6) and not keyword_set(par7) and not keyword_set(par8) and not keyword_set(par9)
  st5 = keyword_set(par2) and keyword_set(par3) and keyword_set(par4) and keyword_set(par5) and $
        keyword_set(par6) and not keyword_set(par7) and not keyword_set(par8) and not keyword_set(par9)
  st6 = keyword_set(par2) and keyword_set(par3) and keyword_set(par4) and keyword_set(par5) and $
        keyword_set(par6) and keyword_set(par7) and not keyword_set(par8) and not keyword_set(par9)
  st7 = keyword_set(par2) and keyword_set(par3) and keyword_set(par4) and keyword_set(par5) and $
        keyword_set(par6) and keyword_set(par7) and keyword_set(par8) and not keyword_set(par9)
  st8 = keyword_set(par2) and keyword_set(par3) and keyword_set(par4) and keyword_set(par5) and $
        keyword_set(par6) and keyword_set(par7) and keyword_set(par8) and keyword_set(par9)           
  if st1 then x_output = call_function(fcn, x_chosen, par2) else $
  if st2 then x_output = call_function(fcn, x_chosen, par2, par3) else $
  if st3 then x_output = call_function(fcn, x_chosen, par2, par3, par4) else $
  if st4 then x_output = call_function(fcn, x_chosen, par2, par3, par4, par5) else $
  if st5 then x_output = call_function(fcn, x_chosen, par2, par3, par4, par5, par6) else $
  if st6 then x_output = call_function(fcn, x_chosen, par2, par3, par4, par5, par6, par7) else $
  if st7 then x_output = call_function(fcn, x_chosen, par2, par3, par4, par5, par6, par7, par8) else $
  if st8 then x_output = call_function(fcn, x_chosen, par2, par3, par4, par5, par6, par7, par8, par9) else x_output = call_function(fcn, x_chosen)
  return, x_output
end
