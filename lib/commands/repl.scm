(import (scheme base)
        (scheme write);;
        (niyarin external-command)
        (prefix (scmt command) cmd/))

(define (%run-repl! opt)
  (let* ((impl-info (cond ((assq 'target-impl opt) => cadr) (else #f))))
    (when impl-info
      (call-external-command (cadr (assq 'cmd impl-info))))))

(cmd/add-command!
  'repl
  `((description "REPL!");;use orange paren??
    (supported (gauche))
    (run ,(lambda args
            (%run-repl! (car args))))))
