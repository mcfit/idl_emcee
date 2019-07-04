; docformat = 'rst'

function emcee_inv_tot_dist, z, z_a, z_b
;+
;     This function returne the inverse Cumulative Distribution Function: 1/sqrt(z)
;     if the random number generator z is between 1/z_a and z_b, is used 
;     to generate for a 1/sqrt(z) probability distribution.
;
; :Returns:
;    type=arrays. This function returns the lower and higher 
;                 linear histogram grids (hist_lo, hist_hi)
;
; :Params:
;     z       :  in, required, type=float
;                the a random number generator for the probability 
;                distribution 1/sqrt(z).
;
;     z_a     :  in, required, type=float
;                the inverse lower limit for the random number 
;                generator z: 1/z_a <= z.
;
;     z_b     :  in, required, type=float
;                the higher limit for the random number 
;                generator z: z <= b.
; 
; :Examples:
;    For example::
;
;     IDL> z = emcee_inv_tot_dist(random_num, adjust_scale_low, adjust_scale_high);
;
; :Categories:
;   MCMC
;
; :Dirs:
;  ./
;      Subroutines
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
;                 Adopted from icdf() of sl_emcee 
;                 by M.A. Nowak included in isisscripts
;-
  x1 = 1./(sqrt(z_a*z_b)-1.)
  x2 = 1./x1^2./z_a
  return, x2*(z+x1)^2
end
