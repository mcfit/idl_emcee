; docformat = 'rst'

function myfunc1, input
  result1 = total(input)
  result2 = input[1]^input[0]
  return, [result1, result2]
end

function emcee_find_errors_ut::test_basic
  compile_opt strictarr
  
  clevel=.9
  use_gaussian=0
  
  input=[1. , 2.]
  input_err=[0.2, 0.5]
  input_err_p=input_err
  input_err_m=-input_err
  output=myfunc1(input)
  temp=size(output,/DIMENSIONS)
  output_num=temp[0]
  walk_num=30
  iteration_num=50
  
  mcmc_sim=emcee_hammer('myfunc1', input, input_err_m, input_err_p, $
                         output, walk_num, iteration_num, use_gaussian)
  output_error=emcee_find_errors(output, mcmc_sim, clevel)
  
  temp=size(output_error,/DIMENSIONS)
  result=temp[0]

  assert, result eq 2, 'incorrect result: %d', result
  
  return, 1
end

pro emcee_find_errors_ut__define
  compile_opt strictarr
  
  define = { emcee_find_errors_ut, inherits emceeUTTestCase}
end
