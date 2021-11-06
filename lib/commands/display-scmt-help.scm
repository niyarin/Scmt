(import (scheme base)
        (scheme write)
        (prefix (scmt command) cmd/))

(define (%make-message cmd)
   "Scmt <impl-name>? <command-name> <command-args> ...")

(define (%run-help-message! cmd)
   (display (%make-message '()))
   (newline))

(cmd/add-command!
  'display-scmt-help
  `((description "HELP!")
    (supported (gauche chibi foment))
    (run ,(lambda args
            (%run-help-message! (car args))))))

