(defun os (nomefunz list)
        (cond ((null list) 0)
                ((nomefunz (car list)) (+ 1 (os nomefunz (cdr list))))
                (T (os nomefunz (cdr list)))))

(defun nomefunz (x) (* 2 x))

(print (os `g (list 0 1 2 3)))