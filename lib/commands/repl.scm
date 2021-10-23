(import (scheme base)
        (prefix (scmt command) cmd/))

(cmd/add-command!
  'repl
  `((description "REPL!")
    (run ,(lambda _ (display "HELLO-REPL") (newline)))))
