;;;; -*- Mode: Lisp -*-
;;;; 826296 Agosti Andrea
;;;; <>

;; In caso di bisogno:
;; C-x h C-M-\ usare il comando per reindentare tutto il file con Emacs.
;; M-q usare il comando per tagliare come impostato tutto il file con Emacs.


;; --- Operazioni fra vettori

;; *
(defun vplus (x y) 
        (cond   ((and (not (null x)) (not (null y)))
                        (cons (+ (first x) (first y)) (vplus (rest x) (rest y))))))

;; *
(defun vminus (x y) 
        (print "differenza fra vettori"))

;; *
(defun scalarprod (L y) 
        (print "prodotto per uno scalare"))

;; *
(defun innerprod (x y) 
        (print "prodotto interno"))

;; *
(defun norm (x) 
        (print "prodotto interno"))


;; --- Algoritmo k-means

;; *
(defun kmeans (observations k) 
        (print "kmeans"))

;; *
(defun centroid (observations) 
        (print "centroid"))


;; --- Supporto



;; --- Test
(defparameter Observations 
        `(      (3.0 7.0) (0.5 1.0) (0.8 0.5) (1.0 8.0) 
                (0.9 1.2) (6.0 4.0) (7.0 5.5) (4.0 9.0) 
                (9.0 4.0)))

(print (vplus `(1 2) `(7 8)))



























































































































































