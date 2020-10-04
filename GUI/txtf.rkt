#lang racket/gui

(define app (new frame%
                   [label "Example"]
                   [width 400]
                   [height 300]))

(define panel (new horizontal-panel% [parent app]
                                     [alignment '(center center)]))

(define editor-canvas (new editor-canvas%
                           (parent panel)
                           (label "Editor Canvas")))
(define text (new text%))
(send text insert "Editor Canvas\n")
(send editor-canvas set-editor text)

(define btn-panel (new vertical-panel% [parent panel]
                                       [alignment '(center center)]))

(define text-field (new text-field%
                        (label "Text")
                        (parent btn-panel)
                        (init-value "Field")))


(define btn-add (new button%
                    (parent btn-panel)
                    (label "Add text")
                    [callback (lambda (button event)
                         (send text insert (string-append (send text-field get-value) "\n")))]))

(define btn-clean (new button%
                    (parent btn-panel)
                    (label "Clean")
                    [callback (lambda (button event)
                         (send text erase))]))


(send app show #t)