;;; appearance --- Settings that change the appearance of Emacs
;;; Commentary:
;;;   All appearance related settings are applied here.

;;; Code:

;; GUI theme
;; (use-package dracula-theme)

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  (load-theme 'doom-one t))

;; Set font-size
(set-face-attribute 'default nil :height 110)

;; Org-mode font settings
(require 'org)

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

;;; Required by doom-modeline
;;; When installing for the first time, run
;;; M-x all-the-icons-install-fonts
(use-package all-the-icons)

;;; Fancy modeline
(defun enable-doom-modeline-icons (_frame)
  (defvar doom-modeline-icon t))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-vcs-max-length 50)
  (set-face-attribute 'mode-line nil :height 110)
  (set-face-attribute 'mode-line-inactive nil :height 110)
  (add-hook 'after-make-frame-functions #'enable-doom-modeline-icons))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'appearance)
;;; appearance.el ends here
