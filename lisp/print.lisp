(defun printl(list) 
    (if (null list)
        (print "null")
        (progn (print (car list)) (print (cdr list)) (terpri))))

(printl (list 1 2 3 455 4))