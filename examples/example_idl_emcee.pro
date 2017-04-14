function myfunc, input
  result1 = total(input)
  result2 = input[1]^input[0]
  return, [result1, result2]
end

;    
; --- Begin $MAIN$ program. ---------------
; 
; 

clevel=.9
use_gaussian=0 ; uniform distribution from min value to max value
;use_gaussian=1 ; gaussian distribution from min value to max value
if use_gaussian eq 1 then begin
  clevel=0.98758067 ; 2.5-sigma
endif else begin
  clevel=0.90 ; 1.645-sigma
endelse

input=[1. , 2.]
input_err=[0.2, 0.5]
input_err_p=input_err
input_err_m=-input_err
output=myfunc(input)
temp=size(output,/DIMENSIONS)
output_num=temp[0]
walk_num=30
iteration_num=100

mcmc_sim=emcee_hammer('myfunc', input, input_err_m, input_err_p, output, walk_num, iteration_num, use_gaussian)

output_error=emcee_func_erros(output, mcmc_sim, clevel, do_plot=1)

for i=0, output_num-1 do begin
  print, output[i], transpose(output_error[i,*])
endfor

end


