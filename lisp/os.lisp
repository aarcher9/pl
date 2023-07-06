(defun os (nomefunz list)
        (cond ((null list) 0)
                ((nomefunz (car list)) (+ 1 (os nomefunz (cdr list))))
                (T (os nomefunz (cdr list)))))

(defun nomefunz (x) (* 2 x))

;; Devo usare apply o funcall se non voglio che il passaggio del nome della funzione sia inutile.
(print (os `ghhh (list 0 1 2 3)))