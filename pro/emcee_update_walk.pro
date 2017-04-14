function emcee_update_walk, fcn, random_num, x_a, x_b, $
                      par2=par2, par3=par3, par4=par4, par5=par5, $
                      par6=par6, par7=par7, par8=par8, par9=par9
;, x_input, x_output, change_done
;+
; NAME:
;     emcee_update_walk
; 
; PURPOSE:
;     create the trial walker, examine whether it is acceptable, and 
;     return the updated walker
; 
; EXPLANATION:
;
; CALLING SEQUENCE:
;     x_output[j,*]=emcee_update_walk(fcn,a_random[random_num[j],*],array_xwalk,x_walk[*,b_walk])
;
; INPUTS:
;     fcn  - the calling function name
;     random_num  - the random number
;     x_a - the vector of the parameters for a specific walker
;     x_b - the array of the walker parameters
;     par2 - the second fixed parameters (not used for MCMC)
;     par3 - the thrid fixed parameters (not used for MCMC)
;     parx - the x-th fixed parameters (not used for MCM
; 
; RETURN:  the updated walker
; 
; REVISION HISTORY:
;     Adopted from update_walker() of sl_emcee by M.A. Nowak, included in isisscripts
;     IDL code by A. Danehkar, 15/03/2017
; 
  adjust_scale_low = 2.0
  adjust_scale_high = 2.0
  temp=size(x_b,/DIMENSIONS)
  par_num=temp[0]
  b_num=temp[1]
  x_chosen = x_b[*,long(random_num[0]*b_num)]
  ; print, long(random_num[0]*b_num)
  z = inv_tot_dist(random_num[1],adjust_scale_low,adjust_scale_high);
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
