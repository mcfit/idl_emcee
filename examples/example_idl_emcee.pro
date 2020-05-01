function myfunc1, input
  result1 = total(input)
  result2 = input[1]^input[0]
  return, [result1, result2]
end

function myfunc2, input, FUNCTARGS=fcnargs
  result1 = fcnargs.scale1*total(input)
  result2 = fcnargs.scale2*(input[1]^input[0])
  return, [result1, result2]
end
;    
; --- Begin $MAIN$ program. ---------------
; 
; 

clevel=.9
use_gaussian=0 ; uniform distribution from min value to max value
;use_gaussian=1 ; gaussian distribution from min value to max value
;clevel=0.38292492 ; 0.5-sigma,
;clevel=0.68268949 ; 1.0-sigma,
;clevel=0.86638560 ; 1.5-sigma,
;clevel=0.90       ; 1.645-sigma,
;clevel=0.95       ; 1.960-sigma,
;clevel=0.95449974 ; 2.0-sigma,
;clevel=0.98758067 ; 2.5-sigma,
;clevel=0.99       ; 2.575-sigma,
;clevel=0.99730020 ; 3.0-sigma,
;clevel=0.99953474 ; 3.5-sigma,
;clevel=0.99993666 ; 4.0-sigma,
;clevel=0.99999320 ; 4.5-sigma,
;clevel=0.99999943 ; 5.0-sigma,
;clevel=0.99999996 ; 5.5-sigma,
;clevel=0.999999998; 6.0-sigma.
if use_gaussian eq 1 then begin
  clevel=0.98758067 ; 2.5-sigma
endif else begin
  clevel=0.90 ; 1.645-sigma
endelse

input=[1. , 2.]
input_err=[0.2, 0.5]
input_err_p=input_err
input_err_m=-input_err
output=myfunc1(input)
temp=size(output,/DIMENSIONS)
output_num=temp[0]
walk_num=30
iteration_num=500

mcmc_sim=emcee_hammer('myfunc1', input, input_err_m, input_err_p, output, walk_num, iteration_num, use_gaussian)

output_error=emcee_func_erros(output, mcmc_sim, clevel, do_plot=1)

for i=0, output_num-1 do begin
  print, output[i], transpose(output_error[i,*])
endfor

input=[1. , 2.]
input_err=[0.2, 0.5]
input_err_p=input_err
input_err_m=-input_err
scale1=2.
scale2=3.
fcnargs = {scale1:scale1, scale2:scale2}
output=myfunc2(input, FUNCTARGS=fcnargs)
temp=size(output,/DIMENSIONS)
output_num=temp[0]
walk_num=30
iteration_num=100

mcmc_sim=emcee_hammer('myfunc2', input, input_err_m, input_err_p, output, walk_num, iteration_num, use_gaussian, FUNCTARGS=fcnargs)

output_error=emcee_func_erros(output, mcmc_sim, clevel, do_plot=1)

for i=0, output_num-1 do begin
  print, output[i], transpose(output_error[i,*])
endfor
end

