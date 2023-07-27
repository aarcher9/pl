% Leonetti Alessandro 746215
% De Grandis Marco    745996
% Cassataro Riccardo  736424 

Test aggiuntivi e funzionanti:

(kmeans '((3.0 7.0)(0.5 1.0)(0.8 0.5)(1.0 8.0)(0.9 1.2)(6.0 4.0)(7.0 5.5)(4.0 9.0)(9.0 4.0)) 3)

(centroid '((3.0 7.0)(0.5 1.0) (0.8 0.5) (1.0 8.0) (0.9 1.2) (6.0 4.0) (7.0 5.5) (4.0 9.0) (9.0 4.0)))

(v+ '(0.8 0.5) '(1.0 8.0))

(v- '(0.8 0.5) '(1.0 8.0))

(norm '(0.8 0.5))




Alcune observation d'esempio:



(defparameter observations1
'((3.0 7.0) (0.5 1.0) (0.8 0.5) (1.0 8.0)
(0.9 1.2) (6.0 4.0) (7.0 5.5)
(4.0 9.0) (9.0 4.0)))


(defparameter observations2
'((0 0) (1 0) (2 0) (5 0) (6 0) (10 0) (11 0) (12 0) (13 0) (15 0))
)


(defparameter observations3
'((0 0) (1 0) (2 0) (50 0) (60 0) (100 0) (101 0) (102 0) (103 0) (105 0))
)