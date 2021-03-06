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
;(keyboard-translate ?\C-h ?\C-?)
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; other window
(global-set-key (kbd "C-x o") 'other-window)

;; bs-show
(global-set-key "\C-x\C-b" 'bs-show)

;; undefine C-z
;(global-unset-key (kbd "C-z"))

;; 5 step key move
(global-set-key (kbd "M-n") (kbd "C-u 5 C-n"))
(global-set-key (kbd "M-p") (kbd "C-u 5 C-p"))

;; my key map
(defvar my-keymap (make-sparse-keymap) "my original key map")
(define-key global-map (kbd "C-o") my-keymap)

;; yes/no -> y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; compile
(defvar current-command "make check")
(defun compile-1 (cmd)
  (interactive (list (read-string "Command: " current-command)))
  (setq current-command cmd)
  (compile current-command t)
  (delete-other-windows))

;(if window-system
    (define-key my-keymap (kbd "C-c") 'compile)
;  (define-key my-keymap (kbd "C-c") 'compile-1))

;; C-x SPC => Rectangle mark
(cua-mode t)
(setq cua-enable-cua-keys nil)
(define-key cua-global-keymap [C-return] nil)
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

;; text scale
(define-key global-map (kbd "M-+") 'text-scale-increase)
(define-key global-map (kbd "M-=") 'text-scale-increase)
(define-key global-map (kbd "M--") 'text-scale-decrease)

;; automatically revert buffers
(global-auto-revert-mode t)

;;;; package manager
;(require 'package)
;(add-to-list 'package-archives
;	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(add-to-list 'package-archives
;	     '("marmalade" . "http://marmalade-repo.org/packages/"))
;(package-initialize)

;(define-key global-map (kbd "C-3") '(lambda (interactive) (digit-argument 3)))
;;;; Basic config

;; truncate-lines
(setq truncate-lines t)

;; exec path
(setq exec-path (cons (expand-file-name "~/bin") exec-path))
(setq exec-path (cons (expand-file-name "~/local/bin") exec-path))

;; unbind C-c C-x and define exit command
(if window-system
    (progn 
      (global-unset-key (kbd "C-x C-c"))
      (global-set-key (kbd "C-x C-c") 'server-edit)))
(defalias 'exit 'save-buffers-kill-emacs)


;; ffap. Extention of C-x C-f
(ffap-bindings)

;; hilight kakko
(show-paren-mode t)

;; no menu bar
(menu-bar-mode -1)

;; no tool bar
(tool-bar-mode -1)

;; linum and scroll mode
;(if window-system
;    (scroll-bar-mode t))
(global-linum-mode t)
(defun toggle-scroll-bar-and-linum ()
  (interactive)
  ;; scroll bar mode
  (if window-system
      (toggle-scroll-bar (if linum-mode 0 1)))
  (global-linum-mode (if linum-mode -1 1)))
(define-key my-keymap (kbd "C-l") 'toggle-scroll-bar-and-linum)

;; no scroll bar
(toggle-scroll-bar 0)

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

; avoid error message "Text read-only"
; see http://qiita.com/acple@github/items/c195d7c64e30c28577fa
(defadvice eshell-get-old-input (after eshell-read-only-korosu activate)
  (setq ad-return-value (substring-no-properties ad-return-value)))

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
;(require 'tramp)
;(setq tramp-default-method "scp")
;(setenv "TMPDIR" "/tmp")
;/ssh:matsuzak@kokiib0.chem.keio.ac.jp:~/src/project/rescol/calc/h2_r14/run.py

;;;  Window      
;;;;  Win-control   
;;;;; * load
;; depend on windmove.el
;; depend on hiwin.el
; win manage
(load (concat config-home "win-controll/win-controll.el"))
					;(load "~/.emacs.d/elisp/win-controll/win-controll.el")

;;; window move rapidly

(if window-system
    (progn ()
	   (global-unset-key (kbd "M-k"))
	   (defvar move-global-minor-mode-map
	     (let ((map (make-sparse-keymap)))
	       (setq windmove-wrap-around t)
	       (define-key map (kbd "M-j") 'other-window)
	       (define-key map (kbd "M-k") (lambda () (interactive) (other-window -1)))
	       map))
	   
	   (define-minor-mode move-global-minor-mode
	     "move minor mode"
	     :global t)

	   (move-global-minor-mode t)))

;; C-x o bind to frame move
(define-key global-map (kbd "C-x o") 'other-frame)


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


;;;  Edit        
;;;;  auto insert

(auto-insert-mode)
(setq auto-insert-directory (expand-file-name (concat config-home "insert")))


;;;;  hideshow   

;(add-hook 'hs-minor-mode-hook
;	  '(lambda ()
;	     (define-key hs-minor-mode-map (kbd "C-c f") 'hs-toggle-hiding)
;	     (define-key hs-minor-mode-map (kbd "C-c w") 'hs-hide-all)
;	     (define-key hs-minor-mode-map (kbd "C-c l") 'hs-hide-level)
;	     (define-key hs-minor-mode-map (kbd "C-c a") 'hs-show-all)))



;;;; Eshell
(setq eshell-command-aliases-list
      (append
       (list
	(list "f" "find-file $1")
	(list "o" "find-file-other-window $1")
	(list "grep" "/usr/bin/grep $1 $2"))))


;;;; hl line 
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "color-234"))
    (((class color)
      (background light))
      (:background "#CC0066"))
      (t
       ()))
    "face used in hl-line")
;(setq hl-line-face 'hlline-face)
;(global-hl-line-mode t)


;;;; safe ctrl+w

(defun safe-kill-region ()
  (interactive)
  (if (or (not transient-mark-mode) (region-active-p))
      (kill-region (region-beginning) (region-end))))
(global-set-key "\C-w" 'safe-kill-region)


