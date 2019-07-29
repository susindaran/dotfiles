;; #############################################
;; Helm key-bindings
;; #############################################
(global-set-key (kbd "C-c h") 'helm-command-prefix)

;; C-x c is so close to C-x C-c (close)
(global-unset-key (kbd "C-x c"))

;; Use helm for execute command completion
(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

;; Rebind tab to run persistent action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

;; List actions
(define-key helm-map (kbd "C-z")  'helm-select-action)

;; Show the kill-ring beautifully
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-x b") 'helm-mini)

;; helm-projectile bindings
;; Switch project
(global-set-key (kbd "M-p") 'helm-projectile-switch-project)

;; Find file in project
(global-set-key (kbd "s-O") 'helm-projectile-find-file)

;; Search this file using ag
(global-set-key (kbd "s-f") 'helm-do-ag-this-file)

;; Search in project root using ag
(global-set-key (kbd "s-F") 'helm-do-ag-project-root)

;; #############################################
;; Org key-bindings
;; #############################################

;; Switch to org file
(global-set-key (kbd "C-c b") 'org-iswitchb)

;; Org store link
(global-set-key (kbd "C-c l") 'org-store-link)

;; Show org agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;; Org capture tasks
(global-set-key (kbd "C-c c") 'org-capture)

(provide 'key-bindings)
