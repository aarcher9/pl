;; (defun printl(list) 
;;     (if (null list)
;;         ("end")
;;         (((car list)) (printl (cdr list)))))

(defun printl(list) 
    (if (null list)
        (write "null")
        (and (car list) (cdr list))))

(printl (list 1 2 3 455 4))