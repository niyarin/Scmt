(define-library (niyarin external-command)
    (export call-external-command)
    (cond-expand
      (gauche (import (scheme base)
                      (rename (gauche process)
                              (do-process call-external-command))))
      (chibi (import (scheme base)
                     (chibi process))
              (begin
                (define (call-external-command arg)
                 (apply system arg))))
      (else (import (scheme base))
            (begin
              (define (call-external-command arg)
                (error "[call-external-command] Sorry ....."))))))
