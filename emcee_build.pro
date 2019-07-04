;+
; Builds the emcee sav file.
;-

; clear any other compilations
.reset

; compile required code

@emcee_compile_all

; create the sav file
save, filename='emcee.sav', /routines, description='idl_emcee ' + emcee_version(/full)

exit
