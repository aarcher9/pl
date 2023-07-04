(defun nopred (p l)
        (cond   ((null l) nil)
                ((atom l) 
                        (cond   ((ignore-errors (funcall p l))
                                        l)))
                ((listp l)
                        (cons (nopred p (first l)) (nopred p (rest l))))))

(defun p (x) 
        (or (equal x 2) (equal x 5) (equal x 8)))

(print (nopred `p (list 2 6 5 (list 2 4 5) 9)))