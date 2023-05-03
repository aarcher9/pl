(defun append-lists(a b) 
    (if (null a)
        b
        (cons (car a) (append-lists (cdr a) b))))

(append (list 1 2 3) (list 4 5 6))