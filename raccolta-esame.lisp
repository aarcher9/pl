;; Probabile, anzi quasi matematico che ci siano codici giá presenti nella repo, sono stati messi qui per comodità di accesso.

;; ===== Conversione in decimale da binario ===== ;;
(defun 2to10 (b c)
        (cond   ((null b) 
                        0)
                ((not (null b)) 
                        (+ (* (first b) (expt 2 (- c 1))) (2to10 (rest b) (- c 1))))))

(defun bcd (b) 
        (2to10 b (length b)))

;; (print (bcd `(1 0 0 0)))
;; (print (bcd `(1 0 1 0 1 0)))
;; (print (bcd `(0 0 0 1 0 0 0)))

;; ===== repeated ===== ;;
(defun square (x) (* x x))

(defun repeated (f n) 
        (cond   ((zerop n) (lambda (x) x))
                ((= n 1) f)
                (t (lambda (x) (funcall f (funcall (repeated f (1- n)) x))))))

(print (funcall (repeated `square 2) 3))
(print (funcall (repeated `square 3) 2))