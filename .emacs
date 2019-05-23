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

;; Automatically update packages
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; GUI theme
(use-package dracula-theme)

;; For project interaction
(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (projectile-mode +1))

;; NerdTREE like project tree GUI
(use-package neotree
  :ensure t
  :config
  (global-set-key [f8] 'neotree-toggle))

;; #############################################
;; ### General Configurations
;; #############################################


(global-linum-mode 1)

(setq ido-enable-flex-matching t)
(ido-mode 1)

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
    (auto-package-update neotree dracula-theme projectile use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
