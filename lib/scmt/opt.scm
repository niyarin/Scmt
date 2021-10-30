(define-library (scmt opt-parse)
  (import (scheme base))
  (export impl-name-parse scmt-parser)
  (begin
    (define DEFAULT-IMPLE-DICT
      '(("gosh" ((cmd "gosh")
                 (name "gauche")))))

    (define DEFAULT-OPT
      `((target-impl ,(cadr (car DEFAULT-IMPLE-DICT)))))

    (define (impl-name-parse impl-name)
      (cond
        ((assoc impl-name DEFAULT-IMPLE-DICT)
         => cadr)
        (else #f)))

    (define (make-target-imple-opt-parser parser)
      (lambda (input res)
        (cond
          ((null? input) '((cmd display-scmt-help)))
          ((impl-name-parse (car input))
           => (lambda (target-impl-info)
                (parser (cdr input) (cons (list 'target-impl target-impl-info)
                                          res))))
          (else (parser input res)))))

    (define (make-command-opt-parser parser)
      (lambda (input res)
        (cond
          ((null? input) '((cmd display-scmt-help)))
          (else
            (parser (cdr input)
                    (cons (list 'cmd (string->symbol (car input)))
                          res))))))

    (define scmt-parser
      (make-target-imple-opt-parser
        (make-command-opt-parser
          (lambda (input res)
            (append (cons (list 'args input) res)
                    DEFAULT-OPT)))))))
