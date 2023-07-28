(load "km.lisp")

;;; --- Parametri per testing
(defparameter Obs 
        `(      (3.0 7.0) (0.5 1.0) (0.8 0.5) (1.0 8.0) 
                (1.8 1.2) (6.0 4.0) (7.0 5.5) (4.0 9.0) 
                (9.0 4.0)))

(defparameter Obs1 `((1 1) (2 1) (4 3) (5 4)))
(defparameter v3 (list 1 2 3))

(defparameter exp-cs_k3
        `((2.666 8) (1.033 0.9) (7.333 4.5)))

(defparameter exp-klus_k3 
        `(      ((3.0 7.0) (1.0 8.0) (4.0 9.0)) 
                ((0.5 1.0) (0.8 0.5) (1.8 1.2))
                ((6.0 4.0) (7.0 5.5) (9.0 4.0))))

;;; Prestare attenzione che 8 non equivale a 8.0 (come anche in altri linguaggi)
;;; Esiste la funzione (coerce ...) per le conversioni

;;; --- Supporto


;;; --- Vettori
(assert (equal (scalarprod 10 `(1 2 3)) `(10 20 30)))
(assert (equal (scalarprod 10 `(0)) `(0)))
(assert (equal (scalarprod 10 nil) nil))
(assert (equal (scalarprod nil `(1 2)) nil))

(assert (equal (vplus `(1 2) `(7 8)) `(8 10)))
(assert (equal (vplus `(-1) `(4)) `(3)))
(assert (equal (vplus `(0) `(0)) `(0)))
(assert (equal (vplus nil `(1)) `(1)))

(assert (equal (vminus `(1 2) `(7 8)) `(-6 -6)))
(assert (equal (vminus `(-1) `(4)) `(-5)))
(assert (equal (vminus `(0) `(0)) `(0)))

(assert (equal (innerprod nil nil) 0.0))
(assert (equal (innerprod nil `(1)) 0.0))

(assert (equal (norm `(3 4)) 5.0))
(assert (equal (norm `(0)) 0.0))
(assert (equal (norm nil) 0.0))

(assert (equal (distance `(-2 -3) `(-1 -2)) (expt 2 (/ 2))))
(assert (equal (distance nil `(0 2)) 2.0))

(assert (equal (vsum `((1 2) (2 3) (2 3) (6 7))) `(11 15)))
(assert (equal (vsum `((1 2) (2 3))) `(3 5)))
(assert (equal (vsum `((1 2))) `(1 2)))
(assert (equal (vsum `(nil (1 2))) `(1 2)))
(assert (equal (vsum `(nil)) nil))

(assert (equal (vmean `((1 2) (2 3) (2 3) (6 7))) (list (/ 11 4) (/ 15 4))))
(assert (equal (vmean `((1 2) nil)) (list (/ 1 2) 1)))

(defun test_example_vectors ()
        (print v3)
        (print (sqrt (innerprod v3 v3)))
        (print (norm v3))
        (print (vplus v3 (list 10 0 42)))
        (format t "~%"))


;;; --- Algoritmo k-means
(defun kmeansdbg (km0) 
        (format t "~%C:")
        (format t "~{~%> ~a~}~%" (first km0))
        (format t "Clusters:")
        (format t "~{~%> ~a~}" (second km0))
        (format t "~%"))

;;; Casi normali, input corretto
(defun test_base (obs k)
        (format t "~%----- K = ~a" k)
        (kmeansdbg (kmeans0 obs k)))

(defun test_kmeans (obs ks) 
        (if     (null ks)
                "Done!"
                (progn (test_base obs (first ks)) (test_kmeans obs (rest ks)))))

(defun test_limit_k0 ()
        (kmeans (kmeans0 Obs 0)))

(defun test_limit_k10 () 
        (kmeans (kmeans0 Obs 10)))

;; (test_example_vectors)
;; (test_kmeans Obs `(3 1 8 5 9))
;; (test_kmeans Obs1 `(1 2 3 4))
;; (test_limit_k0)
;; (test_limit_k10)