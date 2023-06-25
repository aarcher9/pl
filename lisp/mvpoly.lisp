;; ===== P1 ===== ;;
;; Ritorna vero se il carattere è a-z
(defun is-alpha (c) (alpha-char-p (coerce c 'character)))


;; Formatta in esponenziale la singola variabile del monomio. Si aspetta termini composti da una lettera latina minuscola a-z oppure (expt [a-z] <number>)
(defun var-to-exp (var) 
        (cond 
        ((null var)
                nil)
        ((and (atom var) (is-alpha var))
                (list `v var 1))
        ((listp var)
                (list `v (second var) (third var)))))

(defun vars-to-exp (vars) 
        (cond
        ((not (null vars))
        (cons (var-to-exp (first vars)) (vars-to-exp (rest vars))))))


;; Riordina le variabili in un monomio utilizzando una funzione custom. I termini attesi sono della forma (V [a-z] <number>)
(defun compare-vars (x y) 
        (< (char-code (character (second x))) (char-code (character (second y)))))

(defun sort-vars (vars) 
        (stable-sort vars #'compare-vars))


;; Collassa le variabili uguali in una sola: (V x 5) (V x 6) -> (V x 11)
(defun collapse-vars (vars) 
        ())


;; Formatta in un monomio non ordinato e non collassato
(defun raw-monomial (expr) 
        (list `m (second expr) `degree (sort-vars (vars-to-exp (rest (rest expr))))))
;; ========== ;;


;; Esempi di input
(defparameter m1 `(* 3 y w (expt t 3)))
(defparameter m2 42)
(defparameter m3 `(* y (expt s 3) (expt t 3)))
(defparameter m4 `(+ (* y (expt s 3) (expt t 3)) -4 (* x y)))


;; Testing ;;
(print (raw-monomial m1))
