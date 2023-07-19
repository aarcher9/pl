(load "km.lisp")

;; Prestare attenzione che 8 non equivale a 8.0 (come anche in altri linguaggi)
;; Esiste la funzione (coerce ...) per le conversioni

;; --- Supporto
(assert (equal (delall `(1 2 2 1 4 6 4 4) `(1 4)) `(2 2 6)))
(assert (equal (delall `(1 2) `(8)) `(1 2)))
(assert (equal (delall `(8) `(8)) `()))

;; --- Vettori
(assert (equal (vsum `((1 2) (2 3) (2 3) (6 7))) `(11 15)))
(assert (equal (vsum `((1 2) (2 3))) `(3 5)))
(assert (equal (vsum `((1 2))) `(1 2)))

(assert (equal (vmean `((1 2) (2 3) (2 3) (6 7))) (list (/ 11 4) (/ 15 4))))

(assert (equal (vplus `(1 2) `(7 8)) `(8 10)))
(assert (equal (vplus `(-1) `(4)) `(3)))
(assert (equal (vplus `(0) `(0)) `(0)))

(assert (equal (vminus `(1 2) `(7 8)) `(-6 -6)))
(assert (equal (vminus `(-1) `(4)) `(-5)))
(assert (equal (vminus `(0) `(0)) `(0)))

(assert (equal (norm `(3 4)) 5.0))
(assert (equal (norm `(0)) 0.0))

(assert (equal (scalarprod 10 `(1 2 3)) `(10 20 30)))
(assert (equal (scalarprod 10 `(0)) `(0)))

(assert (equal (distance `(-2 -3) `(-1 -2)) (expt 2 (/ 2))))


;; --- Algoritmo k-means
(defparameter Cs (initialize Obs 3))
(if nil (print (initialize Obs 3)))
(if nil (print (assignall Obs (initialize Obs 3))))
(if nil (print (partition Obs tcs_k3)))
(if nil (print (centroids (partition Obs tcs_k3))))

;; (print (partition Obs Cs))
(print (repart Obs Cs (partition Obs Cs)))