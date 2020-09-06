; --- Begin $MAIN$ program. ---------------
; 
; Example of object-oriented programming (OOP) for
;     emcee object
;
mc=obj_new('emcee')

base_dir = '../'
image_dir = ['examples','images']
image_output_path = filepath('', root_dir=base_dir, subdir=image_dir )

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
output=myfunc21(input)
temp=size(output,/DIMENSIONS)
output_num=temp[0]
walk_num=30
iteration_num=500

mcmc_sim=mc->hammer('myfunc21', input, input_err_m, input_err_p, output, $
                    walk_num=walk_num, iteration_num=iteration_num, $
                    use_gaussian=use_gaussian)

output_error=mc->func_errors(output, mcmc_sim, $
                            clevel=clevel, do_plot=1, $
                            image_output_path=image_output_path)

for i=0, output_num-1 do print, output[i], transpose(output_error[i,*])


input=[1. , 2.]
input_err=[0.2, 0.5]
input_err_p=input_err
input_err_m=-input_err
scale1=2.
scale2=3.
fcnargs = {scale1:scale1, scale2:scale2}
output=myfunc22(input, FUNCTARGS=fcnargs)
temp=size(output,/DIMENSIONS)
output_num=temp[0]
walk_num=30
iteration_num=100

mcmc_sim=mc->hammer('myfunc22', input, input_err_m, input_err_p, output, $
                    walk_num=walk_num, iteration_num=iteration_num, $
                    use_gaussian=use_gaussian, FUNCTARGS=fcnargs)

output_error=mc->func_errors(output, mcmc_sim, clevel=clevel, do_plot=1)

for i=0, output_num-1 do print, output[i], transpose(output_error[i,*])

exit

