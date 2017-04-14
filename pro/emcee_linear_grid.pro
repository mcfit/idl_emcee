pro emcee_linear_grid, x_min, x_max, nbins, hist_lo, hist_hi
;+
; NAME:
;     emcee_linear_grid
; 
; PURPOSE:
;     generate a linear grid of histogram bins
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
;     x_min  - the lower limit
;     x_max  - the higher limit
;     nbins - the bins number
;     hist_lo - return the lower linear histogram grid
;     hist_hi - return the higher linear histogram gri
; 
; RETURN:  hist_lo, hist_hi, the lower and higher linear histogram grids
; 
; REVISION HISTORY:
;     Adopted from the S-Lang function linear_grid() in isis
;     IDL code by A. Danehkar, 15/03/2017
;-

  step=(double(x_max)-double(x_min))/double(nbins)
  hist_lo=double(indgen(nbins)*step + x_min)
  hist_hi=double((indgen(nbins)+1)*step + x_min)
end
