;;;; -*- Mode: Lisp -*-
;;;; 826296 Agosti Andrea
;;;; <>

;; --- Gestione condizioni
(defun handle-klus-n (obs k)
        (cond   ((> k (length obs)) 
                        (warn "K deve essere al massimo uguale al numero di osservazioni") 
                        (length obs))
                ((<= k 0)
                        (warn "K deve essere un numero naturale non-zero") 
                        1)
                (t k)))

;; --- Supporto
;; L'intervallo generato di interi è [0, lim)
(defun randnum (lim) (random lim (make-random-state t)))

(defun randlist (n lim)
        (if     (eq n 1) 
                (cons (randnum lim) nil)
                (cons (randnum lim) (randlist (- n 1) lim))))

;; Si deve fare in modo che sia impossibile estrarre due centroidi uguali
(defun randlist-clear (n lim rl)
        (if     (equal (remove-duplicates rl) rl)
                rl
                (randlist-clear n lim (randlist n lim))))

(defun randset (n lim) (randlist-clear n lim (randlist n lim)))


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
(defun vminus (x y) (vplus x (scalarprod -1 y)))

;; *
(defun innerprod (x y) 
        (if     (or (null x) (null y))
                0.0
                (+ (* (first x) (first y)) (innerprod (rest x) (rest y)))))

;; *
(defun norm (x) (expt (innerprod x x) (/ 2)))

(defun distance (x y) (norm (vminus x y)))

(defun vmean (vs) (scalarprod (/ (length vs)) (vsum vs)))

(defun vsum (vs)
        (if     (null (rest vs))
                (first vs)
                (vplus (first vs) (vsum (rest vs)))))


;; --- Algoritmo k-means
;; Il parametro min deve essere inizialmente SOLTANTO ed ESCLUSIVAMENTE uno dei centroidi specificati.
(defun nearest (o cs min) 
        (if     (null cs)
                min
                (if     (< (distance (first cs) o) (distance min o))
                        (nearest o (rest cs) (first cs))
                        (nearest o (rest cs) min))))

(defun assign (o cs) (nearest o cs (first cs)))

;; Accoppia ciascuna osservazione con il suo centroide più vicino
(defun assignall (obs cs)
        (if     (null obs)
                nil
                (cons   (cons (first obs) (cons (assign (first obs) cs) nil)) 
                        (assignall (rest obs) cs))))

;; Raggruppa tutte le osservazioni che condividono il centroide indicato (più vicino) a partire da un insieme di coppie punto-centroide
;; Per qualche motivo (last <list>) ritorna una lista e non un singolo elemento meglio usare (second <list>) che in questo caso equivale.
(defun group (pairs c) 
        (if     (null pairs)
                nil
                (if     (equal (second (first pairs)) c)
                        (cons (first (first pairs)) (group (rest pairs) c))
                        (group (rest pairs) c))))

(defun groupall (pairs cs) 
        (if     (null cs)
                nil
                (cons   (group pairs (first cs))
                        (groupall pairs (rest cs)))))

;; Crea k = (length <lista di centroidi>) clusters attorno ai centroidi sulle osservazioni
(defun partition (obs cs) (groupall (assignall obs cs) cs))

;; *
(defun centroid (observations) (vmean observations))

(defun centroids (klus) 
        (if     (null klus)
                nil
                (cons (centroid (first klus)) (centroids (rest klus)))))

;; Ritorna i clusters e i centroidi relativi
(defun repart (obs cs klus) 
        (if     (equal cs (centroids klus))
                (cons cs (cons klus nil))
                (repart obs (centroids klus) (partition obs (centroids klus)))))

(defun lloydkmeans (obs cs) (repart Obs cs (partition Obs cs)))

;; Estrae i k centroidi dalle osservazioni pseudo-casualmente
(defun initialize(obs k) 
        (mapcar (lambda (x) (nth x obs)) (randset k (length obs))))

;; *
(defun kmeans (observations k) 
        (lloydkmeans observations (initialize observations (handle-klus-n observations k))))

(defun kmeansdbg (observations k) 
        (format t "~%Centroids:")
        (format t "~{~%> ~a~}~%~%" (first (kmeans observations k)))
        (format t "Clusters:")
        (format t "~{~%> ~a~}" (second (kmeans observations k)))
        (format t "~%"))
