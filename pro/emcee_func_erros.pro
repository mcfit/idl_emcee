; docformat = 'rst'

function emcee_func_erros, output, mcmc_sim, clevel, do_plot=do_plot, $
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
;     IDL> output_error=emcee_func_erros(output, mcmc_sim, clevel)
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
;   0.1.0
;
; :History:
;     15/03/2017, A. Danehkar, IDL code written
;                 Adopted from chain_hist() of sl_emcee 
;                 by M.A. Nowak included in isisscripts
;-
  nbins=50.
  
  temp=size(output,/DIMENSIONS)
  output_num=temp[0]
  output_error=dblarr(output_num,2)
  
  for j=0L, output_num-1 do begin
    sim1=mcmc_sim[*,*,j]
    sim1_min=min(sim1)
    sim1_max=max(sim1)
    x_min=sim1_min
    x_max=sim1_max
    if x_min ne x_max then begin
      emcee_linear_grid, x_min, x_max, nbins, lo, hi
      emcee_linear_grid, sim1_min,sim1_max,4.*nbins, lo_fine, hi_fine
      pdf_n = histogram(float(sim1), binsize=lo[1]-lo[0]);BINSIZE = float(bin), locations=xbin,)
      pdf_n_fine = histogram(float(sim1), binsize=lo_fine[1]-lo_fine[0]);BINSIZE = float(bin), locations=xbin)
      cdf_n = total(pdf_n, /cumulative) / N_ELEMENTS(sim1)
      cdf_n_fine = total(pdf_n_fine, /cumulative) / N_ELEMENTS(sim1)
      
      result=output[j]
        
      clevel_start = min(where(cdf_n ge (1.-clevel)/2.))
      clevel_end = min(where(cdf_n gt (1.+clevel)/2.))
      if clevel_end eq 50 then clevel_end=clevel_end-1
      sim1_lo=lo[clevel_start]
      sim1_hi=hi[clevel_end]
      ;print, result, sim1_lo-result, sim1_hi-result
      ;plothist, sim1, bin=lo[1]-lo[0]
      
      clevel_start = min(where(cdf_n_fine ge (1.-clevel)/2.))
      clevel_end = min(where(cdf_n_fine gt (1.+clevel)/2.))
      if clevel_end eq 200 then clevel_end=clevel_end-1
      sim1_lo=lo_fine[clevel_start]
      sim1_hi=hi_fine[clevel_end]
      bin_fine=lo_fine[1]-lo_fine[0]
      ;temp=size(pdf_n_fine,/DIMENSIONS)
      ;ntot=double(temp[0])
      output_error[j,0]=sim1_lo-result
      output_error[j,1]=sim1_hi-result
      ;print, result, sim1_lo-result, sim1_hi-result
      ;pdf_normalize=pdf_n_fine/bin_fine/ntot
      ;plot,lo_fine,pdf_normalize/max(pdf_normalize)
      if keyword_set(do_plot) then begin
        plothist, sim1, bin=bin_fine
        if keyword_set(image_output_path) eq 1 then begin
          set_plot,'ps'
          filename=image_output_path+'/histogram'+strtrim(string(j),1)+'.eps'
          device, /color, bits_per_pixeL=8, font_size=7, $
               filename=filename, $
               encapsulated=1, helvetica=1, bold=1, book=1, $
               xsize=5.0, ysize=4.0, inches=1
          loadct,13
          plothist, sim1, bin=bin_fine
          device, /close
        endif
      endif
    endif else begin
      output_error[j,0]=0
      output_error[j,1]=0
    endelse
  endfor
  return, output_error
end
