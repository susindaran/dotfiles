;;; key-bindings --- key-bindings definitions
;;; Commentary:
;;;   This package defines key-bindings for some of the functions from
;;;   installed packages. This package also defines some functions and sets up
;;;   key-bindings for them.

;;; Code:

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

;; Search current directory using ripgrep
(global-set-key (kbd "s-f") 'helm-swoop)

;; Search in project root using ripgrep
(global-set-key (kbd "s-F") 'helm-projectile-rg)

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
  "Deletes ARG words.
Each word is deleted by deleting characters forward until encoutering the end of
a word. This command does not push text to 'kill-ring'"
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

(defun delete-word-backward (arg)
  "Deletes ARG words.
Each word is deleted by deleting characters backward until encountering the
beginning of a word. This command does not push text to 'kill-ring'"
  (interactive "p")
  (delete-word (- arg)))

(defun delete-line ()
  "Delete text from current position to end of line character.
This command does not push text to 'kill-ring'"
  (interactive)
  (delete-region
   (point)
   (progn (end-of-line 1) (point)))
  (delete-char 1))

(defun delete-line-backward ()
  "Delete text between the beginning of the line to the current poisition.
This command does not push text to 'kill-ring'"
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

(defun minify-buffer()
  "Minifies the buffer contents by removing whitespaces and newlines."
  (interactive)
  (delete-whitespace-rectangle (point-min) (point-max))
  (mark-whole-buffer)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "" nil t)))

;; #############################################
;; Modify font-size functions key-bindings
;; #############################################

(defun set-font-size (font size)
  "Set the `FONT' size to `SIZE'."
  (set-face-attribute font nil :height size))

(defun increase-font-size ()
  "Increase the font size by 10 points."
  (interactive)
  (let ((new-size (+ (face-attribute 'default :height) 10)))
    (set-font-size 'default new-size)))

(defun decrease-font-size ()
  "Decrease the font size by 10 points."
  (interactive)
  (let ((new-size (- (face-attribute 'default :height) 10)))
    (set-font-size 'default new-size)))

(bind-keys*
 ("s-+" . increase-font-size)
 ("s-_" . decrease-font-size))

;; #############################################
;; Other key-bindings
;; #############################################

;; Find file using fzf
(global-set-key (kbd "s-O") 'helm-fzf-project-root)

;; Open imenu (helps see the structure of the file)
(global-set-key (kbd "s-i") 'imenu)

;; Toggle comment in the region
(global-set-key (kbd "s-/") 'comment-or-uncomment-region)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(provide 'key-bindings)
;;; key-bindings.el ends here
