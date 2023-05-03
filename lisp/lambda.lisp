(defun return-lambda(intermediate) (lambda (another) (+ intermediate another)))

(funcall (return-lambda 10) 10)