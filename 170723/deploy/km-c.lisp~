;;;; -*- Mode: Lisp -*-
;;;; 826296 Agosti Andrea
;;;; <>

;;; --- Supporto
;;; L'intervallo generato di interi è [0, lim)
(defun randnum (lim) (random lim (make-random-state t)))

;;; Genera una sequenza di numeri (quindi diversi) in [0, n)
(defun make-seq (n) 
        (if     (> n 0)
                (cons (- n 1) (make-seq (- n 1)))
                nil))

(defun pick-first-n (l n)
        (if     (> n 0)
                (cons (first l) (pick-first-n (rest l) (- n 1)))
                nil))

(defun new_randset (ord-seq i)
        (if     (null (rest ord-seq))
                (cons (first ord-seq) nil)
                (cons   (nth i ord-seq) 
                        (new_randset    (remove (nth i ord-seq) ord-seq) 
                                        (randnum (- (length ord-seq) 1))))))

(defun randset (n lim) 
        (pick-first-n (new_randset (make-seq lim) (randnum lim)) n))


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
                        (cons   (+ (first vector1) (first vector2)) 
                                (vplus (rest vector1) (rest vector2))))))

;;; *
(defun vminus (vector1 vector2) (vplus vector1 (scalarprod -1 vector2)))

;;; *
(defun innerprod (vector1 vector2) 
        (cond   ((not (eq (length vector1) (length vector2))) 
                    0.0)
            ((and (null vector1) (null vector2)) 
                    0.0)
            (t
                (+  (* (first vector1) (first vector2)) 
                    (innerprod (rest vector1) (rest vector2))))))

;;; *
(defun norm (vector) (expt (innerprod vector vector) (/ 2)))

(defun distance (vector1 vector2) (norm (vminus vector1 vector2)))

(defun vmean (vs) (scalarprod (/ (length vs)) (vsum vs)))

(defun vsum (vs)
        (if     (null (rest vs))
                (first vs)
                (vplus (first vs) (vsum (rest vs)))))


;;; --- Algoritmo k-means
;;; Il parametro min deve essere inizialmente 
;;; SOLTANTO ed ESCLUSIVAMENTE uno dei centroidi specificati.
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

;;; Raggruppa tutte le osservazioni che condividono il centroide 
;;; indicato (più vicino) a partire da un insieme di coppie punto-centroide
;;; Per qualche motivo (last <list>) ritorna una lista e 
;;; non un singolo elemento meglio usare (second <list>) 
;;; che in questo caso equivale.
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

;;; Crea k = (length <lista di centroidi>) clusters attorno 
;;; ai centroidi sulle osservazioni
(defun partition (obs cs) (groupall (assignall obs cs) cs))

;;; *
(defun centroid (observations) (vmean observations))

(defun centroids (klus) 
        (if     (null klus)
                nil
                (cons (centroid (first klus)) (centroids (rest klus)))))

;;; Il core del programma, ricomputa clusters e ricalcola i centroidi 
;;; fino a che la condizione di terminazione non sia raggiunta
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
                (error "Il valore di K deve 
                    essere un numero positivo non-zero minore o 
                    uguale del numero di osservazioni")))

;;; *
(defun kmeans (observations k) 
        (second (kmeans0 observations k)))
