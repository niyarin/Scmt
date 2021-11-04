(import (scheme base)
        (scheme list)
        (scheme write)
        (scheme read)
        (scheme eval)
        (scheme repl)
        (niyarin external-command)
        (prefix (scmt command) cmd/))

(define (%run-oneline! opt)
  (let* ((str-expressions (cond ((assq 'args opt) => cadr) (else '(#f))))
         (str-port (open-input-string (car str-expressions))))
    (write (eval (read str-port) (interaction-environment)))
    (newline)))

(cmd/add-command!
  'oneline
  `((description "Oneliner");;use orange paren??
    (supported (gauche chibi foment))
    (run ,(lambda args
            (%run-oneline! (car args))))))
