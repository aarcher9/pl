(load "km.lisp")

;; Prestare attenzione che 8 non equivale a 8.0 (come anche in altri linguaggi)
;; Esiste la funzione (coerce ...) per le conversioni

;; (assert (equal (vsum `((1 2) (2 3) (2 3) (6 7))) `()))
;; (assert (equal (vsum `((1 2) (2 3))) `(3 5)))
;; (assert (equal (vsum `((1 2))) `(1 2)))

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

(initialize Observations 3)
(print (vsum `((1 2) (1 2))))