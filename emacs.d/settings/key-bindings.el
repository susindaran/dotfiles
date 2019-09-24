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
(global-set-key (kbd "M-P") 'helm-projectile-switch-project)

;; Find file
(global-set-key (kbd "M-O") 'projectile-find-file)

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

;; #############################################
;; Text editing key-bindings
;; #############################################

(defun delete-word (arg)
  "Delete characters forward until encoutering the end of a word. With argument,
do this that many times. This command does not push text to kill-ring"
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

(defun delete-word-backward (arg)
  "Delete character backward until encountering the beginning of a word. With
argument, do this that many times. This command does not push text to kill-ring"
  (interactive "p")
  (delete-word (- arg)))

(defun delete-line ()
  "Delete text from current position to end of line character. This command does
not push text to kill-ring"
  (interactive)
  (delete-region
   (point)
   (progn (end-of-line 1) (point)))
  (delete-char 1))

(defun delete-line-backward ()
  "Delete text between the beginning of the line to the current poisition. This
command does not push text to kill-ring"
  (interactive)
  (let (point1 point2)
    (setq point1 (point))
    (beginning-of-line 1)
    (setq point2 (point))
    (delete-region point1 point2)))

;; Using bind-keys* function to set these key-bindings in all modes
;; For instance, C-k is set to org-kill-line in org-mode
(bind-keys*
 ("C-k" . delete-line)
 ("<s-backspace>" . delete-line-backward)
 ("M-d" . delete-word)
 ("<M-backspace>" . delete-word-backward))

;; #############################################
;; Other key-bindings
;; #############################################

;; Find file using fzf
(global-set-key (kbd "s-O") 'helm-fzf-project-root)

;; Open imenu (helps see the structure of the file)
(global-set-key (kbd "s-i") 'imenu)

(provide 'key-bindings)
