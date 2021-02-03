;;; init -- main package
;;;
;;; Commentary:
;;;  Most of the main packages will be installed here. Other specific packages
;;;  will be in separate files under settings/ directory.
;;;
;;; Code:

;; Start Emacs window maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

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

(use-package helm-swoop)

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
  (dolist (item '("~/org/")) (add-to-list 'projectile-known-projects item)))

;; Required by the `treemacs' package, but for some reason is not being auto-installed.
(use-package cfrs)

;; File explorer
(use-package treemacs
  :after cfrs
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode t)
  :bind
  (:map global-map
        ("M-[" . treemacs)
        ("M-s-[" . treemacs-select-window)))

(use-package treemacs-projectile
  :after treemacs helm-projectile)

(use-package treemacs-icons-dired
  :after treemacs dired
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit)

;; Frame/Window management
(use-package centaur-tabs
  :config
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-bar 'over)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-modified-marker "*")
  (setq centaur-tabs-icons t)
  (setq centaur-tabs-cycle-scope 'tabs)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  (centaur-tabs-mode)
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
  ("s-K" . centaur-tabs-kill-other-buffers-in-current-group))

;; Let's not forget ag
(use-package helm-ag
  :config
  ;; Enable fuzzy matching
  (setq helm-ag-fuzzy-match t)
  ;; Use .agignore file at project root
  (setq helm-ag-use-agignore t)
  :after (helm)
  :requires helm)

(use-package helm-rg
  :after (helm)
  :requires (helm))

;; LSP
(use-package lsp-mode
  :commands (lsp lsp-deferred lsp-register-client)
  :config
  (setq lsp-log-io t)
  (setq lsp-enable-snippet nil)
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))
  (defvar lsp-completion-provider :capf))

(use-package lsp-ui
  :commands lsp-ui-mode
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu)
              ("M-i" . lsp-ui-doc-glance))
  :custom
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-enable nil))

(use-package lsp-treemacs
  :after treemacs lsp
  :config
  (treemacs-fringe-indicator-mode t))

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
  :config
  (setq company-idle-delay 0.7)
  (setq company-minimum-prefix-length 1)
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  :hook
  (after-init . global-company-mode))

(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip
    :ensure t))

(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

;; Folding
(use-package yafolding
  :config
  (add-hook 'prog-mode-hook (lambda () (yafolding-mode))))

;; Snippets
(use-package yasnippet
  :config (yas-global-mode))

;; Collection of good snippets
(use-package yasnippet-snippets)

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode))

(use-package multiple-cursors)

;; Change horizontal split to vertical and vice-versa.
(use-package transpose-frame)

;; Scala
(use-package scala-mode
  :interpreter
    ("scala" . scala-mode))

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

;; Golang settings
(use-package go-settings
  :load-path "settings/go-settings.el")

;; Java settings
(use-package java-settings
  :load-path "settings/java-settings.el")

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
 '(exec-path-from-shell-check-startup-files nil t)
 '(exec-path-from-shell-variables (quote ("PATH" "MANPATH" "GOPATH" "GOROOT")))
 '(global-flycheck-mode t)
 '(global-linum-mode t)
 '(lsp-ui-doc-enable nil)
 '(lsp-ui-doc-header t)
 '(lsp-ui-doc-include-signature t)
 '(markdown-hide-urls t)
 '(package-selected-packages
   (quote
    (helm-swoop treemacs-all-the-icons cfrs scala-mode treemacs-icons-dired treemacs-magit treemacs-projectile yasnippet-snippets meghanada yasnippet helm-rg transpose-frame esup company-quickhelp multiple-cursors rhtml-mode rainbow-delimiters doom-themes all-the-icons doom-modeline tide use-package-ensure-system-package rjsx-mode js2-mode puppet-mode helm-ag helm-projectile helm lsp centaur-tabs go-mode org-bullets ws-butler lsp-mode lsp-ui dumb-jump company-flow flycheck-flow flycheck company yaml-mode markdown-mode json-mode magit terraform-mode helm-config nord-theme elscreen escreen ace-jump-mode ace-window appearance auto-package-update neotree dracula-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
