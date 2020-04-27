;; Set path to dependencies
(defvar settings-dir
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
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package use-package-ensure-system-package
  :ensure t)

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
                                    "GOPATH"
				    "GOROOT"))
  :config
  (exec-path-from-shell-initialize))

;; GUI theme
;; (use-package dracula-theme)

(use-package doom-themes
  :ensure t
  :init
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  (load-theme 'doom-one t))

;; Deletes trailing whitespace from edited lines
(use-package ws-butler
  :config
  (setq ws-butler-keep-whitespace-before-point nil)
  (ws-butler-global-mode 1))

;; Move to the first non-whitespace character on the line
(use-package crux
  :bind
  ("C-a" . crux-move-beginning-of-line))

;; Git interface
(use-package magit
  :init
  (setq magit-repository-directories
	'(("~/projects/" . 2)))
  :bind
  ("C-x g" . magit-status)
  ("C-x M-b" . magit-blame))

;; NerdTREE like project tree GUI
(use-package neotree
  :bind
  ("M-[" . neotree-toggle)
  :config
  ;; To change neotree to project root when switching projects with
  ;; projectile
  (defvar projectile-switch-project-action 'neotree-projectile-action)
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

;; Helm to the resuce
(use-package helm
  :config
  (require 'helm-config)
  (setq
   helm-split-window-inside-p      t ; open helm buffer inside current window, not occupy whole other window
   helm-scroll-amount              8 ; scroll 8 lines other window using M-<next>/M-<prior>
   helm-echo-input-in-header-line  t
   helm-autoresize-max-height     20
   helm-autoresize-min-height      0)
  ;; search for library in `require' and `declare-function' sexp.
  (setq helm-ff-search-library-in-sexp        t)
  (setq helm-ff-file-name-history-use-recentf t)
  (setq helm-M-x-fuzzy-match                  t)
  (setq helm-buffers-fuzzy-matching           t)
  (setq helm-recentf-fuzzy-match              t)
  (helm-autoresize-mode 1)
  (helm-mode 1))

;; Make projectile even better
(use-package helm-projectile
  :config
  (projectile-mode)
  (setq projectile-completion-system 'helm)
  (setq projectile-enable-caching t)
  (setq projectile-switch-project-action 'helm-projectile)
  (helm-projectile-on)
  (when (require 'magit nil t)
    (mapc #'projectile-add-known-project
          (mapcar #'file-name-as-directory (magit-list-repos)))
    (projectile-save-known-projects))
  (dolist (item '("~/org/")) (add-to-list 'projectile-known-projects item))
  :requires helm)

;; Frame/Window management
(use-package centaur-tabs
  :init
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-bar 'over)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-modified-marker "*")
  (setq centaur-tabs-icons t)
  (setq centaur-tabs-cycle-scope 'tabs)
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  :bind
  ;; Switch tabs
  ("s-{" . centaur-tabs-backward)
  ("s-}" . centaur-tabs-forward)
  ;; Switch tab groups (grouped by projectile projects)
  ("s-[" . centaur-tabs-backward-group)
  ("s-]" . centaur-tabs-forward-group)
  ;; Move tab positions
  ("C-{" . centaur-tabs-move-current-tab-to-left)
  ("C-}" . centaur-tabs-move-current-tab-to-right)
  ;; Kill other tabs in current group
  ("s-K" . centaur-tabs-kill-other-buffers-in-current-group)
  :after (helm-projectile)
  :requires helm-projectile)

;; Let's not forget ag
(use-package helm-ag
  :config
  ;; Enable fuzzy matching
  (setq helm-ag-fuzzy-match t)
  ;; Use .agignore file at project root
  (setq helm-ag-use-agignore t)
  :after (helm)
  :requires helm)

;; golang
(use-package go-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

;; Terraform
(use-package terraform-mode)

;; JSON
(use-package json-mode)

;; Markdown
(use-package markdown-mode
  :custom
  (markdown-hide-urls t))

;; YAML
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

(use-package puppet-mode)

;; Pretty org-mode
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Auto-completion framework
(use-package company
  :hook
  (after-init . global-company-mode))

;; Auto-completion for go
(use-package company-go
  :config
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends) '(company-go))
			    (company-mode))))

(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

;; Jump to definition (dumb but effective)
(use-package dumb-jump
  :config
  (progn
    (define-prefix-command 'dj-prefix)
    (define-key dj-prefix (kbd "j") 'dumb-jump-go)
    (define-key dj-prefix (kbd "o") 'dumb-jump-go-other-window)
    (define-key dj-prefix (kbd "q") 'dumb-jump-quick-look)
    (define-key dj-prefix (kbd "b") 'dumb-jump-back))
  (global-set-key (kbd "M-j") 'dj-prefix)
  (setq dumb-jump-selector 'helm)
  (setq dumb-jump-force-searcher 'rg))

;; Folding
(use-package yafolding
  :config
  (add-hook 'prog-mode-hook (lambda () (yafolding-mode))))

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode))

;; Defaults
(use-package default-settings
  :load-path "settings/default-settings.el")

;; Key bindings
(use-package key-bindings
  :load-path "settings/key-bindings.el")

;; Load linux specific key-bindings
(cond ((eq system-type 'gnu/linux) (load-file (expand-file-name "settings/linux-key-bindings.el" user-emacs-directory))))

;; Custom appearance settings
(use-package appearance
  :load-path "settings/appearance.el")

;; Javascript settings
(use-package js-settings
  :load-path "settings/js-settings.el")

;; Ruby settings
(use-package ruby-settings
  :load-path "settings/ruby-settings.el")

;; For finding files using fzf
(use-package helm-fzf
  :load-path "settings/helm-fzf.el")

;; #############################################
;; Auto-set configurations
;; #############################################

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(centaur-tabs-mode t nil (centaur-tabs))
 '(global-flycheck-mode t)
 '(global-linum-mode t)
 '(markdown-hide-urls t)
 '(package-selected-packages
   (quote
    (rhtml-mode rainbow-delimiters doom-themes all-the-icons doom-modeline prettier-js tide use-package-ensure-system-package rjsx-mode js2-mode puppet-mode helm-ag helm-projectile helm lsp centaur-tabs company-go go-mode org-bullets ws-butler lsp-mode company-lsp lsp-ui dumb-jump company-flow flycheck-flow flycheck company yaml-mode markdown-mode json-mode magit terraform-mode helm-config nord-theme elscreen escreen ace-jump-mode ace-window appearance auto-package-update neotree dracula-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
