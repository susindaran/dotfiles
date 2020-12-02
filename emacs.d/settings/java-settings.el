;;; java-settings --- settings for Java development
;;;
;;; Commentary:
;;;   settings for Java development
;;;
;;; Code:

(use-package meghanada
  :config (add-hook 'java-mode-hook
          (lambda ()
            ;; meghanada-mode on
            (meghanada-mode t)
            (flycheck-mode +1)
            (setq c-basic-offset 2)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save))))

(provide 'java-settings)
;;; java-settings.el ends here
