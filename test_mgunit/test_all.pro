; --- Begin $MAIN$ program. ---------------
; 
; 

mgunit, ['emcee_hammer_ut', 'emcee_find_errors_ut', 'emcee_initialize_ut', $
        'emcee_inv_tot_dist_ut', 'emcee_linear_grid_ut'], $
        filename='test-results.log'

mgunit, ['emcee_hammer_ut', 'emcee_find_errors_ut', 'emcee_initialize_ut', $
        'emcee_inv_tot_dist_ut', 'emcee_linear_grid_ut'], $
        filename='test-results.html', /html

; --- End $MAIN$ program. ---------------
exit
