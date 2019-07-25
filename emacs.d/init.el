;; Set path to dependencies
(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path settings-dir)

;; #############################################
;; PACKAGES
;; #############################################

;; Melpa
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package
(eval-when-compile
  (require 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Automatically update packages
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; GUI theme
(use-package dracula-theme)

;; For project interaction
(use-package projectile
  :bind-keymap
  ("M-p" . projectile-command-map)
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/projects/")))

;; NerdTREE like project tree GUI
(use-package neotree
  :bind
  ("M-[" . neotree-toggle)
  :config
  ;; To change neotree to project root when switching projects with
  ;; projectile
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (setq neo-show-hidden-files t)
  ;; Every time when neotree window is opened, let it find the current
  ;; file and jump to the node.
  (setq neo-smart-open t))

;; Window and Frame switcher
(use-package ace-window
  :bind
  ("M-o" . ace-window)
  :config
  (setq aw-dispatch-always t))

;; For jumping around text
(use-package ace-jump-mode
  :bind
  ("M-;" . ace-jump-mode))

;; Frame Management
(use-package elscreen
  :config
  (setq elscreen-prefix-key "\M-z")
  (elscreen-start)
  (global-set-key (kbd "s-{") 'elscreen-previous)
  (global-set-key (kbd "s-}") 'elscreen-next))

;; Defaults
(require 'defaults)

;; Key bindings
(require 'key-bindings)

;; Custom appearance settings
(require 'appearance)

;; #############################################
;; Auto-set configurations
;; #############################################

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-linum-mode t)
 '(package-selected-packages
   (quote
    (nord-theme elscreen escreen ace-jump-mode ace-window appearance auto-package-update neotree dracula-theme projectile use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
