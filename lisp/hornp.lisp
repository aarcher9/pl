;; (defun check-disj (disj) 
;;         (not (and 
;;                 (not (eq `not (first (first disj))))
;;                 (check-disj (rest disj)))))

(defun check-disj (disj) 
        (print disj))

(defun hornp (conj) 
        (cond 
        ((not (null conj)) 
                (and (check-disj (first conj)) (hornp (rest conj))))
        T))

(print (hornp `(and (or p))))