;;; go-settings --- settings for Golang development
;;;
;;; Commentary:
;;; This package assumed that the following packages are installed:
;;;   - lsp
;;;
;;; So this package should be included after installing the above required
;;; packages.

;;; Code:

(require 'lsp)

;; Use LSP for go-mode
(add-hook 'go-mode-hook #'lsp-deferred)

(defun lsp-go-install-save-hooks ()
  "Set up before-save hooks to format buffer and add/delete imports."
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package go-mode
  :init
  (setenv "GOPATH" "/Users/susindaran/go")
  :config
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))

(provide 'go-settings)
;;; go-settings.el ends here
