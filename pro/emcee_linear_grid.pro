; docformat = 'rst'

pro emcee_linear_grid, x_min, x_max, nbins, hist_lo, hist_hi
;+
;     This procedure generates a linear grid of histogram bins.
;
; :Params:
;     x_min    :  in, required, type=float 
;                 the lower limit.
;
;     x_max    :  in, required, type=float
;                 the higher limit.
;
;     nbins    :  in, required, type=float
;                 the bins number.
;
;     hist_lo  :  out, required, type=arrays 
;                 returns the lower linear histogram grid,
;
;     hist_hi  :  out, required, type=arrays
;                 returns the higher linear histogram grid.
; 
; :Examples:
;    For example::
;
;     IDL> x_min=1
;     IDL> x_max=20
;     IDL> nbins=1000
;     IDL> emcee_linear_grid, x_min, x_max, nbins, lo, hi
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
;                 Adopted from the S-Lang function linear_grid() in isis.
;-

  step=(double(x_max)-double(x_min))/double(nbins)
  hist_lo=double(indgen(nbins)*step + x_min)
  hist_hi=double((indgen(nbins)+1)*step + x_min)
end
