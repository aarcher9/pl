(defun multichan (functions &rest vals) 
        (if (null functions)
                ()
                (cons (apply (first functions) vals) (apply #'multichan(rest functions) vals))))

(print (multichan (list #'list #'cdr(lambda (x) (+ 42 (first x) 42)) #'length) (list 42 666)))