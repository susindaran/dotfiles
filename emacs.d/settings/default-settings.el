;; Using bash shell because zsh for some reason slows down
;; helm-projectile-find-file
(setq shell-file-name "/bin/bash")

;; stop creating backup~ files
(setq make-backup-files nil)

;; stop creating #autosave# files
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)

;; stop creating lockfiles
(setq create-lockfiles nil)

;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; To avoid accidental cmd-q kills
(setq confirm-kill-emacs 'yes-or-no-p)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Lines should be 80 characters wide
(setq fill-column 80)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Show trailing whitespace
(setq-default show-trailing-whitespace t)

;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)

;; Show matching parentheses without any delay
(defvar show-paren-delay 0)

;; Select help window when opened
(setq help-window-select t)

;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; Set column size to 80 characters in org-mode
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;; Uniquify buffer names using a style that matches files paths
(setq uniquify-buffer-name-style 'forward)

;; Quickly close all buffers to reset emacs to a clean state
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(provide 'default-settings)
