;; ===== Supporto ===== ;;
;; Compatta una lista in una stringa
(defun list-to-string (l)
    (format nil "~{~A~}" l))

;; ========== ;;


;; ===== Creazione del monomio nella forma richiesta ===== ;;
;; V-term: simbolo della forma (V [a-z] <int>)
;; S-term: simbolo della forma [a-z]
;; EPXT-term: simbolo della forma (expt [a-z] <int>)


;; Ritorna vero se il carattere è a-z
(defun is-alpha (S-term) 
        (handler-case (alpha-char-p (coerce S-term 'character))
                (error (c) (print S-term) nil)))

;; Ritorna vero se il carattere è 0-9
(defun is-integer (c) (integerp c))


;; Formatta in esponenziale la singola variabile del monomio. Si aspetta termini EXPT-term o S-term
(defun term-to-exp (term) 
        (cond 
        ((null term)
                nil)
        ((and (atom term) (is-alpha term))
                (list `v term 1))
        ((listp term)
                (list `v (second term) (third term)))))

;; Si aspetta una lista di EXPT-term o S-term o mista
(defun expr-to-V-terms (terms) 
        (cond
        ((not (null terms))
                (cons (term-to-exp (first terms)) (expr-to-V-terms (rest terms))))))


;; Estrae i simboli di variabile da dei V-term e li ritorna in una lista
(defun get-var-symbols (V-terms)
        (cond
        ((not (null V-terms)) 
                (cons (second (first V-terms)) (get-var-symbols (rest V-terms))))))


;; Compara le variabili in un monomio utilizzando una funzione custom. I termini attesi sono V-term
(defun compare-V-terms (Vt1 Vt2)
        (string< (second Vt1) (second Vt2)))

;; Si aspetta una lista di V-term
(defun sort-V-terms (V-terms) 
        (stable-sort V-terms #'compare-V-terms))


;; Collassa le V-term simili di una lista di V-term in uno sola. Si aspetta che siano già sortate.
(defun collapse (Vt1 Vt2)
        (list `V (second Vt1) (+ (third Vt1) (third Vt2))))

(defun collapse-V-terms (V-terms) 
        (cond
        ((null (first V-terms)) 
                nil)
        ((null (second V-terms)) 
                V-terms)
        ((equal (second (first V-terms)) (second (second V-terms)))
                (cons (collapse (first V-terms) (second V-terms)) (collapse-V-terms (rest (rest V-terms)))))
        ((not (equal (second (first V-terms)) (second (second V-terms))))
                (cons (first V-terms) (collapse-V-terms (rest V-terms))))))


;; Calcola il grado totale di una lista di V-term
(defun get-total-degree (V-terms)
        (cond
        ((not (null V-terms)) 
                (+ (third (first V-terms)) (get-total-degree (rest V-terms))))
        ((null V-terms)
                0)))


;; Crea una list di V-term a partire da una lista mista di EXPT-term e S-term
(defun expr-to-sorted-V-terms (expr) 
        (collapse-V-terms (sort-V-terms (expr-to-V-terms expr))))


;; Crea un monomio a partire da un'espressione
(defun expr-to-monomial (expr)
        (cond
        ((is-integer expr) 
                (list `m expr 0 nil))

        ((and (listp expr) (equal `* (first expr)) (is-integer (second expr)) ) 
                (list `m (second expr) (get-total-degree (expr-to-sorted-V-terms (rest (rest expr)))) (expr-to-sorted-V-terms (rest (rest expr)))))

        ((and (listp expr) (equal `* (first expr)) (not (is-integer (second expr))))
                (list `m 1 (get-total-degree (expr-to-sorted-V-terms (rest expr))) (expr-to-sorted-V-terms (rest expr))))))
        

;; ========== ;;


;; ===== Creazione del polinomio nella forma richiesta ===== ;;
;; Compara i monomi all'interno di un polinomio per ordine lessicografico dei simboli di variabile
(defun compare-monomials-by-vars (M1 M2) 
        (string< (list-to-string (get-var-symbols (fourth M1))) (list-to-string (get-var-symbols (fourth M2)))))

;; Riordina il polinomio come richiesto
;;

;; Crea un polinommio a partire da un'espressione
(defun expr-to-polynomial (expr)
        (list `poly 
                (stable-sort
                        (stable-sort (mapcar `expr-to-monomial (rest expr)) #'compare-monomials-by-vars)
                        #'< :key #'third)
                        ))

;; ========== ;;


;; Esempi di input ;;


;; Monomio
;; Classico
(defparameter m1 `(* 3 y w (expt t 3)))
(defparameter m1_2 `(* (expt a 2)))

;; 1 sottinteso
(defparameter m2 `(* y (expt s 3) (expt t 3)))

;; Termine noto soltanto
(defparameter m3 42)
(defparameter m3_2 (* 42))


;; Polinomio
;; Classico
(defparameter p1 `(+ (* y (expt s 3) (expt t 3)) -4 (* x y)))
(defparameter p2 `(+ (* a c) (* (expt a 2)) (* a b) (* a)))


;; Testing ;;
;; (print (expr-to-monomial m1_2))
(print (expr-to-polynomial p2))
