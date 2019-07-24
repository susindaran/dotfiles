;; stop creating backup~ files
(setq make-backup-files nil)

;; stop creating #autosave# files
(setq auto-save-default nil) 

;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Lines should be 80 characters wide
(setq fill-column 80)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)

;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; Make ibuffer default
(defalias 'list-buffers 'ibuffer)

;; ido-mode settings
(setq ido-enable-flex-matching t)
(ido-mode 1)

;; display items vertically
(setq ido-separator "\n")

;; use current pane for newly opened file
(setq ido-default-file-method 'selected-window)

;; use current pane for newly switched buffer
(setq ido-default-buffer-method 'selected-window)

(provide 'defaults)
