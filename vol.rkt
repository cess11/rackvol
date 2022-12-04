#lang racket/base

(require racket/system
         racket/port
         racket/gui/easy
         racket/gui/easy/operator
         )

(define vol-level 50)

(define (vol-change vol-new)
  (with-output-to-string
    (lambda ()
      (system/exit-code (string-append "amixer set Master " (number->string vol-new) "%")))))

(define (vol-up)
  (if (<= vol-level 95)
      (let ([vol-new (+ vol-level 5)])
        (set! vol-level vol-new)
        (vol-change vol-new))
      (void)))

(define (vol-down)
  (if (>= vol-level 5)
      (let ([vol-new (- vol-level 5)])
        (set! vol-level vol-new)
        (vol-change vol-new))
      (void)))

(define (app)
  (window
   #:title "Svolumkontroll"
   (vpanel
    (hpanel
     (button "+" vol-up)
     (button "-" vol-down)))))

(module+ main
  (render (app)))
