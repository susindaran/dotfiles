;;; go-settings --- settings for Golang development
;;;
;;; Commentary:
;;;  settings for Golang development
;;;
;;; Code:

;; Use LSP for go-mode
(add-hook 'go-mode-hook #'lsp-deferred)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
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
