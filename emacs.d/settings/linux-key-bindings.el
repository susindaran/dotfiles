;;; linux-key-bindings --- Linux specific key-bindings definitions
;;; Commentary:
;;;   This package defines key-bindings that are to be specifically set for the
;;;   Linux platform.

;;; Code:

;; Switch windows
(global-set-key (kbd "s-'") 'next-multiframe-window)

;; Select entire buffer
(global-set-key (kbd "s-a") 'mark-whole-buffer)

;; Copy marked region
(global-set-key (kbd "s-c") 'kill-ring-save)

;; Cut marked region
(global-set-key (kbd "s-x") 'kill-region)

;; Paste killed/copied text
(global-set-key (kbd "s-v") 'yank)

;; Save buffer
(global-set-key (kbd "s-s") 'save-buffer)

;; Kill current buffer
(global-set-key (kbd "s-k") 'kill-current-buffer)

(provide 'linux-key-bindings)
;;; linux-key-bindings.el ends here
