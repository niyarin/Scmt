(import (scheme base)
        (scheme list)
        (niyarin external-command)
        (prefix (scmt command) cmd/))

;;TODO RLWRAP

(define (%run-repl! opt)
  (let* ((impl-info (cond ((assq 'target-impl opt) => cadr) (else #f))))
    (when impl-info
      (let ((load-path-option
              (cond ((assq 'add-load-path impl-info) => cadr) (else #f)))
            (scmt-dir (cond ((assq 'scmt-dir opt) => cadr) (else '()))))
      (call-external-command
        (append (list (cadr (assq 'cmd impl-info)))
                (append-map (lambda (x) (list load-path-option x)) scmt-dir)))))))

(cmd/add-command!
  'repl
  `((description "REPL!");;use orange paren??
    (supported (gauche chibi foment))
    (run ,(lambda args
            (%run-repl! (car args))))))
