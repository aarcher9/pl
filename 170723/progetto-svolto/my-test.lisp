(load "km.lisp")

;; --- Parametri per testing
(defparameter Obs 
        `(      (3.0 7.0) (0.5 1.0) (0.8 0.5) (1.0 8.0) 
                (1.8 1.2) (6.0 4.0) (7.0 5.5) (4.0 9.0) 
                (9.0 4.0)))

(defparameter real-tcs_k3
        `((2.6666667 8) (1.0333333 0.9) (7.3333335 4.5)))

(defparameter tcs_k3
        `((2.666 8) (1.033 0.9) (7.333 4.5)))

(defparameter exp-clus_k3 
        `(      ((3.0 7.0) (1.0 8.0) (4.0 9.0)) 
                ((0.5 1.0) (0.8 0.5) (1.8 1.2))
                ((6.0 4.0) (7.0 5.5) (9.0 4.0))))


;; --- Algoritmo k-means

;; Casi normali, input corretto
(defun test_base () 
        (kmeans Obs 1)
        (kmeans Obs 9)
        (kmeans Obs 3)
        (kmeans Obs 8))

(defun test_limit_k ()
        ;; Se non gestito: errore strano
        (kmeans Obs 0)
        ;; Se non gestito: freeza 
        (kmeans Obs 10))

(test_limit_k)