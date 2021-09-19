(include "./opt.scm")

(import (scheme base)
        (scheme process-context)
        (scheme write)
        (prefix (scmt opt-parse) scmt-optparse/))

(define target-scm-impl (or (get-environment-variable "SCMT_TARGET_IMPL")
                            (get-environment-variable "_SCMT_HOST_IMPL")))

(let ((parsed (scmt-optparse/scmt-parser (cdr (command-line)) '())))
  (case (cadr (assq 'cmd parsed))
     ((repl) (begin (display "HELLO REPL!") (newline)))
     (else (begin (display "HELP") (newline)))))
