;;;; -*- Mode: Lisp -*-
;;;; 826296 Agosti Andrea
;;;; <>

;; --- Supporto
;; L'intervallo generato di interi è [0, lim)
(defun randnum (lim)
        (random lim (make-random-state t)))

(defun randlist (n lim)
        (if     (eq n 1) 
                (cons (randnum lim) nil)
                (cons (randnum lim) (randlist (- n 1) lim))))

;; Si deve fare in modo che sia impossibile estrarre due centroidi uguali
(defun randlist-clear (n lim rl)
        (if     (equal (remove-duplicates rl) rl)
                rl
                (randlist-clear n lim (randlist n lim))))

(defun randset (n lim)
        (randlist-clear n lim (randlist n lim)))


;; --- Operazioni fra vettori
;; *
(defun scalarprod (L x) 
        (if     (not (null x))
                (cons (* L (first x)) (scalarprod L (rest x)))
                nil))

;; *
(defun vplus (x y) 
        (cond   ((and (not (null x)) (not (null y)))
                        (cons (+ (first x) (first y)) (vplus (rest x) (rest y))))))

;; *
(defun vminus (x y) 
        (vplus x (scalarprod -1 y)))

;; *
(defun innerprod (x y) 
        (if     (or (null x) (null y))
                0.0
                (+ (* (first x) (first y)) (innerprod (rest x) (rest y)))))

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
;; Il parametro min deve essere inizialmente SOLTANTO ed ESCLUSIVAMENTE uno dei cs.
(defun nearest (o cs min) 
        (if     (null cs)
                min
                (if     (< (distance (first cs) o) (distance min o))
                        (nearest o (rest cs) (first cs))
                        (nearest o (rest cs) min))))

(defun assign (o cs)
        (nearest o cs (first cs)))

;; Accoppia ciascuna osservazione con il suo centroide più vicino
(defun assignall (obs cs)
        (if     (null obs)
                nil
                (cons   (cons (first obs) (cons (assign (first obs) cs) nil)) 
                        (assignall (rest obs) cs))))

;; Raggruppa tutte le osservazioni che condividono il centroide indicato (più vicino) a partire da un insieme di coppie punto-centroide
;; Per qualche motivo (last <list>) ritorna una lista e non un singolo elemento meglio usare (second <list>) che in questo caso equivale.
(defun group (ass c) 
        (if     (null ass)
                nil
                (if     (equal (second (first ass)) c)
                        (cons (first (first ass)) (group (rest ass) c))
                        (group (rest ass) c))))

(defun groupall (ass cs) 
        (if     (null cs)
                nil
                (cons   (group ass (first cs))
                        (groupall ass (rest cs)))))

;; Crea k = (length cs) clusters attorno ai centroidi cs sulle osservazioni
(defun partition (obs cs)
        (groupall (assignall obs cs) cs))

;; *
(defun centroid (observations) 
        (vmean observations))

(defun centroids (clss) 
        (if     (null clss)
                nil
                (cons (centroid (first clss)) (centroids (rest clss)))))

;; Ritorna i clusters e i centroidi relativi
(defun repart (obs cs clss) 
        (if     (equal cs (centroids clss))
                (cons cs (cons clss nil))
                (repart obs (centroids clss) (partition obs (centroids clss)))))

(defun lloydkmeans (obs cs) 
        (repart Obs cs (partition Obs cs)))

(defun lloydkmeansdbg (obs cs) 
        (format t "~%Centroid:")
        (format t "~{~%> ~a~}~%~%" (first (lloydkmeans obs cs)))
        (format t "Clusters:")
        (format t "~{~%> ~a~}" (second (lloydkmeans obs cs)))
        (format t "~%"))

;; Estrae i k centroidi dalle osservazioni pseudo-casualmente
(defun initialize(obs k) 
        (mapcar (lambda (x) (nth x obs)) (randset k (length obs))))

(defun kmeansdbg (observations k) 
        (lloydkmeansdbg observations (initialize observations k)))

;; *
(defun kmeans (observations k) 
        (second (lloydkmeans observations (initialize observations k))))
