; SICP 1.20
; Normal-order evaluation of (gcd a b)  -- 2nd attempt notes

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (mod a b))))

>>>(gcd 206 40)

>>(gcd 206 40)

(if (= b 0)
    a
    (gcd b (mod a b)))

(if (= 40 0)
    206
    (gcd 40 (mod 206 40)))

>>(gcd 40 (mod 206 40))

(if (= (mod 206 40) 0)
    40
    (gcd (mod 206 40) (mod 40 (mod 206 40))))

;   evaluate remainder in conditional:
;   (mod 206 40) = 6

(if (= 6 0)
    40
    (gcd (mod 206 40) (mod 40 (mod 206 40))))

>>(gcd (mod 206 40) (mod 40 (mod 206 40)))

(if (= (mod 40 (mod 206 40)) 0)
    (mod 206 40)
    (gcd (mod 40 (mod 206 40))
         (mod (mod 206 40) 
              (mod 40 (mod 206 40)))))

; xjintsa we evaluate remainder in conditional:
; (mod 40 (mod 206 40)) = (mod 40 6) = 4
; 2 remainders evald

(if (= 4 0)
    (mod 206 40)
    (gcd (mod 40 (mod 206 40))
         (mod (mod 206 40)
              (mod 40 (mod 206 40)))))

; I'm starting to get a feel for normal-order and Scheme's parenthesis nesting

>>(gcd (mod 40 (mod 206 40))
       (mod (mod 206 40)
            (mod 40 (mod 206 40))))

(if (= (mod (mod 206 40)
            (mod 40 (mod 206 40)))
       0)
       (mod 40 (mod 206 40))
       (gcd (mod (mod 206 40)
                 (mod 40 (mod 206 40))
            (mod (mod 40 (mod 206 40))
                 (mod (mod 206 40)
                      (mod 40 (mod 206 40))))))

; Again evaluate remainders "mod" in conditional:
; (mod (mod 206 40) (mod 40 (mod 206 40))) = 
; = (mod 6 (mod 40 6))  = (mod 6 4) = 2
; 4 remainders evald

( if (= 2 0)
     (mod 40 (mod 206 40))
     (gcd (mod (mod 206 40)
               (mod 40 (mod 206 40)))
          (mod (mod 40 (mod 206 40))
               (mod (mod 206 40))
                    (mod 40 (mod 206 40))))))

>>(gcd (mod (mod 206 40)
            (mod 40 (mod 206 40)))
       (mod (mod 40 (mod 206 40))
            (mod (mod (mod 206 40))
                 (mod 40 (mod 206 40)))))

(if (= (mod (mod 40 (mod 206 40))
            (mod (mod 206 40)
                 (mod 40 (mod 206 40))))
       0)
       (mod (mod 206 40)
            (mod 40 (mod 206 40)))
       (gcd (mod (mod 40 (mod 206 40))
                 (mod (mod 206 40)
                      (mod 40 (mod 206 40))))
            (mod (mod (mod 206 40)
                      (mod 40 (mod 206 40)))
                 (mod (mod 40 ((mod 206 40))
                      (mod (mod 206 40)
                           (mod 40 (mod 206 40)))))))

; Evaluate nested remainder ops in conditional:
; (mod (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40))))  = 
; = (mod (mod 40 6) (mod 6 (mod 40 6))) = (mod 4 (mod 6 4)) = (mod 4 2) = 0
; 7 remainders evald

(if (= 0 0) 0
    (mod (mod 206 40)
         (mod 40 (mod 206 40)))
    (gcd (mod (mod 40 (mod 206 40))
              (mod (mod 206 40)
                   (mod 40 (mod 206 40))))
         (mod (mod (mod 206 40)
                   (mod 40 (mod 206 40)))
              (mod (mod 40 (mod 206 40))
                   (mod (mod 206 40)
                        (mod 40 (mod 206 40)))))))

>>(mod (mod 206 40)
       (mod 40 (mod 206 40)))

; eval xjara tjahara set of remainder ops:
; (mod (mod 206 40) (mod 40 (mod 206 40))) = (mod 6 (mod 40 6)) = (mod 6 4) = 2
; 18 total remainders evald.

;----------------------------------------------------------
; SICP 1.20

; First stage notes:

; SICP 1.20
; Normal order evaluation of (gcd a b)
(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (mod a b))))


>>> (gcd 206 40)

>>(gcd 206 40)

(if (= 40 0)
    206
    (gcd 40 (mod 206 40)))

>>(gcd 40 (mod 206 40))

(if (= (mod 206 40) 0)
    40
    (gcd (mod 206 40) (mod 40 (mod 206 40))))

(if (= 6 0) ;;  1 remainder evaluated
    40
    (gcd (mod 206 40) (mod 40 (mod 206 40))))

>>(gcd (mod 206 40) (mod 40 (mod 206 40)))

(if (= (mod 40 (mod 206 40)) 0)
    (mod 206 40)
    (gcd (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40)) ) ))

;   Here, both nested mod ops (subst for b) are evaluated
; mod 206 40 = 6  --  mod 40 6 = 4  ==> (mod 40 (mod 206 40)) = 4
-------------------
(if (= 4 0)
    6
    (gcd 4 (mod (mod 206 40) (mod 40 (206 40))))
    =>
    (gcd 4 (mod 6 4)) = (gcd 4 2)

;   tsundela:

(if (= 4 0)
    6
    (gcd 4 2)
------------------- ; a = (mod 206 40) b = (mod 40 (mod 206 40))
(if (= 4 0)
    (mod 206 40)
    (gcd (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40)) ) ))

;   making this look more legible:

(if (= 4 0)
    (mod 206 40)
    (gcd (mod 40 (mod 206 40))
         (mod (mod 206 40)
              (mod 40 (mod 206 40)) ) ))

>>(gcd (mod 40 (mod 206 40))
       (mod (mod 206 40)
            (mod 40 (mod 206 40)) ) ))

;  aha! so in normal order you allow the entire expression to expand..
;  so when do you know when to evaluate then?
;   >> when you evaluate the conditional.
;   just subst the equiv expanded expression for a & b where appropriate

(if (= b 0)
    a
    (gcd b (mod a b)))

a = (mod 206 40)
b = (mod (mod 206 40)
         (mod 40 (mod 206 40)) )

;   tsundela:

(if (= (mod (mod 206 40)
            (mod 40 (mod 206 40)) )
    0)
    (mod 206 40)
    (gcd (mod (mod 206 40)
              (mod 40 (mod 206 40)) )
         (mod (mod 40 (mod 206 40))
              (mod (mod 206 40)
                   (mod 40 (mod 206 40)) ))) )
;
;   again, multiple nested mod ops subst for b, need to be evaluated:

(mod (mod 206 40) (mod 40 (mod 206 40))) =
= (mod 6 (mod 40 6)) = mod 6 4 = 2

(if (= 2 0)       ; 4 remainders evaluated
    (mod 206 40)
    (gcd (mod (mod 206 40)
              (mod 40 (mod 206 40)) )
         (mod (mod 40 (mod 206 40))
              (mod (mod 206 40)
                   (mod 40 (mod 206 40)) ))) )





;
-*- mode:scheme;-*-





