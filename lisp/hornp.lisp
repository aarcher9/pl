(defun suml (ls) 
        (cond   ((not (null ls))
                        (+ (first ls) (suml (rest ls))))
                ((null ls)
                        0)))

(defun conj-assign-values (conj) 
        (cond   ((null conj) 
                        nil)
                ((atom (first conj)) 
                        (cons 1 (conj-assign-values (rest conj))))
                ((not (eq `not (first (first conj))))
                        (cons 1 (conj-assign-values (rest conj)))) 
                ((eq `not (first (first conj)))
                        (cons 0 (conj-assign-values (rest conj))))))

(defun horn (conjs)
        (cond   ((not (null conjs))
                        (cons (> 2 (suml (conj-assign-values (rest (first conjs))))) (horn (rest conjs))))
                ((null conjs) 
                        nil)))

(defun hornp (dnf) 
        (horn (rest dnf)))




(print (hornp `(and (or (p X) (p Y) (not y)) (or (p X) (not k) (not y)))))
(print (hornp `(and (or (not y)) (or (p X) (not k) (not y)))))
