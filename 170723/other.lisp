;; Gestione errori semplice
(defun base_err_hand ()
        (handler-case (/ 3 0) 
                (division-by-zero (c) (format t "Caught division by zero: ~a~%" c))))

;; Gestione errore avanzata
(defun adv_err_hand () 
        (restart-case
                (handler-bind 
                        ((error #'(lambda (c) 
                                        (declare (ignore condition))
                                        (invoke-restart 'my-restart 7))))
                (error "Foo."))
                (my-restart (&optional v) (print v))))

;; Warnings
(defun warning_throw() (warn "Ignore even number"))