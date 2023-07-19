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
(defun innerprod (x y) 
        (if     (not (null x))
                (+ (* (first x) (first y)) (innerprod (rest x) (rest y)))
                0))

;; *
(defun norm (x) 
        (expt (innerprod x x) (/ 2)))

(defun distance (x y) 
        (norm (vminus x y)))

(defun vmean (vs) 
        (scalarprod (/ (length vs)) (vsum vs)))

(defun vsum (vs)
        (if     (null (rest vs))
                (first vs)
                (vplus (first vs) (vsum (rest vs)))))


;; --- Algoritmo k-means
;; Estrae i k centroidi dalle osservazioni pseudo-casualmente
(defun initialize(obs k) 
        (if     (eq k 1)
                (cons   (nth (randnum (length obs)) obs) 
                        nil)
                (cons   (nth (randnum (length obs)) obs) 
                        (initialize obs (- k 1)))))

;; Il parametro min deve essere inizialmente SOLTANTO ed ESCLUSIVAMENTE uno dei cs.
(defun nearest (o cs min) 
        (if     (null cs)
                min
                (if     (< (distance (first cs) o) (distance min o))
                        (nearest o (rest cs) (first cs))
                        (nearest o (rest cs) min))))

;; Wrapper di convenienza per nearest
(defun assign (o cs)
        (nearest o cs (first cs)))

;; Accoppia ciascuna osservazione con il suo centroide più vicino
(defun assignall (obs cs)
        (if     (null obs)
                nil
                (cons   (cons (first obs) (cons (assign (first obs) cs) nil)) 
                        (assignall (rest obs) cs))))

;; Raggruppa tutte le osservazioni che condividono lo stesso centroide più vicino a partire da un insieme di coppie già assegnate
;; Per qualche motivo (last <list>) ritorna una lista e non un singolo elemento
(defun pp (ass c) 
        (if     (null ass)
                nil
                (if     (equal c (first (last (first ass))))
                        (cons (first (first ass)) (pp (rest ass) c))
                        (pp (rest ass) c))))

(defun partition (obs cs)
        (if     (null cs)
                nil
                (cons   (pp (assignall obs cs) (first cs))
                        (partition obs (rest cs)))))

;; *
(defun kmeans (observations k) 
        (print "kmeans"))

;; *
(defun centroid (observations) 
        (print "centroid"))


;; --- Parametri per testing 
(defparameter Observations 
        `(      (3.0 7.0) (0.5 1.0) (0.8 0.5) (1.0 8.0) 
                (0.9 1.2) (6.0 4.0) (7.0 5.5) (4.0 9.0) 
                (9.0 4.0)))



























































































































































