; docformat = 'rst'

function emcee_linear_grid_ut::test_basic
  compile_opt strictarr
  
  x_min=1
  x_max=5
  nbins=10
  emcee_linear_grid, x_min, x_max, nbins, lo, hi
  result = round(lo[5]+hi[4])
  assert, result eq 6, 'incorrect result: %d', result
  
  return, 1
end

pro emcee_linear_grid_ut__define
  compile_opt strictarr
  
  define = { emcee_linear_grid_ut, inherits emceeUTTestCase}
end
