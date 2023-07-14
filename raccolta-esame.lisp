;; Probabile, anzi quasi matematico che ci siano codici giá presenti nella repo, sono stati messi qui per comodità di accesso.


;; ===== Conversione in decimale da binario ===== ;;
(defun 2to10 (b c)
        (cond   ((null b) 
                        0)
                ((not (null b)) 
                        (+ (* (first b) (expt 2 (- c 1))) (2to10 (rest b) (- c 1))))))

(defun bcd (b) 
        (2to10 b (length b)))

(defun t_10 () 
        (print (bcd `(1 0 0 0)))
        (print (bcd `(1 0 1 0 1 0)))
        (print (bcd `(0 0 0 1 0 0 0))))


;; ===== repeated ===== ;;
(defun square (x) (* x x))

(defun repeated (f n) 
        (cond   ((zerop n) (lambda (x) x))
                ((= n 1) f)
                (t (lambda (x) (funcall f (funcall (repeated f (1- n)) x))))))

(defun t_20 ()
        (print (funcall (repeated `square 2) 3))
        (print (funcall (repeated `square 3) 2)))


;; ===== JSON key-value ===== ;;
(defparameter e `(name "Ugo" surname "Mascetti"))

(defun get-value (key json-obj) 
        (cond   ((null json-obj) `:undefined)
                ((eq key (first json-obj)) (first (rest json-obj)))
                (t (get-value key (rest json-obj))) ))

(defun add-key-value (key value json-obj) 
        (cons key (cons value json-obj)))

(defun make-object (keys values)
        (cond   ((or (null keys) (null values)) nil)
                (t (cons (first keys) (cons (first values) (make-object (rest keys) (rest values)))) )))

(defun t_30 ()
        (print (get-value `name e))
        (print (add-key-value `addr "Via col vento" e))
        (print (make-object `(numero capelli) `(23 "biondi"))))


;; ===== Conversione let in lambda ===== ;;
(defun f (x y) 
        (let    ((a (+ x (* x y))) (b (* 4 y)))
                (lambda (y x) (+ (* x a) (* y (square b)) (* a b))) ))

;; La trasformazione prevede soltanto di sostituire le variabili dichiarate nella let e di passarle come parametri alla lambda più interna in modo da salvarne il valore ma mascherarle dall'esterno.
(defun g (x y)
        (lambda (y x)
                (funcall 
                        (lambda (a b) (+ (* x a) (* y (square b)) (* a b)))
                        (+ x (* x y))
                        (* 4 y))))

(defun t_40 () 
        (print (funcall (f 2 2) 2 2)))

(defun t_41 () 
        (print (funcall (g 2 2) 2 2)))


;; ===== nopred / filtra ===== ;;
;; Se cambio null con un not null ottengo il comportamento opposto dovrei solo implementare un modo per rimuovere in NIL.
(defun nf (p l)
        (cond   ((null l) nil)
                ((atom l) 
                        (cond ((null (funcall p l)) l)))
                ((listp l)
                        (cons (nf p (first l)) (nf p (rest l))))))

(defun p (x) 
        (or (equal x 2) (equal x 5) (equal x 8)))

(defun t_50 () 
        (print (nf `p `(2 6 5 (2 4 5) 9))))


;; ===== reduce ===== ;;
(defun h (x y) (+ x y))

;; Combinazione associativa a sinstra degli elementi
(defun reduce* (fun elements) 
        (cond   ((>= (length elements) 2)
                        (reduce* fun (cons (funcall fun (first elements) (second elements)) (rest (rest elements)))))
                (t (first elements)) ))

(defun t_60 () 
        (print (reduce* `h `(1 2 3 4 8))))


;; ===== aggiungi-42 ===== ;;
(defun j (x) (eq 3 x))
(defun aggiungi-42 (x) (+ x 42))

;; Questa struttura si usa spessisimo, memorizzare può essere super utile! 
(defun tadd (tree) 
        (cond   ((or (eq (length tree) 0) (null tree)) nil)
                ((atom (first tree))
                        (cons (aggiungi-42 (first tree)) (tadd (rest tree))))
                ((listp (first tree))
                        (cons (tadd (first tree)) (tadd (rest tree))))
        ))

(defun t_70 () 
        (print (tadd `(1 2 (3 5 6 (8)) 4 8))))


;; ===== remove-number ===== ;;
(defun remove-number (n l) 
        (cond   ((null l) nil)
                ((eq (first l) n) (rest l))
                (t (cons (first l) (remove-number n (rest l))))
        ))

(defun t_80 () 
        (print (remove-number 3 `(1 3 2 3 5 5 4 8))))

(t_80)
