;;; package -- Summary
;;; Commentary:
;
;  Minimal setting for Emacs. 
;
;
;;; Code:
;;;  Basic       
;;;; Basic Key

;; Binding C-h to backspace
(keyboard-translate ?\C-h ?\C-?)

;; bs-show
(global-set-key "\C-x\C-b" 'bs-show)

;; undefine C-z
(global-unset-key (kbd "C-z"))

;; 5 step key move
(global-set-key (kbd "M-n") (kbd "C-u 5 C-n"))
(global-set-key (kbd "M-p") (kbd "C-u 5 C-p"))

;; compile
(global-set-key (kbd "C-c c") 'compile)

;; C-x SPC => Rectangle mark
(cua-mode t)
(setq cua-enable-cua-keys nil)
(define-key cua-global-keymap [C-return] nil)
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

;;;; package manager

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;;;; Basic config

;; truncate-lines
(setq truncate-lines t)

;; exec path
(setq exec-path (cons (expand-file-name "~/bin") exec-path))
(setq exec-path (cons (expand-file-name "~/local/bin") exec-path))

;; unbind C-c C-x and define exit command
(global-unset-key (kbd "C-x C-c"))
(defalias 'exit 'save-buffers-kill-emacs)

;; bind C-c C-x as server edit
(global-set-key (kbd "C-x C-c") 'server-edit)

;; ffap. Extention of C-x C-f
(ffap-bindings)

;; iswichb. Extention of C-x b
;(iswitchb-mode 1)

;; hilight kakko
(show-paren-mode t)

;; no menu bar
(menu-bar-mode -1)

;; no tool bar
(tool-bar-mode -1)

;; non scroll bar
(if window-system
    (scroll-bar-mode 0))

;; scroll
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

;; no backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq delete-auto-save-files t)




;;;; uniquify

;; simplify same name buffer
(when (require 'uniquify)
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-ignore-buffers-re "*[^*]+*"))

;;;; hippie

(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))
(global-set-key (kbd "M-/") 'hippie-expand)

;;;; eshell
;;;;; prompt

(defmacro with-face (str &rest props)
  `(propertize ,str 'face (list ,@props)))

(defun git-prompt ()
  (shell-command-to-string 
   (concat "bash " config-home "/run-git-prompt.sh")))

; (defun pwd-from-home ()
;   "if current directory is /home/rei/local/src,
; return ~/local/src."

;;;;; hook

(add-hook 'eshell-mode-hook
	  '(lambda ()
	     (progn
	       (let ((dir (expand-file-name "~/bin")))
		 (setenv "PATH"  (concat dir ":" (getenv "PATH")))
		 (setq exec-path (append (list dir) exec-path)))
;	       (define-key eshell-mode-map (kbd "C-M-l") 'windmove-right)
	       (define-key eshell-mode-map "\C-j" 'eshell-send-input)
	       (define-key eshell-mode-map "\C-a" 'eshell-bol)
	       (define-key eshell-mode-map "\C-p" 'eshell-previous-matching-input-from-input)
	       (define-key eshell-mode-map "\C-n" 'eshell-next-matching-input-from-input)
	       )))

(global-set-key (kbd "C-c t") 'eshell)

;;;; describe-face-at-point

(defun describe-face-at-point ()
  "Return face used at point"
  (interactive)
  (message "%s" (get-char-property (point) 'face)))


;;;; tramp

(require 'tramp)
(setq tramp-default-method "scp")
(setenv "TMPDIR" "/tmp")
;/ssh:matsuzak@kokiib0.chem.keio.ac.jp:~/src/project/rescol/calc/h2_r14/run.py

;;;  Window      
;;;;  Win-control   
;;;;; * load
;; depend on windmove.el
;; depend on hiwin.el
; win manage
(load (concat config-home "win-controll/win-controll.el"))
;(load "~/.emacs.d/elisp/win-controll/win-controll.el")

(require 'windmove)

;;;;; * def (flip)


(defun buffer-flip-chose-direction (direction)
  (flet ((buffer-flip (win1 win2)
		      (let ((b1 (window-buffer win1))
			    (b2 (window-buffer win2)))
			(set-window-buffer win1 b2)
			(set-window-buffer win2 b1)
			(select-window win2))))
    (buffer-flip (selected-window) 
		 (windmove-find-other-window direction))))

(defun buffer-flip-up ()
  (interactive)
  (buffer-flip-chose-direction 'up))
(defun buffer-flip-down ()
  (interactive)
  (buffer-flip-chose-direction 'down))
(defun buffer-flip-right ()
  (interactive)
  (buffer-flip-chose-direction 'right))
(defun buffer-flip-left ()
  (interactive)
  (buffer-flip-chose-direction 'left))



;; simple test:
; (buffer-flip-chose-direction 'right)

;;;;; * def (UI), not used

(defun buffer-control-ui ()
  (interactive)
  (message "move:hjkl, bring:HJKL")
  (let ((cmd (read-char))
	(cmd-direction-alist 
	 '((?L . right) (?H . left) (?J . down) (?K . up)))
	(cmd-move-alist
	 '((?l . right) (?h . left) (?j . down) (?k . up)))
	dir)
    (setq dir (cdr (assoc cmd cmd-direction-alist)))
    (when dir
      (buffer-flip-chose-direction dir))
    (setq dir (cdr (assoc cmd cmd-move-alist)))
    (when dir
      (windmove-do-window-select dir))
    (when (equal cmd ?3)
      (wincon-construct
       'wincon-set-windows-three-holizon
       `((file ,(lambda () (wincon-get-l-in-current-frame 'buffer-file-name)))
	 (shell wincon-get-l-eshell-for-current-screen))))
    (when (equal cmd ?4)
      (wincon-construct
       'wincon-set-windows-2121
       `((file ,(lambda () (wincon-get-l-in-current-frame 'buffer-file-name)))
	 (shell wincon-get-l-eshell-for-current-screen))))
    (when (not (equal cmd ?g))
      (buffer-control-ui))))


;;;;  Window split  
;;;;; def (other-window-or-split)

(defun other-window-or-split (num)
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window num))

;;;;; def (split-window-vertically-n)

(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))

;;;;; def (split-window-horizontally-n)

(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))

;;;;; Key-Binding


;; this code does not work.
;; to activate these key bindings, copy above code to end of init.el.
(global-set-key (kbd "C-x #") '(lambda ()
                           (interactive)				 
                           (split-window-horizontally-n 3)))
(global-set-key (kbd "C-x $") '(lambda ()
				 (interactive)
				 (split-window-horizontally-n 4)))


;;;;  Kept and open 
;;;;; def

(defvar opening-buffer nil)
(defun find-file-and-kept-opening-buffer (file-name)
  "find file and kept it for opening-buffer"
  (interactive)
  (setq opening-buffer (find-file-noselect (expand-file-name file-name))))

(defun save-opening-buffer ()
  "change buffer and kept it for opening-buffer"
  (interactive)
  (setq opening-buffer (current-buffer)))


(defun switch-to-opening-buffer ()
  "open opening-buffer at current window"
  (interactive)
  (if opening-buffer
      (progn
	(switch-to-buffer opening-buffer)
	(setq opening-buffer nil))
  (message "there is no opening-buufer")))

;;;  Edit        
;;;;  auto insert

(auto-insert-mode)
(setq auto-insert-directory (expand-file-name (concat config-home "insert")))


;;;;  hideshow   

(add-hook 'hs-minor-mode-hook
	  '(lambda ()
	     (define-key hs-minor-mode-map (kbd "C-c f") 'hs-toggle-hiding)
	     (define-key hs-minor-mode-map (kbd "C-c w") 'hs-hide-all)
	     (define-key hs-minor-mode-map (kbd "C-c l") 'hs-hide-level)
	     (define-key hs-minor-mode-map (kbd "C-c a") 'hs-show-all)))



