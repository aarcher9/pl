(defun len (l) 
        (if (null l) 
        0
        (+ 1 (len (cdr l)))))

(print (len (list 0 1 2 3 4)))