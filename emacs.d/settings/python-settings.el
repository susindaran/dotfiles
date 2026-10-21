;;; python-settings.el --- Python development settings -*- lexical-binding: t; -*-

;;; Commentary:
;; Install the servers with:
;;   uv tool install basedpyright
;;   uv tool install ruff
;; Both basedpyright-langserver and ruff must be on Emacs's exec-path.

;;; Code:

(defcustom python-settings-enable-ruff t
  "Whether to enable Ruff linting and formatting alongside Basedpyright."
  :type 'boolean
  :group 'python)

(use-package lsp-pyright
  :ensure t
  :defer t
  :init
  (setq lsp-pyright-langserver-command "basedpyright"
        lsp-pyright-disable-organize-imports python-settings-enable-ruff
        ;; Let Ruff report unused imports when it is enabled.
        lsp-pyright-diagnostic-severity-overrides
        (when python-settings-enable-ruff
          '(("reportUnusedImport" . "none")))))

(defun python-settings-start-lsp ()
  "Start Basedpyright and, when enabled, Ruff for this Python buffer."
  (require 'lsp-pyright)
  (when python-settings-enable-ruff
    (require 'lsp-ruff))
  ;; Ruff is an add-on server alongside the primary Pyright client.
  (setq-local lsp-enabled-clients
              (if python-settings-enable-ruff '(pyright ruff) '(pyright)))
  (setq-local lsp-diagnostics-provider :flycheck)
  ;; Basedpyright supplies navigation and completion; Ruff supplies formatting.
  (setq-local lsp-format-buffer-on-save python-settings-enable-ruff)
  (lsp-deferred))

(add-hook 'python-mode-hook #'python-settings-start-lsp)
(add-hook 'python-ts-mode-hook #'python-settings-start-lsp)

(provide 'python-settings)
;;; python-settings.el ends here
