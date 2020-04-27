#lang racket/base
(require racket/system
         racket/port
         racket/gui)

(define vol-level 50)

(define (vol-change vol-new)
  (with-output-to-string
    (lambda ()
      (system (string-append "amixer set Master " (number->string vol-new) "%")))))

(define (vol-up)
  (let ([vol-new (+ vol-level 5)])
    (set! vol-level vol-new)
    (vol-change vol-new)))

(define (vol-down)
  (let ([vol-new (- vol-level 5)])
    (set! vol-level vol-new)
    (vol-change vol-new)))

(define vol-win (new frame%
                     [label "Svolumkontroll"]))

(define vol-panel (new vertical-panel%
                       [parent vol-win]))

(define vol-up-button (new button%
                           [parent vol-panel]
                           [label "Höj"]
                           [callback (lambda (button event)(void (vol-up)))]))

(define vol-down-button (new button%
                           [parent vol-panel]
                           [label "Sänk"]
                           [callback (lambda (button event)(void (vol-down)))]))

(send vol-win show #t)
