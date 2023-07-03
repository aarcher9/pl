;; Suppongo di avere questa funzione:
(defun f (x y)
        (let (
                (a (* x y))
                (b (+ x y)))
                (+ a b)))

(print (f 2 3)) ;; = 11

;; Anche se non ho ben capito il senso della cosa...
;; Riscriviamola con le lambda:
(defun g (x y) 
        (lambda () 
                (+ (* x y) (+ x y))))

(print (funcall (g 2 3))) ;; = 11