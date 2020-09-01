#lang racket/gui

; Create a dialog
(define dialog (instantiate dialog% ("Example")))
 
; Add a text field to the dialog
(define text-field (new text-field% [parent dialog] [label "Your name"]))
 
; Add a horizontal panel to the dialog, with centering for buttons
(define panel (new horizontal-panel% [parent dialog]
                                     [alignment '(center center)]))
 
; Add Cancel and Ok buttons to the horizontal panel
(new button% [parent panel] [label "Cancel"] 
    [callback (lambda (button event)
                         (exit))])

(new button% [parent panel] [label "Ok"]
    [callback (lambda (button event)
                         (send dialog set-label (send text-field get-value)))])

(when (system-position-ok-before-cancel?)
  (send panel change-children reverse))
 
; Show the dialog
(send dialog show #t)