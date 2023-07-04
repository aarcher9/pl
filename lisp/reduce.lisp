(defun red (f el)
        (cond   ((< (length el) 2) (car el))
                ((>= (length el) 2)
                        (red f (cons (f (first el) (second el)) (rest (rest el)))))))

(defun f (x y) 
        (+ x y))

(print (red `f (list 1 2 3 4)))