; SICP 1.18
; Code the Russian Peasant Method, Русский крестьянский способ, of multiplication. Addition, doubling, halving; Log # of steps.


(define (ruski x y)
	(define (sposob x y a)
		(cond ((< x 1) a)
			((even? x) (sposob (halve x) (double y) a))
			(else (+ (sposob (halve x) (double y) (+ a y)))) ))
	(sposob x y 0))

(define (halve x) (/ x 2))
(define (double x) (+ x x))


;------------------------------------
; I got as far as this, turning the wikipedia definition of the russian peasant method into code, before I stopped from infinite loops:

(define (russki x y)
	(define (sposob x y a)
		(cond ((= x 1) (+ a y))
			  ((even? x) (sposob (halve x) (double y) a))
			  (else (+ (sposob (halve x) (double y) (+ a y)))) ))
	(cond ((or (= x 0) (= y 0)) 0)
		  ((= x 1) y)
		  (else (sposob x y 0))) )

(define (halve x) (/ x 2))
(define (double x) (+ x x))

;

(define (ruski x y)
	(define (sposob x y a)
		(cond ((< y 1) a)
			  ((even? x) (sposob (halve x) (double y) a))
			  (else (+ (sposob (halve x) (double y) (+ a y)))) ))
	(sposob x y 0))

	
; I found my error: I was using (y) as my end-state variable... but I'm doubling (y)! It never ends. Set the end condition to if (x) is less than 1, for two reasons:
;	1: I'm halving x, so it will terminate. 2: I'm strictly following the Russian peasant method for multiplication. Solutions online have different takes that are similar but not the same. I wanted to take an existing historical algorithm, and turn it into code. It worked.

;: Final Code Below:

(define (ruski x y)
	(define (sposob x y a)
		(cond ((< x 1) a)
			  ((even? x) (sposob (halve x) (double y) a))
			  (else (+ (sposob (halve x) (double y) (+ a y)))) ))
	(sposob x y 0))

(define (halve x) (/ x 2))
(define (double x) (+ x x))
	
;--------------------------------------
; used to troubleshoot once I hit the infinity loops:
;	http://community.schemewiki.org/?sicp-ex-1.18
;	https://wqzhang.wordpress.com/2009/06/09/sicp-exercise-1-18/
;--------------------------------------

;	mechanism:
;	(cond ((= x 1) a)
		  ((even? x) (способ x y a))
;		  ((+ (способ (halve x) (double y) (+ a y))))

;	still needs to handle either x or y = 1 initially...


;
-*- mode: scheme;-*-
