;;;; -*- Mode: Lisp -*-
;;;; 826296 Agosti Andrea
;;;; <>

;;; --- Gestione casi limite
(defun vectors-length-matches (x y)
        (cond   ((not (eq (length x) (length y))) 
                        nil)
                ((and (null x) (null y)) 
                        nil)
                (t t)))

;;; --- Supporto
;;; L'intervallo generato di interi è [0, lim)
(defun randnum (lim) (random lim (make-random-state t)))

(defun randlist (n lim)
        (if     (eq n 1) 
                (cons (randnum lim) nil)
                (cons (randnum lim) (randlist (- n 1) lim))))

;;; Si deve fare in modo che sia impossibile estrarre due centroidi uguali
(defun randlist-clear (n lim rl)
        (if     (equal (remove-duplicates rl) rl)
                rl
                (randlist-clear n lim (randlist n lim))))

(defun randset (n lim) (randlist-clear n lim (randlist n lim)))


;;; --- Operazioni fra vettori
;;; *
(defun scalarprod (L vector) 
        (if     (and (not (null vector)) (not (null L)))
                (cons (* L (first vector)) (scalarprod L (rest vector)))
                nil))

;;; *
(defun vplus (vector1 vector2) 
        (cond   ((and (null vector1) (null vector2))
                        nil)
                ((null vector1)
                        vector2)
                ((null vector2)
                        vector1)
                ((not (eq (length vector1) (length vector2)))
                        nil)
                (t
                        (cons (+ (first vector1) (first vector2)) (vplus (rest vector1) (rest vector2))))))
        ;; (if     (vectors-length-matches vector1 vector2)
        ;;         (cons (+ (first vector1) (first vector2)) (vplus (rest vector1) (rest vector2)))
        ;;         nil))

;;; *
(defun vminus (vector1 vector2) (vplus vector1 (scalarprod -1 vector2)))

;;; *
(defun innerprod (vector1 vector2) 
        (if     (vectors-length-matches vector1 vector2)
                (+ (* (first vector1) (first vector2)) (innerprod (rest vector1) (rest vector2)))
                0.0))

;;; *
(defun norm (vector) (expt (innerprod vector vector) (/ 2)))

(defun distance (vector1 vector2) (norm (vminus vector1 vector2)))

(defun vmean (vs) (scalarprod (/ (length vs)) (vsum vs)))

(defun vsum (vs)
        (if     (null (rest vs))
                (first vs)
                (vplus (first vs) (vsum (rest vs)))))


;;; --- Algoritmo k-means
;;; Il parametro min deve essere inizialmente SOLTANTO ed ESCLUSIVAMENTE uno dei centroidi specificati.
(defun nearest (o cs min) 
        (if     (null cs)
                min
                (if     (< (distance (first cs) o) (distance min o))
                        (nearest o (rest cs) (first cs))
                        (nearest o (rest cs) min))))

(defun assign (o cs) (nearest o cs (first cs)))

;;; Accoppia ciascuna osservazione con il suo centroide più vicino
(defun assignall (obs cs)
        (if     (null obs)
                nil
                (cons   (cons (first obs) (cons (assign (first obs) cs) nil)) 
                        (assignall (rest obs) cs))))

;;; Raggruppa tutte le osservazioni che condividono il centroide indicato (più vicino) a partire da un insieme di coppie punto-centroide
;;; Per qualche motivo (last <list>) ritorna una lista e non un singolo elemento meglio usare (second <list>) che in questo caso equivale.
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

;;; Crea k = (length <lista di centroidi>) clusters attorno ai centroidi sulle osservazioni
(defun partition (obs cs) (groupall (assignall obs cs) cs))

;;; *
(defun centroid (observations) (vmean observations))

(defun centroids (klus) 
        (if     (null klus)
                nil
                (cons (centroid (first klus)) (centroids (rest klus)))))

;;; Il core del programma, ricomputa clusters e ricalcola i centroidi fino a che la condizione di terminazione non sia raggiunta
(defun repart (obs cs klus) 
        (if     (equal cs (centroids klus))
                (cons cs (cons klus nil))
                (repart obs (centroids klus) (partition obs (centroids klus)))))

(defun lloydkmeans (obs cs) (repart Obs cs (partition Obs cs)))

;;; Estrae i k centroidi dalle osservazioni pseudo-casualmente
(defun initialize(obs k) 
        (mapcar (lambda (x) (nth x obs)) (randset k (length obs))))

(defun kmeans0 (obs k) 
        (if     (and (> k 0) (<= k (length obs)))
                (lloydkmeans obs (initialize obs k))
                nil))

;;; *
(defun kmeans (observations k) 
        (second (kmeans0 observations k)))
