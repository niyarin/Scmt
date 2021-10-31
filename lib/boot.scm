(import (scheme base))

(cond-expand
  (chibi)
  (else (include "./scmt/opt-parse.sld")
        (include "./scmt/command.sld")
        (include "./niyarin/external-command.sld")))

(import (scheme base)
        (scheme process-context)
        (scheme write)
        (scheme load)
        (prefix (scmt opt-parse) scmt-optparse/)
        (prefix (scmt command) scmt-command/))

(define target-scm-impl (or (get-environment-variable "SCMT_TARGET_IMPL")
                            (get-environment-variable "_SCMT_HOST_IMPL")))

(define scmt-lib-dir (get-environment-variable "_SCMT_LIB_DIR"))

(define (load-command! command-name)
  (unless (scmt-command/command-ref command-name)
    (let ((command-string (symbol->string command-name)))
      (load (string-append "./lib/commands/"command-string ".scm")))));;TODO:FIX

(let ((parsed (scmt-optparse/scmt-parser (cdr (command-line)) '())))
  (let ((command-name (cadr (assq 'cmd parsed))))
    (load-command! command-name)
    (let ((command-description
            (scmt-command/command-ref command-name)))
      (when command-description
        (let ((command-procedure
                (cadr (assq 'run command-description))))
          (command-procedure parsed))))))
