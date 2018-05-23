(define pow1 (x y)
    (if (= y 0) 1
        (* x (pow1 (- y 1)))))