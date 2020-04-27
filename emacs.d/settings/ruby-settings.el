(defun my-ruby-mode-hook ()
    (set-fill-column 80)
    (add-hook 'before-save-hook 'delete-trailing-whitespace nil 'local)
    (defvar ruby-insert-encoding-magic-comment nil))

(use-package ruby-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
  :hook
  (ruby-mode . eldoc-mode)
  (ruby-mode . my-ruby-mode-hook))

;; Auto close paired syntax elements
(use-package ruby-electric
  :hook
  (ruby-mode . ruby-electric-mode))

;; Ruby repl within emacs
(use-package inf-ruby
  :config
  (autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
  :hook
  (ruby-mode . inf-ruby-minor-mode))

;; Enable web-mode for .erb files
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(defvar web-mode-engines-alist
      '(("erb"    . "\\.erb\\'"))
)

(provide 'ruby-settings)
