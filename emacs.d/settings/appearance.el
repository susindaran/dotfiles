;; Set font-size
(set-face-attribute 'default nil :height 110)

;; Org-mode font settings
(require 'org)
(set-face-attribute 'org-level-1 nil :inherit 'alect-title-1 :foreground "#DFAF8F" :height 150)
(set-face-attribute 'org-todo nil :foreground "OrangeRed2" :weight 'bold)

;; Start emacs window maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; turn on line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; no bell when emacs is unhappy
(setq ring-bell-function 'ignore)

;; Highlight current line
(global-hl-line-mode 1)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

;; no start up message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; no tool bar
(tool-bar-mode 0)

;; no scroll bars
(scroll-bar-mode -1)

(provide 'appearance)
