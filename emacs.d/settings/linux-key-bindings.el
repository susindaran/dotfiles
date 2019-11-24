;; Linux specific key-bindings

;; Switch windows
(global-set-key (kbd "s-'") 'next-multiframe-window)

;; Select entire buffer
(global-set-key (kbd "s-a") 'mark-whole-buffer)

;; Copy marked region
(global-set-key (kbd "s-c") 'kill-ring-save)

;; Paste killed/copied text
(global-set-key (kbd "s-v") 'yank)

;; Save buffer
(global-set-key (kbd "s-s") 'save-buffer)

;; Kill current buffer
(global-set-key (kbd "s-k") 'kill-current-buffer)
