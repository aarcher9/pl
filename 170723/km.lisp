;;;; -*- Mode: Lisp -*-
;;;; 826296 Agosti Andrea
;;;; <>

;; In caso di bisogno:
;; C-x h C-M-\ usare il comando per reindentare tutto il file con Emacs.
;; M-q usare il comando per tagliare come impostato tutto il file con Emacs.


;; --- Operazioni fra vettori
;; Ci si rifereisce indistintamente ai vettori come punti e viceversa dal momento che sono strutture equivalenti in questo caso.

;; *
(defun vplus (x y) 
        (cond   ((and (not (null x)) (not (null y)))
                        (cons (+ (first x) (first y)) (vplus (rest x) (rest y))))))

;; *
(defun vminus (x y) 
        (vplus x (scalarprod -1 y)))

;; *
(defun scalarprod (L x) 
        (if     (not (null x))
                (cons (* L (first x)) (scalarprod L (rest x)))
                nil))

;; *
;; Note:
;; - i vettori egualmente lunghi
(defun innerprod (x y) 
        (if     (not (null x))
                (+ (* (first x) (first y)) (innerprod (rest x) (rest y)))
                0))

;; *
(defun norm (x) 
        (expt (innerprod x x) (/ 2)))

;;
(defun distance (x y) 
        (norm (vminus x y)))


;; --- Algoritmo k-means

;; Per inizializzare i k centroidi iniziali devo avere a disposizione la dimensione dei punti
(defun initialize(k n) 
        ())

;; *
(defun kmeans (observations k) 
        (print "kmeans"))

;; *
(defun centroid (observations) 
        (print "centroid"))



;; --- Parametri per testing 
;; I test sono effettuati in un file a parte

(defparameter Observations 
        `(      (3.0 7.0) (0.5 1.0) (0.8 0.5) (1.0 8.0) 
                (0.9 1.2) (6.0 4.0) (7.0 5.5) (4.0 9.0) 
                (9.0 4.0)))



























































































































































