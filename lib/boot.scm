(include "./scmt/opt.scm")
(include "./scmt/command.scm")

(import (scheme base)
        (scheme process-context)
        (scheme write)
        (scheme load)
        (prefix (scmt opt-parse) scmt-optparse/)
        (prefix (scmt command) scmt-command/))

(define target-scm-impl (or (get-environment-variable "SCMT_TARGET_IMPL")
                            (get-environment-variable "_SCMT_HOST_IMPL")))

(define scmt-lib-dir (get-environment-variable "_SCMT_LIB_DIR"))

(let ((parsed (scmt-optparse/scmt-parser (cdr (command-line)) '())))
  (case (cadr (assq 'cmd parsed))
     ((repl) (begin (display "HELLO REPL!") (newline)))
     (else (begin (display "HELP") (newline)))))
