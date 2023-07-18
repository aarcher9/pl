;;;; -*- Mode: Lisp -*-
;;;; 826296 Agosti Andrea
;;;; <>

;; In caso di bisogno:
;; C-x h C-M-\ usare il comando per reindentare tutto il file con Emacs.
;; M-q usare il comando per tagliare come impostato tutto il file con Emacs.

;; --- Supporto
(defun randnum (l)
        (random l (make-random-state t)))

(defun randlist (n l)
        (if     (eq n 1) 
                (cons (randnum l) nil)
                (cons (randnum l) (randlist (- n 1) l))))


;; --- Operazioni fra vettori
;; Ci si rifereisce indistintamente ai vettori come punti e viceversa dal momento che sono strutture equivalenti in questo caso.

;; Calcolo del punto medio fra vettori
(defun vmean (vs) 
        (scalarprod (/ (length vs)) (vsum vs)))

;; Sommatoria fra vettori
(defun vsum (vs)
        (if     (null (rest vs))
                (first vs)
                (vplus (first vs) (vsum (rest vs)))))

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
;; Sceglie k tra le osservazioni come centroidi (iniziali, ma lo fa in generale)
(defun initialize(observations k) 
        (if     (eq k 1)
                (cons   (nth (randnum (length observations)) observations) 
                        nil)
                (cons   (nth (randnum (length observations)) observations) 
                        (initialize observations (- k 1)))))

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



























































































































































