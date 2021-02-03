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
            (defvar c-basic-offset 2)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
  :bind
  (:map java-mode-map
        ("M-." . meghanada-jump-declaration)
        ("M-," . meghanada-reference)))

(provide 'java-settings)
;;; java-settings.el ends here
