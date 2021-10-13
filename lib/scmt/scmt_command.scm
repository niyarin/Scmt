(define-library (scmt command)
  (import (scheme base))
  (export add-command! command-ref)
  (begin
    (define command-list '())

    (define (add-command! command-name command)
      (set! command-list
            (cons (cons command-name command)
                  command)))

    (define (command-ref command-name)
      (cond
        ((assq command-name command-list) => cdr)
        (else #f)))

    ))
