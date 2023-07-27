;;;; De Grandis Marco    745996
;;;; Leonetti Alessandro 746215
;;;; Cassataro Riccardo  736424 


; (kmeans observations k): applies the kmeans algorithm to the list of observations from a given k

(defun kmeans (observations k)
 (kmeans0                                                   ; kmeans0 iterates until a solution is found
   observations
   '()                                                      ; initial clusters
   (partition observations (rand-elements observations k))  ; new clusters
 )
)

; (kmeans0 obs clusters newClusters): iterates until a solution is found
(defun kmeans0 (observations clusters newClusters)
 (cond
  ((sameClusters clusters newClusters) clusters)  ; if the clusters are the same, we have a solution!
  (T        
    (kmeans0                                      ; else, compute one more iteration
       observations
       newClusters
       (partition observations (recomputeCentroids newClusters))
     )
  )
 )
)

; (v+ v1 v2): adds v1 + v2
(defun v+ (v1 v2)
 (cond
  ((= 0 (length v1)) '())
  (T (cons (+ (car v1) (car v2)) (v+ (cdr v1) (cdr v2))))
 )
)

; (v- v1 v2): substracts v1 - v2
(defun v- (v1 v2)
 (cond
  ((= 0 (length v1)) '())
  (T (cons (- (car v1) (car v2)) (v- (cdr v1) (cdr v2))))
 )
)

; (*i v1 v2): dot product between v1 and v2
(defun *i (v1 v2)
 (cond
  ((= 0 (length v1)) 0)
  (T (+ (* (car v1) (car v2)) (*i (cdr v1) (cdr v2))))
 )
)

; (norm v): computes the norm for vector v
(defun norm (v)
 (sqrt (*i v v) )
)

; (vecByScalar v s): returns v*s (v a vector, s a scalar)
(defun vecByScalar (v s)
 (cond
  ((= 0 (length v)) '())
  (T (cons (* s (car v)) (vecByScalar (cdr v) s)))
 )
)

; (centroid l): computes the centroid of cluster l (l is a list of points)
(defun centroid (l)
  (vecByScalar (reduce #'v+ l) (/ 1.0 (length l)))  ; adds all the vectors and divides it by the number of vectors
)

; (v= v1 v2): compares two vectors v1 and v2 for equality
(defun v= (v1 v2)
 (cond
  ((null v1) T)
  ((= (car v1) (car v2)) (v= (cdr v1) (cdr v2)))
  (T '())
 )
)

; (v< v1 v2): compares two vectors v1 and v2 in order to be able to sort a list of vectors
(defun v< (v1 v2)
 (cond
  ((null v1) '())
  ((< (car v1) (car v2)) T)           ; first compare using the first coordinate
  ((> (car v1) (car v2)) '())
  (T (v< (cdr v1) (cdr v2)))          ; if the coordinate is the same, check the next coordinate
 )
)


; (partition observations cs): partitions the observations in k clusters given cs centroids
(defun partition (observations cs)
  (mapcar
   #'(lambda (x) (mapcar #'(lambda (y) (cadr y)) x ) )
   (partition0 (sort (mapcar #'(lambda (x) (list (closest x cs )x)) observations) #'(lambda (x y) (v< (car x) (car y)))))
  )
)

(defun partition0 (l)
 (cond
  ((null l) '())
  (T (cons (takeWhile l #'(lambda (x) (v= (car x) (caar l)))) (partition0 (dropWhile l #'(lambda (x) (v= (car x)(caar l)))))))
 )
)

; (n-th l n): returns the nth element from l and l without the nth element
(defun n-th (l n)
 (cond
   ((= 0 n) (list (car l) (cdr l)))
   (T (let ((lr (n-th (cdr l) (- n 1))))
           (list (car lr) (cons (car l) (cadr lr)))
      )
   )
 )
)

; (rand-elements l k): returns k random elements from l
(defun rand-elements (l k)
 (cond
  ((= k 0) '())   ; nothing to do
  (T (let ((newList (n-th l (random (length l)))))
          (cons (car newList) (rand-elements (cadr newList) (- k 1)))
     )
  )
 )
)

; (sameClusters cl1 cl2 f) returns T is cl1 and cl2 are the same clusters. Use function f to compare
(defun sameClusters (cl1 cl2)
 (cond
   ((= (length cl1)(length cl2))   ; first check cluster sizes
   (cond
    ((null cl1) T)                   ; both lists are empty => same clusters
    (T

    (let ((index (getIndexOf cl2 (caar cl1) (curry #'inList #'v=) 0)))
         (cond
          ((= index -1) nil)          ; not found! they are not the same clusters
          (T                           ; else... element found
          (let ((nl (n-th cl2 index)))
              (and
                    (sameCluster (car cl1) (car nl))   ; check if the clusters are the same
                    (sameClusters (cdr cl1) (cadr nl))   ; and the reminding clusters also match
              )
          )
          )
         )
      )
     )
    )
   )
   (T nil)
 )
)

; (sameCluster cl1 cl2) returns T is cluster cl1 and cl2 are the same
(defun sameCluster (cl1 cl2)
 (cond
  ((= (length cl1) (length cl2))                 ; first check cluster sizes
   (cond
    ((null cl1) T)                               ; both lists are empty => same clusters!
    (T
   (let ((index (getIndexOf cl2 (car cl1) #'v= 0)))
     (cond
      ((= index -1) nil)
      (T (let ((nl (n-th cl2 index)))
          (sameCluster (cdr cl1) (cadr nl)
          )
         )
      )
     )
    )
   )
   )
  )
  (T nil)                                        ; clusters of different sizes => different clusters  
 )
)

; (getIndexOf l v f index): returns the index of v inside l. Use function f to compare
(defun getIndexOf (l v f index)
 (cond
  ((null l) -1)              ; v not found
  ((funcall f (car l) v) index) ; v found in (car l)
  (T (getIndexOf (cdr l) v f (+ index 1)))
 )
)

; (inList l v f): returns T if v is inside list l (use function f to compare elements)
(defun inList (f l v)
 (cond
   ((null l) nil)
   ((funcall f v (car l)) T)
   (T (inList f (cdr l) v))
 )
)

; function for currying
(defun curry (fn arg) (lambda (&rest args) (apply fn arg args))) 

; recomputes the centroids of the given clusters
(defun recomputeCentroids (clusters)
 (mapcar #'(lambda (x) (centroid x)) clusters)
)

; (takeWhile l f): takes elements of l while f is true
(defun takeWhile (l f)
 (cond
  ((null l) '())
  ((funcall f (car l)) (cons (car l) (takeWhile (cdr l) f)))
  (T '())
 )
)

; (dropWhile l f): drops elements of l while f is true
(defun dropWhile (l f)
 (cond
  ((null l) '())
  ((funcall f (car l))  (dropWhile (cdr l) f))
  (T l)
 )
)

; (dist p1 p2): computes the distance from p1 to p2
(defun dist (p1 p2)
 (norm (v- p1 p2))
)

; (closest x cs): given a list a point x computes the element of cs closer to x 
(defun closest (x cs)
 (cond
  ((null (cdr cs)) (car cs))
  (T (let 
      ((dst1 (dist x (car cs)))
       (dst2 (dist x (closest x (cdr cs))))
      ) 
      (
        cond
         ((< dst1 dst2) (car cs))
         (T (closest x (cdr cs)))
       )))
 )
)
