(defun 2to10 (b c)
        (cond   ((null b) 
                        0)
                ((not (null b)) 
                        (+ (* (first b) (expt 2 (- c 1))) (2to10 (rest b) (- c 1))))))

(defun bcd (b) 
        (2to10 b (length b)))

(print (bcd `(1 0 0 0)))
(print (bcd `(1 0 1 0 1 0)))
(print (bcd `(0 0 0 1 0 0 0)))