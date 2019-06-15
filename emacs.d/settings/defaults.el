;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

; Lines should be 80 characters wide
(setq fill-column 80)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)

;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(provide 'defaults)
