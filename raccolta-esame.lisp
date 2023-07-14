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

;; (print (funcall (repeated `square 2) 3))
;; (print (funcall (repeated `square 3) 2))

;; ===== JSON key-value ===== ;;
(defparameter e `(name "Ugo" surname "Mascetti"))

(defun get-value (key json-obj) 
        (cond   ((null json-obj) `:undefined)
                ((eq key (first json-obj)) (first (rest json-obj)))
                (t (get-value key (rest json-obj))) ))

(defun add-key-value (key value json-obj) 
        (cons key (cons value json-obj)))

(defun make-object (keys values)
        (cond   ((or (null keys) (null values)) nil)
                (t (cons (first keys) (cons (first values) (make-object (rest keys) (rest values)))) )))

;; (print (get-value `name e))
;; (print (add-key-value `addr "Via col vento" e))
;; (print (make-object `(numero capelli) `(23 "biondi")))