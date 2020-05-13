; docformat = 'rst'

;+
; Returns idl_emcee version. This file is automatically edited 
; by the builder to include the revision.
;
; :Returns:
;    string
;
; :Keywords:
;    full : in, optional, type=boolean
;       set to return Subversion revision as well
;-
function emcee_version, full=full
  compile_opt strictarr, hidden

  version = '0.2.0'
  revision = '-01e10b712'

  return, version + (keyword_set(full) ? (' ' + revision) : '')
end
