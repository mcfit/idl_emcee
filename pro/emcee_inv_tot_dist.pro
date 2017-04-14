function emcee_inv_tot_dist, z, z_a, z_b
;+
; NAME:
;     emcee_linear_grid
; 
; PURPOSE:
;     return the inverse Cumulative Distribution Function: 1/sqrt(z)
;     if the random number generator z is between 1/z_a and z_b, is used 
;     to generate for a 1/sqrt(z) probability distribution.
; 
; EXPLANATION:
;
; CALLING SEQUENCE:
;     x_min=1
;     x_max=20
;     nbins=1000
;     emcee_linear_grid, x_min, x_max, nbins, lo, hi
;
; INPUTS:
;     z  - the a random number generator for the probability 
;          distribution 1/sqrt(z)
;     z_a - the inverse lower limit for the random number 
;           generator z: 1/z_a <= z
;     z_b - the higher limit for the random number 
;           generator z: z <= b
; 
; RETURN:  hist_lo, hist_hi, the lower and higher linear histogram grids
; 
; REVISION HISTORY:
;     Adopted from icdf() of sl_emcee by M.A. Nowak, included in isisscripts
;     IDL code by A. Danehkar, 15/03/2017
;-
  x1 = 1./(sqrt(z_a*z_b)-1.)
  x2 = 1./x1^2./z_a
  return, x2*(z+x1)^2
end
