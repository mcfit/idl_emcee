; docformat = 'rst'

function emcee_inv_tot_dist_ut::test_basic
  compile_opt strictarr
  
  result=round(emcee_inv_tot_dist(1,0.2, 1.9))
  
  assert, result eq 2, 'incorrect result: %d', result
  
  return, 1
end

pro emcee_inv_tot_dist_ut__define
  compile_opt strictarr
  
  define = { emcee_inv_tot_dist_ut, inherits emceeUTTestCase}
end
