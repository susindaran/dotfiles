;; JS and JSX major editing mode - syntax highlighting and imenu
(use-package rjsx-mode
  :config
  (add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode)))

;; TIDE - completion (company), eldoc, definitions, references
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (defvar flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(use-package tide
  :hook
  ((before-save . tide-format-before-save)
   (js-mode . setup-tide-mode)
   (typescript-mode . setup-tide-mode))
  :ensure-system-package
  (standardx . "sudo npm install -g standardx")
  :config
  (defvar company-tooltip-align-annotations t))

(use-package prettier-js
  :config
  (setq prettier-js-args '(
  "--trailing-comma" "none"
  "--bracket-spacing" "true"
  "--single-quote" "true"
  "--no-semi" "true"
  "--jsx-single-quote" "true"
  "--jsx-bracket-same-line" "true"
  "--print-width" "100"))
  :hook
  (js-mode . prettier-js-mode)
  :ensure-system-package
  (prettier . "sudo npm install -g prettier"))

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode)))

(provide 'js-settings)
