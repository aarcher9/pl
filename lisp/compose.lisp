(defun compose (g f) 
        (lambda (x) (funcall g (funcall f x))))

(defun f (x) (+ (* 2 x) 1))
(defun g (x) (- x 4))
(print (funcall (compose `g `f) 3))