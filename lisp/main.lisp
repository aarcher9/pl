; + è praticamente una funzione in tutto e per tutto
(+ 6 6)


(defun square(n) (* n n))
(square 10)

(defun make-adder (x) (lambda (y) (+ x y)))

((make-adder 6) 7)
(make-adder 7)