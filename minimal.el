;;;  Comment     
;
;  Minimal setting for Emacs. 
;
;
;;;  Basic       
;;;; Basic Key

;; Binding C-h to backspace
(keyboard-translate ?\C-h ?\C-?)

;; bs-show
(global-set-key "\C-x\C-b" 'bs-show)

;; scroll
(global-set-key (kbd "M-n") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)


;;;; move-global-minor-mode


(defvar move-global-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (setq windmove-wrap-around t)
    (define-key map (kbd "M-j") 'windmove-down)
    (define-key map (kbd "M-k") 'windmove-up)
    (define-key map (kbd "M-l") 'windmove-right)
    (define-key map (kbd "M-h") 'windmove-left)
    (define-key map (kbd "M-h") 'windmove-left)
    (define-key map (kbd "M-J") 'buffer-flip-down)
    (define-key map (kbd "M-K") 'buffer-flip-up)
    (define-key map (kbd "M-L") 'buffer-flip-right)
    (define-key map (kbd "M-H") 'buffer-flip-left)
    (define-key map (kbd "M-s") 'save-opening-buffer)
    (define-key map (kbd "M-m") 'switch-to-opening-buffer)
    map))


(define-minor-mode move-global-minor-mode
  "move minor mode"
  :global t)

(move-global-minor-mode t)

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
(iswitchb-mode 1)

;; hilight kakko
(show-paren-mode t)

;; no menu bar
(menu-bar-mode 1)
(menu-bar-mode -1)

;; no tool bar
(tool-bar-mode -1)

;; non scroll bar
(scroll-bar-mode 0)

;; scroll
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

;; no backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq delete-auto-save-files t)

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

;;;; compile
;;;;; autoload

;(autoload 'mode-compile "mode-compile" 
;  "Command to compile current buffer file based on the major mode" t)
;(autoload 'mode-compile-kill "mode-compile" nil t)


;;;;; key

(global-set-key "\C-cc" 'compile)
(global-set-key "\C-ck" 'mode-compile-kill)


;;;;; font-lock for compilation mode

(add-hook 'compilation-mode-hook
	  '(lambda ()
	     (progn
	       (add-to-list 
		'compilation-mode-font-lock-keywords
		'("\\(^\\[.*\\]\\)" (1 font-lock-function-name-face)))
	       (add-to-list 
		'compilation-mode-font-lock-keywords
		'("\\(^\\[ *FAILED *\\]\\)" (1 compilation-error-face))))))





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


;(setq eshell-prompt-function
;      (lambda ()
;	(concat
;	 (user-login-name)
;	 "@" (substring (system-name) 0 6) 
;	 "[" 
;	 (if (string-match "/home/matsuzak" (eshell/pwd))
;	     (concat "~" (substring (eshell/pwd) 14))
;	   (eshell/pwd))
;	 "] ")))


;;;; describe-face-at-point

(defun describe-face-at-point ()
  "Return face used at point"
  (interactive)
  (message "%s" (get-char-property (point) 'face)))


;;;  elscreen    
;;;; keys

(setq elscreen-prefix-key "\C-q")
(define-key move-global-minor-mode-map (kbd "M-]") 'elscreen-next)
(define-key move-global-minor-mode-map (kbd "M-[") 'elscreen-previous)

;;;; start

(elscreen-start)


;;;; tab

(setq elscreen-display-tab 5)
(add-hook 'after-init-hook
	  (lambda()
	    (elscreen-screen-nickname "main")
	    (elscreen-create)
	    (elscreen-screen-nickname "src1")
	    (elscreen-create)
	    (elscreen-screen-nickname "src2")
	    (elscreen-create)
	    (elscreen-screen-nickname "lib1")
	    (elscreen-create)
	    (elscreen-screen-nickname "lib2")
	    (elscreen-create)
	    (elscreen-screen-nickname "el")
	    (find-file "~/.emacs.d/init.el")
	    (elscreen-create)
	    (elscreen-screen-nickname "org")
	    ))

;;;; with eshell
;;;;; With Elscreen [utils]

(defun eshell-current-elscreen-p (buf)
  (let ((regx (concat "\\*eshell\\*<" 
		      (number-to-string (elscreen-get-current-screen))
		      ".>")))
    (string-match regx (buffer-name buf))))


;;;;; with Elscreen [eshell]

(defun eshell-number-for-this-elscreen (index)
  (+ (* 10 (elscreen-get-current-screen)) index))

(defun eshell-for-this-elscreen (arg)
  "elscreen n, (u count of C-u) -> eshell n-u"
  (interactive "p")
  (eshell (eshell-number-for-this-elscreen (/ arg 4))))


;;;;; key

(global-set-key (kbd "C-c t") 'eshell-for-this-elscreen)



;;;; with files
;;;;; file name rule

(defun name-for-this-elscreen (original-name)
  (concat original-name "[" (number-to-string (elscreen-get-current-screen)) "]"))

;;;;; find file

(defadvice find-file (after add-elscreen-id activate)
  (let ((buf-name (name-for-this-elscreen (buffer-name (current-buffer)))))
    (rename-buffer buf-name)))

(defadvice find-file-other-window (after add-elscreen-id activate)
  (let ((buf-name (name-for-this-elscreen (buffer-name (current-buffer)))))
    (rename-buffer buf-name)))

;;;;; buffer-show (toggle all file <-> file in elscreen)

(require 'bs)


(defvar bs-toggle-status nil)
(defun bs-toggle-files-configuration ()
  (interactive)
  (if bs-toggle-status
      (bs-set-configuration bs-default-configuration)
    (bs-set-configuration "files"))
  (setq bs-toggle-status (not bs-toggle-status))
  (bs--redisplay t))

(define-key bs-mode-map "f" 'bs-toggle-files-configuration)

(defadvice bs-show (after init-bs-show-status-variables activate)
  (setq bs-toggle-status nil))

;;;;; buffer-show (in elscreen or not)

(defun is-not-buffer-for-elscreen (buf)
  (let ((re-correct (concat "\\[" (number-to-string (elscreen-get-current-screen)) 
			    "\\]$")))
    (not (string-match re-correct (buffer-name buf)))))

; define bs-configuration for elscreen.
; bs-configuration are list whose elements are
; (`bs-must-show-regexp', `bs-must-show-function',
;`bs-dont-show-regexp', `bs-dont-show-function' `bs-buffer-sort-function'.)
(setq bs-elscreen-configuration
      '("elscreen" nil nil nil is-not-buffer-for-elscreen nil))

; add elscreen bs-configuration to bs-configurations.
(custom-set-variables 
 '(bs-configurations 
   (cons bs-elscreen-configuration
	 bs-configurations)))

; set default configuration
(custom-set-variables
 '(bs-default-configuration "elscreen"))

;;;;; buffer-show (register)

(defun register-string-to-num (str id)
  (let ((orig-str 
	 (if (string-match "^\\(.*\\)\\[[0-9]+\\]$" str)
	     (match-string 1 str)
	   str)))
    (concat orig-str "[" (number-to-string id) "]")))
;; (register-string-to-num "ss" 1)
;; (register-string-to-num "ss[3]" 1)


(defun register-buffer-for-this-elscreen ()
  (interactive)
  (let* ((name (buffer-name (current-buffer)))
	 (name-new (register-string-to-num name (elscreen-get-current-screen))))
    (rename-buffer name-new)))

(global-set-key (kbd "C-q r") 'register-buffer-for-this-elscreen)




;;;  Window      
;;;; Win-control
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


;;;; Window split
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


;;;; Window Kept and opening buffer
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




;;;  constrol    
;;;; pop-win

; pop-win(package)

;(require 'popwin)
;(setq display-buffer-function 'popwin:display-buffer)

;; delete compilation-mode popwin
;; if this code is activated, compilation-mode buffer appear in the same  frame.
;; This behavior is not my target. I have to stop to popup itself.
;(delq (assoc 'compilation-mode popwin:special-display-config)
;      popwin:special-display-config)



;;;; mutli-cursors/smartrep

(require 'multiple-cursors)
(require 'smartrep)

(global-set-key (kbd "C-c l") 'mc/edit-lines)
(global-set-key (kbd "C-c r") 'mc/mark-all-in-region)

(global-unset-key "\C-t")

(smartrep-define-key global-map "C-t"
  '(("C-t" . 'mc/mark-next-like-this)
    ("n"   . 'mc/mark-next-like-this)
    ("p"   . 'mc/mark-previous-like-this)
    ("m"   . 'mc/mark-more-like-this-extended)
    ("u"   . 'mc/unmark-next-like-this)
    ("U"   . 'mc/unmark-previous-like-this)
    ("s"   . 'mc/skip-to-next-like-this)
    ("S"   . 'mc/skip-to-previous-like-this)
    ("*"   . 'mc/mark-all-like-this)
    ("d"   . 'mc/mark-all-like-this-dwim)
    ("i"   . 'mc/insert-numbers)
    ("o"   . 'mc/sort-regions)
    ("O"   . 'mc/reverse-regions)))



;;;  Edit        
;;;; Git

(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)


;;;; yasnippet

(require 'yasnippet)
(yas-global-mode t)
(setq yas-snippet-dirs 
      '(concat config-home "snippets"))
(setq yas-snippet-dirs (expand-file-name (concat config-home "snippets")))
(add-to-list 'load-path (expand-file-name (concat config-home "snippets")))


;;;; fold-dwim

(require 'fold-dwim)

(define-key global-map (kbd "C-c f") 'fold-dwim-toggle)
(define-key global-map (kbd "C-c a") 'fold-dwim-show-all)
(define-key global-map (kbd "C-c w") 'fold-dwim-hide-all)


;;;; flymake

(require 'flymake)
;(set-face-background 'flymake-warnline "yello")


;;;; auto insert

(auto-insert-mode)
(setq auto-insert-directory (expand-file-name (concat config-home "insert")))


;;;; hideshow

(add-hook 'hs-minor-mode-hook
	  '(lambda ()
	     (define-key hs-minor-mode-map (kbd "C-c f") 'hs-toggle-hiding)
	     (define-key hs-minor-mode-map (kbd "C-c w") 'hs-hide-all)
	     (define-key hs-minor-mode-map (kbd "C-c a") 'hs-show-all)))


;;;; outshine
;;;;; require

      (require 'outshine)


;;;;; def (outshine-fold-to-level-1)

(defun outshine-fold-to-level-1  ()
  (interactive)
  (beginning-of-line)
  (while (not (eobp))
    (outline-hide-more)
    (forward-line 1)))


;;;  Programming 
;;;; elisp
; lispxmp (package)
; unit test package for emacs lisp 
(require 'lispxmp)

; ert-expectation (package)
; unit test for emacs lisp
; This is not work correctory.
(require 'ert-expectations)

; emacs lisp hook
(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()
	     (outline-minor-mode)
	     (outshine-hook-function)
	     (outshine-fold-to-level-1)
;	     (define-windmove-key-bindings emacs-lisp-mode-map)
	     (turn-on-eldoc-mode)
	     (setq eldoc-idle-delay 0.2)
	     (setq eldoc-minor-mode-string "")
	     (define-key emacs-lisp-mode-map (kbd "C-c x") 'lispxmp)))
;;;; ruby 
;;;;; rsense
; rsense(package)

;(require 'rsense)
;(add-hook 'ruby-mode-hook
;	  (lambda ()
;	    (add-to-list 'ac-sources 'ac-source-rsense-method)
;	    (add-to-list 'ac-sources 'ac-source-rsense-constant)
;	    ))

;enh ruby mode(package)
;   (add-to-list 'load-path "d:/gnupack_basic-11.00/home/.emacs.d/elpa/enh-ruby-mode-20130305.1652/") ; must be added after any path containing old ruby-mode
;   (setq enh-ruby-program "(path-to-ruby1.9)/bin/ruby") ; so that still works if ruby points to ruby1.8
;   (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
;   (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
;   (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;;;;; hidesho
(let ((ruby-mode-hs-info
       '(ruby-mode
          "def"
          "end"
          "#"
          ruby-move-to-block
          nil)))
  (if (not (member ruby-mode-hs-info hs-special-modes-alist))
      (setq hs-special-modes-alist
            (cons ruby-mode-hs-info hs-special-modes-alist))))
;;"class\\|module\\|def\\|if\\|unless\\|case\\|while\\|until\\|for\\|begin\\|do"
(defun hs-hide-whole-def ()
  (interactive)
  (goto-char (point-min))
  (while (not (eobp))
	      (re-search-forward "^ *def")
	      (end-of-line)
	      (hs-hide-block)
	      (forward-line 1)
	      )
  (goto-char (point-min)))

(defun hs-hide-def ()
  (interactive)
  (end-of-line)
  (re-search-backward "^ *def")
  (end-of-line)
  (hs-toggle-hiding))
  
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (hs-minor-mode 1)
	    (define-key ruby-mode-map (kbd "C-c q") 'hs-toggle-hiding)
	    (define-key ruby-mode-map (kbd "C-c f") 'hs-hide-def)
	    (define-key ruby-mode-map (kbd "C-c w") 'hs-hide-whole-def)
	    (define-key ruby-mode-map (kbd "C-c o") 'hs-show-all)
	    (define-key ruby-mode-map (kbd "C-c d") 'credmp/flymake-display-err-minibuf)
	    (hs-hide-all)
	    ))

;;;;; flymake

;flymake-ruby(package)
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))

;;;;; basic
; ruby-inf
;; Copy/Cut/Paste:Ruby on Emacs : http://goo.Gp

(autoload 'ruby-mode "ruby-mode"
"Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
				     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
;;(autoload 'inf-ruby-keys "inf-ruby"
;;  "Set local key defs for inf-ruby in ruby-mode")
;(add-hook 'ruby-mode-hook
;	  '(lambda ()
;	     (inf-ruby-keys)))






;;;; python

;(setq auto-mode-alist
;      (cons '("\\.py" . python-mode) auto-mode-alist))
;(autoload 'python-mode "python-mode" "Python editting mode." t)


(add-hook 'python-mode-hook
	  '(lambda()
	     (outline-minor-mode)
	     (outshine-hook-function)
	     (linum-mode t)))


;;;; fortran 90/95
;;;;; hideshow
(defun hs-hide-function-or-subroutine ()
  (interactive)
  (end-of-line)
  (if (re-search-backward "^ *\\(subroutine\\|function\\)" nil t)
      (progn (end-of-line)
	     (hs-toggle-hiding))))
(defun hs-hide-whole-function-and-subroutine ()
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "^ *\\(subroutine\\|function\\)" nil t)
    (beginning-of-line)    
    (hs-hide-block)
    (forward-line 1)
    (beginning-of-line)))
;;;;; keybind
;(add-to-list 'ac-modes 'f90-mode)
(add-hook 'f90-mode-hook
	  '(lambda()
	     (hs-minor-mode 1)
;	     (mapcar (lambda (mode)
;		       (font-lock-add-keywords
;			mode
;			'(("= +\\(.*\\)(" 1 'font-lock-function-name-face))))
;		     '(f90-mode))
;	     (font-lock-add-keywords 
;	      nil
;	      '((" \\([:ascii:]*\\)(" 1 'font-lock-function-name-face)))
;;	     (define-key f90-mode-map (kbd "C-c q") 'hs-toggle-hiding)
;;	     (define-key hs-minor-mode-map (kbd "C-c w") 'hs-hide-all)
;;	     (define-key f90-mode-map (kbd "C-c o") 'hs-show-all)
	     (define-key f90-mode-map (kbd "C-c f") 'hs-hide-function-or-subroutine)
	     (define-key f90-mode-map (kbd "C-c w") 'hs-hide-whole-function-and-subroutine)
	     (define-key f90-mode-map (kbd "C-M-DEL") 'windmove-left)
	     (hs-hide-whole-function-and-subroutine)
;	     (define-key f90-mode-map (kbd "C-C f") 'hs-toggle-hiding)
;	     (define-key f90-mode-map (kbd "C-C w") 'hs-hide-all)
;	     (setcar hs-special-modes-alist 
;		   (cons '(f90-mode "subroutine\\|function\\|type" "end" "!" f90-end-of-block nil) hs-special-modes-alist))
;	     (hs-hide-all)
;;	     (flymake-mode t)
;;	     (define-key f90-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)
;;	     (setq ac-sources '(ac-source-yasnippet ac-source-words-in-same-mode-buffers))
	     ))
(setq auto-mode-alist
      (cons (cons "\\.f95$" 'f90-mode) auto-mode-alist))



;;;; c/c++
;;;;; flymake

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-std=c++11" "-Wall" "-Wextra" "-fsyntax-only" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

;;;;; color control


(defun my-cplus-color ()
  (interactive)
  (add-face-to-rexp-area "^ *// +\\* .*\n" 'face-sectioning)
 ;; (add-face-to-rexp-area "^ *//> .*$\\(.*\n\\)*^//<.*$" 'face-literate-program-code)
)


;;;;; section

(defun my-cplus-insert-outsine-section ()
  (interactive)
  (beginning-of-line)
  (insert "// \*"))

;;;;; config

(add-hook 'c++-mode-hook
	  (lambda ()
;	    (hs-minor-mode)
;	    (fold-dwim-hide-all)

;	    (my-cplus-color)
;	    (add-hook 'after-save-hook 'my-cplus-color)

;;	    (set-face-background 'font-lock-comment-face "white")
	    
	    (outline-minor-mode)
	    (outshine-hook-function)

	    (define-key c++-mode-map (kbd "C-c o") 'my-cplus-insert-outsine-section)

	    
;	    (flymake-mode t)
;	    (define-key c++-mode-map (kbd "M-?") 'credmp/flymake-display-err-minibuf)
	    (linum-mode t)))
	   


;;;;; auto insert

(define-auto-insert "\\.cpp" "cpp_template.cpp")


;;;; gnuplot


(require 'gnuplot-mode)

;; ;; specify the gnuplot executable (if other than /usr/bin/gnuplot)
;; (setq gnuplot-program "/sw/bin/gnuplot")

;; ;; automatically open files ending with .gp or .gnuplot in gnuplot mode
 (add-to-list 'auto-mode-alist
              '("\\.\\(gp\\|gnuplot\\)$" . gnuplot-mode) t)

;  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
;  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot-mode" t)
;  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode))
;			           auto-mode-alist))

;auto insert
(defun insert-gp-template ()
  (interactive)
  (yas/expand-snippet
  "set term postscript eps enhanced color
   set output '`(file-name-nondirectory (file-name-sans-extension (buffer-file-name)))`.eps'
   set size 0.5,0.5
   set grid
   set key right
   $0
"
  (point) (point)
  ))
(define-auto-insert "\\.gp$" 'insert-gp-template)


;;;; auctex
;;;;; fold

;auctex(package)
;(setq dum-list '(("[f]" ("footnoe" "footnote2")) ("[i]" ("index" "in")) (1 ("section" "subsection" "part" "paragraph"))))
;; TEXROOT  C:\w32tex\share\texmf\fonts;C:\w32tex\share\texmf-local\fonts
;; TEXPK    ^r\tfm\\^s^tfm;^r\pk\\^s.^dpk;^r\vf\\^s.vf;^r\ovf\\^s.ovf;^r\tfm\\^s.tfm
;; TEXFONTS ^r\tfm\\

;; get folding relations which fold "fold-str"
(defun filter-LaTeX-fold-spec-list (fold-str)
  (let ((filter (lambda (x) (string-match fold-stdr x))))
	(fold-list-list (list 
			 LaTeX-fold-env-spec-list 
			 LaTeX-fold-math-spec-list
			 LaTeX-fold-macro-spec-list)))
    (mapcar (lambda (fold-list) 
	      (remove-if-not filter fold-list))
	    fold-list-list))

(defun modify-TeX-fold-spec-list ()
  (let ((key1 1))
    (delete "subsection" (car (cdr (assoc key1 TeX-fold-macro-spec-list))))
    (add-to-list 'TeX-fold-macro-spec-list '("  {1}" ("subsection")))))

;(modify-TeX-fold-spec-list)
;(print TeX-fold-macro-spec-list)

;;;;; doc view 

; revert doc view from other buffer

;(defun my-doc-view-revert-from-other-buffer ()
;  (interactive)
;  (let ((tex-buf-name (buffer-name (current-buffer))))
;    (if (string-match "\\.tex$" tex-buf-name)
;	(let ((dvi-buf-name (concat (substring tex-buf-name 0 -4) ".dvi")))
;	  (progn
;	    (switch-to-buffer dvi-buf-name)
;	    (revert-buffer))))))

(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;;;;; config

(load "tex-site")
(setq auto-mode-alist
      (append '(("\\.tex$" . japanese-latex-mode)
		("\\.ltx$" . japanese-latex-mode)) auto-mode-alist))
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
(setq TeX-math-close-double-dollar t) ; $->$$ ?
;(setq TeX-command-list (list "platex" "dviout"))
;(setq-default TeX-master nil)
;(setq TeX-default-mode 'japanese-latex-mode)
;auto insert
(define-auto-insert "\\.tex$" "tex.tex")

(load (expand-file-name (concat config-home "tex.el")))
;(load (expand-file-name "~/.emacs.d/elisp/tex.el"))

;;;;; key binding
(defun auctex-define-keys ()
  (progn
    (define-key TeX-mode-map (kbd "C-c r") 'helm-ref-tex)
    (define-key TeX-mode-map (kbd "C-c j") 'tex-pop-to-label)
    (define-key outline-minor-mode-map (kbd "C-c f") 'fold-dwim-toggle)
    (define-key outline-minor-mode-map (kbd "C-c w") 'fold-dwim-hide-all)
    (define-key outline-minor-mode-map (kbd "C-c b") 'TeX-fold-buffer)    
;    (define-key TeX-mode-map (kbd "$") (smartchr '("$`!!'$" "$")))
;    (define-key TeX-mode-map (kbd "y") (smartchr '("y" "\\" "\\\\")))
;    (define-key TeX-mode-map (kbd "d") (smartchr '("d" "$`!!'$")))
))

;;;;; hook
(add-hook 'TeX-mode-hook
	  '(lambda ()
	     (setq TeX-command-default "pLaTeX")
	     (setq TeX-electric-escape nil)
	     (setq LaTeX-math-arev-prefix ":")
	     (setq TeX-math-close-double-dollar t)	     
	     (setq TeX-insert-braces t)
;	     (auto-complete-mode)
;	     (ac-latex-mode-setup)
	     (add-to-list 'LaTeX-fold-math-spec-list '("{1}" ("vector")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("|{1}>" ("ket")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("<{1}|" ("bra")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("<{1}>" ("Braket")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("<{1}>" ("braket")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("~{1}" ("tilde")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("-{1}" ("bar")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("({1})/({2})" ("frac")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("{1}" ("mathrm")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("{1}" ("mathbf")))	     
	     (add-to-list 'LaTeX-fold-math-spec-list '("{1}" ("boldsymbol")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("^{1}" ("hat")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("{1}" ("mathbf")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("√({1})" ("sqrt")))	     
;	     (add-to-list 'LaTeX-fold-macro-spec-list '("]" ("right]")))
;	     (add-to-list 'LaTeX-fold-math-spec-list '("[" ("left[")))
;	     (add-to-list 'LaTeX-fold-math-spec-list '("[[1]" ("left[")))
;	     (add-to-list 'LaTeX-fold-macro-spec-list '(")" ("right)")))
;	     (add-to-list 'LaTeX-fold-macro-spec-list '("(" ("left(")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("({1})" ("braces")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("{{1}}" ("bracem")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("[{1}]" ("braceb")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '(")" ("rights")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("(" ("lefts")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("]" ("rightb")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("[" ("leftb")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("}" ("rightm")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("{" ("leftm")))
;	     (add-to-list 'LaTeX-fold-macro-spec-list '("}" ("right\}")))
;	     (add-to-list 'LaTeX-fold-macro-spec-list '("{" ("left\{")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("\[" ("begin{eqnarray}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("\]" ("end{eqnarray}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("[a" ("begin{array}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("a]" ("end{array}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("[i" ("begin{itemize}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("i]" ("end{itemize}")))
	     (add-to-list 'LaTeX-fold-env-spec-list  '("fig" ("figure")))
	     (add-to-list 'LaTeX-fold-env-spec-list  '("tbl" ("table")))
;	     (modify-TeX-fold-spec-list)
	     (auctex-define-keys)
	     (turn-on-reftex)
	     (LaTeX-math-mode 1)
	     (tex-fold-mode 1)
	     (TeX-fold-buffer)
	     (TeX-fold-buffer)
	     (outline-minor-mode 1)
;	     (orgtbl-mode)
	     (fold-dwim-hide-all)
	     (yas-load-directory (expand-file-name (concat config-home "snippets/")))))



