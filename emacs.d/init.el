;; Set path to dependencies
(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path settings-dir)

;; Set up exec-path
(add-to-list 'exec-path "/usr/local/bin/")


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

;; Use same paths as user environment on macOS
(use-package exec-path-from-shell
  :if (eq system-type 'darwin)
  :custom
  (exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-variables '("PATH"
                                    "MANPATH"
                                    "GOPATH"))
  :config
  (exec-path-from-shell-initialize))

;; GUI theme
(use-package dracula-theme)

;; Deletes trailing whitespace from edited lines
(use-package ws-butler
  :config
  (setq ws-butler-keep-whitespace-before-point nil)
  (ws-butler-global-mode 1))

;; Move to the first non-whitespace character on the line
(use-package crux
  :bind
  ("C-a" . crux-move-beginning-of-line))

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

;; Helm to the resuce
(use-package helm
  :config
  (require 'helm-config)
  (setq
   helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
   helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
   helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
   helm-ff-file-name-history-use-recentf t
   helm-echo-input-in-header-line        t
   helm-autoresize-max-height           20
   helm-autoresize-min-height            0
   helm-M-x-fuzzy-match                  t
   helm-buffers-fuzzy-matching           t
   helm-recentf-fuzzy-match              t)
  (helm-autoresize-mode 1)
  (helm-mode 1))

;; Make projectile even better
(use-package helm-projectile
  :config
  (add-to-list 'projectile-known-projects "~/org/")
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (setq projectile-enable-caching t)

  (helm-projectile-on)
  :after (helm)
  :requires helm)

;; Let's not forget ag
(use-package helm-ag
  :config
  ;; Enable fuzzy matching
  (setq helm-ag-fuzzy-match t)
  ;; Use .agignore file at project root
  (setq helm-ag-use-agignore t)
  ;; Use ripgrep instead of ag
  (setq helm-ag-base-command "rg-wrapper --vimgrep --no-heading --smart-case")
  :after (helm)
  :requires helm)

;; Ruby
(use-package ruby-mode
  :config
  (defun my-ruby-mode-hook ()
    (set-fill-column 80)
    (add-hook 'before-save-hook 'delete-trailing-whitespace nil 'local)
    (setq ruby-insert-encoding-magic-comment nil))
  (add-hook 'ruby-mode-hook 'my-ruby-mode-hook))

;; Terraform
(use-package terraform-mode)

;; JSON
(use-package json-mode)

;; Markdown
(use-package markdown-mode
  :custom
  (markdown-hide-urls t))

;; YAML
(use-package yaml-mode)

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
    (yaml-mode markdown-mode json-mode magit terraform-mode helm-config nord-theme elscreen escreen ace-jump-mode ace-window appearance auto-package-update neotree dracula-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
