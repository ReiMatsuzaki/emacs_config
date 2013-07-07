;;=========package.el==============
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;=========Basic configuration=====
;; load path
;(add-to-list 'load-path "~/.emacs.d")

;; exec path
(setq exec-path (cons (expand-file-name "~/bin") exec-path))
(setq exec-path (cons (expand-file-name "~/local/bin") exec-path))

;; unbind C-c C-x and define exit command
(global-unset-key "\C-c \C-x")
(defalias 'exit 'save-buffers-kill-emacs)

;; no tool bar, scroll bar, mnu bar
(tool-bar-mode 0)
(scroll-bar-mode -1)

;; ffap. Extention of C-x C-f
(ffap-bindings)

;; iswichb. Extention of C-x b
(iswitchb-mode 1)

;; hilight kakko
(show-paren-mode t)

;; no menu bar
(menu-bar-mode 1)
(menu-bar-mode -1)

;; scroll
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

;; no backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq delete-auto-save-files t)

;; doc-view
;(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; scroll
(global-set-key (kbd "M-n") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)

;; search color
(set-face-attribute 'isearch-lazy-highlight-face nil
                    :foreground "black"
                    :background "yellow"
		    :box nil)

;; underline
(setq hl-line-face 'underline)
(global-hl-line-mode)

;;=========Appearance================
(when window-system
  (progn
    (setq default-frame-alist
	  (append
	   (list
	    `(width  .  80)
	    `(height .  50)
	    `(alpha  .  100))
	   default-frame-alist))))

;color theme
;(color-theme-initialize)
;(color-theme-billw)

;; prompt
;(set-face-foreground 'minibuffer-prompt "white")



;;(load "d:/public_vm/Dropbox/Config/powerline_themes/billw.el")
(set-face-attribute 'mode-line-inactive nil
                    :foreground "black"
                    :background "white"
		    :box nil)
;

(set-face-attribute 'mode-line nil
                    :foreground "red"
                    :background "white"
		    :box nil
                    )
;;
(defun describe-face-at-point ()
  "Return face used at point"
  (interactive)
  (message "%s" (get-char-property (point) 'face)))
;;=========BasicKey Binding==========
;; Binding C-h to backspace
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-cc"  'compile)
(global-set-key "\C-x\C-b" 'bs-show)

;; hippie expand. Completation.
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

;;==========buffer controll=====================
;; depend on windmove.el
;; depend on hiwin.el
(require 'windmove)
(defun buffer-flip-chose-direction (direction)
  (flet ((buffer-flip (win1 win2)
		      (let ((b1 (window-buffer win1))
			    (b2 (window-buffer win2)))
			(set-window-buffer win1 b2)
			(set-window-buffer win2 b1)
			(select-window win2))))
    (buffer-flip (selected-window) 
		 (windmove-find-other-window direction))))
;(buffer-flip-chose-direction 'right)

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
       `((file ,(lambda () (wincon-get-bbl-in-current-frame 'buffer-file-name)))
	 (shell wincon-get-bbl-eshell-for-current-screen))))
    (when (equal cmd ?4)
      (wincon-construct
       'wincon-set-windows-2121
       `((file ,(lambda () (wincon-get-bbl-in-current-frame 'buffer-file-name)))
	 (shell wincon-get-bbl-eshell-for-current-screen))))
    (when (not (equal cmd ?g))
      (buffer-control-ui))))

(define-key global-map (kbd "C-t") 'buffer-control-ui)



;;==========auto complete(package)==============
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode 1)
(add-to-list 'load-path "~/.emacs.d")
(setq-default ac-sources
  '(ac-source-yasnippet
    ac-source-words-in-same-mode-buffers
    ac-source-abbrev
    ac-source-files-in-current-dir
    ac-source-filename))

(setq ac-use-menu-map t)
(setf (symbol-function 'yas-active-keys)
      (lambda ()
        (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))


;;========window===============
;; split window
(defun other-window-or-split (num)
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window num))

(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))

(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))


(global-set-key (kbd "C-<convert>") 
		'(lambda () (interactive) (other-window-or-split 1)))
(global-set-key (kbd "C-<non-convert>")
		'(lambda () (interactive) (other-window-or-split -1)))
(global-set-key "\C-x#" '(lambda ()
                           (interactive)
                           (split-window-horizontally-n 3)))
(global-set-key "\C-x$" '(lambda ()
                           (interactive)
                           (split-window-horizontally-n 4)))
;; window move
(global-set-key (kbd "M-DEL") nil)
(setq windmove-wrap-around t)
(define-key global-map (kbd "C-M-k") 'windmove-up)
(define-key global-map (kbd "C-M-p") 'windmove-up)
(define-key global-map (kbd "C-M-j") 'windmove-down)
(define-key global-map (kbd "C-M-n") 'windmove-down)
(define-key global-map (kbd "C-M-l") 'windmove-right)
(define-key global-map (kbd "C-M-f") 'windmove-right)
(define-key global-map (kbd "M-DEL") 'windmove-left)
(define-key global-map (kbd "C-M-b") 'windmove-left)

;; find file any window
(defvar opening-buffer nil)
(defun find-file-and-kept-opening-buffer (file-name)
  "find file and kept it for opening-buffer"
  (interactive)
  (setq opening-buffer (find-file-noselect (expand-file-name file-name))))
(defun switch-to-opening-buffer ()
  "open opening-buffer at current window"
  (interactive)
  (if opening-buffer
      (progn
	(switch-to-buffer opening-buffer)
	(setq opening-buffer nil))
  (message "there is no opening-buufer")))

(define-key global-map (kbd "C-M-m") 'switch-to-opening-buffer)
    

;;==========eshell======================
;; avoid "Text is read-only"
(defadvice eshell-get-old-input (after eshell-read-only-korosu activate)
  (setq ad-return-value (substring-no-properties ad-return-value)))

(defun eshell-current-elscreen-p (buf)
  (let ((regx (concat "\\*eshell\\*<" 
		      (number-to-string (elscreen-get-current-screen))
		      ".>")))
    (string-match regx (buffer-name buf))))

(defun eshell-number-for-this-elscreen (index)
  (+ (* 10 (elscreen-get-current-screen)) index))

(defun eshell-for-this-elscreen (arg)
  "elscreen n, (u count of C-u) -> eshell n-u"
  (interactive "p")
  (eshell (eshell-number-for-this-elscreen (/ arg 4))))

(global-set-key (kbd "C-c t") 'eshell-for-this-elscreen)

(add-hook 'eshell-mode-hook
	  '(lambda ()
	     (progn
	       (define-key eshell-mode-map (kbd "C-M-l") 'windmove-right)
	       (define-key eshell-mode-map "\C-a" 'eshell-bol)
	       (define-key eshell-mode-map "\C-p" 'eshell-previous-matching-input-from-input)
	       (define-key eshell-mode-map "\C-n" 'eshell-next-matching-input-from-input))))
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

;;;=========IME==========================
;   ;; IME OFF
;   (set-cursor-color "pink")

   (add-hook 'input-method-activate-hook
	     (lambda() (set-cursor-color "red")))
   (add-hook 'input-method-inactivate-hook
	     (lambda() (set-cursor-color "cyan")))
   (define-key global-map "\C-o" 'toggle-input-method)

;;===========remote========================
;; tramp via ftp
;(defun koki ()
;  "ftp to kokiibi0"
;  (interactive)
;  (dired-at-point "/ftp:matsuzak@kokiib0.chem.keio.ac.jp:/home/matsuzak/"))

;; tramp
;(require 'tramp)

;; tramp util (down load from web)
;(require 'tramp-util)

;(setq ange-ftp-program-name "/usr/local/bin/ftp.exe")


;;plink
;;(setenv "PATH" (concat "d:/app/putty" ";" (getenv "PATH")))


;(setq tramp-default-method "d:/app/putty/PLINK.EXE")
;;(setq ange-ftp-program-name "/usr/local/bin/plink")
;
;(modify-coding-system-alist 'process "d:/app/putty/PLINK.EXE" 'utf-8-unix)
;(setq tramp-completion-without-shell-p t)
;(setq tramp-shell-prompt-pattern "^[ $]+")
;;; add "wssh" to tramp-methods
;(add-to-list 'tramp-methods
;             `("wssh"
;               (tramp-login-program        "d:/app/putty/PLINK.EXE")
;               (tramp-login-args           (("-l" "%u") ("-P" "%p")
;                                            ("-ssh") ("%h")))
;               (tramp-remote-sh            "/bin/sh")
;               (tramp-copy-program         nil)
;               (tramp-copy-args            nil)
;               (tramp-copy-keep-date       nil)
;               (tramp-password-end-of-line "xy")
;               (tramp-default-port         22)))

;;=======elscreen(package)=================
(setq my-color-tab "#123550")
(setq my-color-back "#112230")

(elscreen-start)

(set-face-background 'elscreen-tab-other-screen-face my-color-tab)
(set-face-foreground 'elscreen-tab-other-screen-face "white")
(set-face-background 'elscreen-tab-current-screen-face my-color-tab)
(set-face-foreground 'elscreen-tab-current-screen-face "red")

(set-face-background 'elscreen-tab-background-face my-color-back)

(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)

;; set the fixed tab width
(setq elscreen-display-tab 5)

;(Define-key global-map (kbd "C-S-<henkan>") 'elscreen-next)
;(define-key global-map (kbd "C-S-<muhenkan>") 'elscreen-previous)



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
;(setq elscreen-display-tab nil)
(defun elscreen-frame-title-update ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
           (screen-to-name-alist (elscreen-get-screen-to-name-alist))
           (title (mapconcat
                   (lambda (screen)
                     (format "%d%s %s"
                             screen (elscreen-status-label screen)
                             (get-alist screen screen-to-name-alist)))
                   screen-list " ")))
      (if (fboundp 'set-frame-name)
          (set-frame-name title)
        (setq frame-title-format title)))))
;(eval-after-load "elscreen"
;  '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))
;;=========main line(package) depend on cl-lib(package)===========
;(setq 
; mode-line-format
; (list "%e"
;       '(:eval (concat
;                (main-line-rmw            'left   my-color-tab  )
;                (main-line-buffer-id      'left   my-color-tab  my-color-back)
;                (main-line-major-mode     'left                 my-color-back  )
;                (main-line-minor-modes    'left                 my-color-back  )
;                (main-line-narrow         'left                 my-color-back nil)
;                (main-line-vc             'center                             nil)
;                (main-line-make-fill                                          nil)
;                (main-line-row            'right                my-color-back nil)
;                (main-line-make-text      ":"                   my-color-back  )
;                (main-line-column         'right                my-color-back  )
;                (main-line-percent-xpm    'right  my-color-tab  my-color-back  )
;                (main-line-make-text      "  "    my-color-tab)))))

(when window-system
  (require 'main-line))
;(setq main-line-separator-style 'wave)
;(defmain-line row "%41")
;;; - contour
;;; - contour-left
;;; - contour-right
;;; - roundstub
;;; - roundstub-left
;;; - roundstub-right
;;; - brace
;;; - wave
;;; - zigzag
;;; - butt
;;; - wave-left
;;; - zigzag-left
;;; - butt-left
;;; - wave-right
;;; - zigzag-right
;;; - butt-right
;;; - chamfer
;;; - chamfer14
;;; - rounded
;;; - arrow
;;; - arrow14
;;; - slant
;;; - slant-left
;;; - slant-right
;;; - curve

;;========power line(package)==============
;(require 'powerline)
;(powerline-vim-theme)
;(powerline-default-theme)
;(powerline-center-theme)
;;========programming======================
(require 'flymake)
;;=======scala mode(package), ensime(git-hub)======
;(add-to-list 'load-path "~/.emacs.d/ensime-master/src/main/elisp/")
;(require 'ensime)
;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;;========pop-win(package)===============
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
;;=======driedx(package)=================
;(require 'diredx)
;;==========yasnippet(package)==================
(require 'yasnippet)
(yas-global-mode t)
(add-to-list 'load-path
	     "Y:/.emacs.d/snippets")
(setq yas-snippet-dirs 
      '("Y:/.emacs.d/snippets"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(yas-trigger-key "TAB"))

;;==========helm(package)=======================
(require 'helm-config)
(global-set-key (kbd "C-;") 'helm-mini)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-x") 'helm-M-x)

;helm-moccur(package)
(require 'helm-c-moccur)
(define-key isearch-mode-map (kbd "M-o") 'helm-c-moccur-from-isearch)
;;(helm-mode 1)


;;========fold-dwin(package)=============
;(require 'fold-dwim)
;(define-key global-map (kbd "C-c f") 'fold-dwim-toggle)
;(define-key global-map (kbd "C-c w") 'fold-dwim-hide-all)
;;========ruby and rsense(package)=========
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

;hs-minor-mode
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
  (goto-char (point-min))
)
(defun hs-hide-def ()
  (interactive)
  (end-of-line)
  (re-search-backward "^ *def")
  (end-of-line)
  (hs-toggle-hiding)
  )
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
; ruby-inf
;; Copy/Cut/Paste:Ruby on Emacs : http://goo.gl/AaaGp
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

;;========SLIME, IDE for lisp(package)======
;; ~~CAUTION~~
;; For operating slime correctry, I had to modify slime.el as follows:
;; ;; lexical-binding: t -> ;; lexical-binding: nil
;; and remove slime.elc.
;; ~~~~~~~~~~

(setq inferior-lisp-program "clisp")
;;(setq temporary-file-directory "/tmp/")

(require 'slime)
;;(setq slime-net-coding-system 'utf-8-unix)

; ac for slime (package)
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(add-hook 'inferior-lisp-mode-hook 'set-up-slime-ac)


;;========fortran 90/95=================
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

(add-to-list 'ac-modes 'f90-mode)

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
;;=============?=======================
;; agressive whitespace marking.
(defface latex-in-org-face 
  '((t (:foreground "red")))
  "latex in org face")


;(mapcar (lambda (mode)
;	  (font-lock-add-keywords
;	   mode
;	   '(("\.*egin\\(.*\n\\)+?.*end{.*}" 0 'font-lock-keyword-face)
;	     ("\\\\ref{.*}" 0 'font-lock-type-face)
;	     (" \\$.*\\$ " . 'font-lock-keyword-face))))
;	'(org-mode texinfo-mode))
;	     ("\\\\label{.*}" 0 'font-lock-keyword-face))))

;;========Programming C++===============
(goto-char 21220)
;;========auctex(package)===========================
;(setq dum-list '(("[f]" ("footnoe" "footnote2")) ("[i]" ("index" "in")) (1 ("section" "subsection" "part" "paragraph"))))
;; TEXROOT  C:\w32tex\share\texmf\fonts;C:\w32tex\share\texmf-local\fonts
;; TEXPK    ^r\tfm\\^s^tfm;^r\pk\\^s.^dpk;^r\vf\\^s.vf;^r\ovf\\^s.ovf;^r\tfm\\^s.tfm
;; TEXFONTS ^r\tfm\\

(defun modify-TeX-fold-spec-list ()
  (let ((key1 1))
    (delete "subsection" (car (cdr (assoc key1 TeX-fold-macro-spec-list))))
    (add-to-list 'TeX-fold-macro-spec-list '("  {1}" ("subsection")))))

;(modify-TeX-fold-spec-list)
;(print TeX-fold-macro-spec-list)

(load "tex-site")
(setq auto-mode-alist
      (append '(("\\.tex$" . japanese-latex-mode)
		("\\.ltx$" . japanese-latex-mode)) auto-mode-alist))
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
;(setq TeX-command-list (list "platex" "dviout"))
;(setq-default TeX-master nil)
;(setq TeX-default-mode 'japanese-latex-mode)
(require 'fold-dwim)
(add-hook 'TeX-mode-hook
	  '(lambda ()
	     (setq TeX-command-default "platex")
	     (setq TeX-electric-escape nil)
	     (setq LaTeX-math-abbrev-prefix ":")
	     (setq TeX-math-close-double-dollar t)	     
	     (setq TeX-insert-braces t)
	     (auto-complete-mode)
	     (ac-latex-mode-setup)
	     (add-to-list 'LaTeX-fold-math-spec-list '("{1}" ("V")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("|{1}>" ("ket")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("<{1}|" ("bra")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("<{1}>" ("Braket")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("<{1}>" ("braket")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("~{1}" ("tilde")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("({1})/({2})" ("frac")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("{1}" ("mathrm")))
	     (add-to-list 'LaTeX-fold-env-spec-list  '("fig" ("figure")))
	     (add-to-list 'LaTeX-fold-env-spec-list  '("tbl" ("table")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("{1}" ("boldsymbol")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("^{1}" ("hat")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("√({1})" ("sqrt")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("]" ("right]")))
	     (add-to-list 'LaTeX-fold-math-spec-list '("[" ("left[")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '(")" ("right)")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("(" ("left(")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("}" ("right\}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("{" ("left\{")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("\[" ("begin{eqnarray}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("\]" ("end{eqnarray}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("[a" ("begin{array}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("a]" ("end{array}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("[i" ("begin{itemize}")))
	     (add-to-list 'LaTeX-fold-macro-spec-list '("i]" ("end{itemize}")))
;	     (modify-TeX-fold-spec-list)
	     (define-key outline-minor-mode-map (kbd "C-c f") 'fold-dwim-toggle)
	     (define-key outline-minor-mode-map (kbd "C-c w") 'fold-dwim-hide-all)
	     (turn-on-reftex)
	     (LaTeX-math-mode 1)
	     (tex-fold-mode 1)
	     (TeX-fold-buffer)
	     (TeX-fold-buffer)
	     (outline-minor-mode 1)
	     (orgtbl-mode)
	     (fold-dwim-hide-all)
	     (define-key TeX-mode-map (kbd "C-c r") 'helm-ref-tex)
	     (define-key TeX-mode-map (kbd "C-c j") 'tex-pop-to-label)
	     (set-face-foreground 'font-latex-sectioning-2-face "Yellow")
	     (set-face-foreground 'font-latex-sectioning-3-face "GreenYellow")
	     (yas-load-directory "y:/.emacs.d/snippets/")))

;auto insert
(define-auto-insert "\\.tex$" "tex.tex")

(load (expand-file-name "~/.emacs.d/elisp/tex.el"))

;=========org-mode===========================
(setq org-startup-truncated t)
(setq temporary-file-directory "~/tmp/")
(setq org-export-latex-classes nil)
(setq org-hide-leading-stars t)
(add-to-list 'org-export-latex-classes
  '("jsarticle"
    "\\documentclass[a4j]{jsarticle}"
    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
    ("\\paragraph{%s}" . "\\paragraph*{%s}")
    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;; modify tex file exported from org-mode
(defun modify-tex-file-exported-from-org ()
  "tex file exported org cannot be compiled directory.
   This is because of hypersetup, which is inculded.
   In this function, delete these bad fragment in tex file."
  (interactive)
  (goto-char (point-min))
  (re-search-forward "\\usepackage{hyperref}")
  (move-to-column 0)
  (insert "%")
  (re-search-forward "hypersetup")
  (move-to-column 0)
  (insert "%")
  (forward-line 1)
  (insert "%")
  (forward-line 1)
  (insert "%")
  (forward-line 1)
  (insert "%"))
;; org->tex->dvi
(defvar ps-latex)
(defun org-export-dvi-by-modify-tex ()
  "create dvi file and modify it, create dvi file."
  (interactive)
  (let (tex-file-name 
	(tex-output-buffer (get-buffer-create "*LaTeX*"))
	ps)
    (org-export-as-latex 3)
    (setq tex-file-name (concat (substring (buffer-file-name) 0 -3) "tex"))
    (save-excursion
      (set-buffer (find-file-noselect tex-file-name))
      (modify-tex-file-exported-from-org)
      (basic-save-buffer)
      (kill-buffer nil))
    (message "start platex")
    (save-excursion
      (set-buffer tex-output-buffer)
      (erase-buffer))
    (setq ps
	  (start-process "*LaTeX" tex-output-buffer "platex" tex-file-name))
    (message "done")))
;; tex->dvi
(defun org-retry-latex ()
  "platex .tex"
  (interactive)
  (let ((fn (concat (substring (buffer-file-name) 0 -3) "tex")))
    (start-process "*LaTeX2" nil "platex" fn))
  (message "done"))

;pdf
(setq org-latex-to-pdf-process
      '("mypdflatex %f"))
;popwin
(push '("*LaTeXt*" :height 20) popwin:special-display-config)
; auto-complete ac-source-latex-commands (package:ac-math)
(require 'ac-math)
(add-to-list 'ac-modes 'org-mode)
(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
        (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
                ac-sources)))
;;latex-math-preview(from web)
(autoload 'latex-math-preview-expression "latex-math-preview" nil t)
(autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
(autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)
(autoload 'latex-math-preview-beamer-frame "latex-math-preview" nil t)
;; fold this section
(defun org-fold-this-brunch ()
  (interactive)
  (outline-previous-visible-heading 1)
  (org-cycle))
;; default dir
(setq org-directory "~/org/")
;; TODO, agenda
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
(setq org-log-done 'time)
(setq org-agenda-files (list org-directory))

;; hook
(add-hook 'org-mode-hook
	  (lambda ()
	    (ac-latex-mode-setup)
	    (define-key org-mode-map (kbd "\C-c c") 'org-export-dvi-by-modify-tex)
	    (define-key org-mode-map (kbd "\C-c p") 'latex-math-preview-expression)
	    (define-key org-mode-map (kbd "\C-c r") 'helm-ref-tex-in-org)
	    (define-key org-mode-map (kbd "\C-c i") 'org-fold-this-brunch)
	    (define-key org-mode-map (kbd "\C-c e") 'org-edit-special)
	    (turn-on-font-lock)
	    (yas-load-directory "y:/.emacs.d/snippets/")))
; org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((latex . t)
   (ruby . t)
   (sh . t)))
 

;=========elisp=========================
(let ((elisp-mode-hs-info
       '(emacs-lisp-mod
	 "{"
	 "}"
         ";"
          nil
          nil)))
  (if (not (member elisp-mode-hs-info hs-special-modes-alist))
      (setq hs-special-modes-alist
            (cons elisp-mode-hs-info hs-special-modes-alist))))
(add-hook 'emacs-lisp-mode-hook
	  '(lambda()
	     (hs-minor-mode 1)))

;;=====================================
;;=======auto insert===================
(auto-insert-mode)
(setq auto-insert-directory "y:/.emacs.d/insert/")

;;=====================================
;========gnuplot=======================
  ;gnuplot
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

;popwin
(push '("*gnuplot*" :height 20) popwin:special-display-config)

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

;;======================================
;;========color-moccur(package)================
(require 'color-moccur)
(setq moccur-split-word t)
(push '("*Moccur*" :height 20  :width  80 :position right) popwin:special-display-config)
(set-face-attribute 'moccur-face nil
                    :foreground "black"
                    :background "yellow"
                    )
;;======================================
;;=======w3m(package)=====================
;(require 'w3m)

;;=======bm(package)===================
(require 'bm)
(setq-default bm-buffer-persistence nil)
(setq bm-restore-repository-load t)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(global-set-key (kbd "M-@") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)
(set-face-attribute 'bm-face nil
                    :foreground "white"
                    :background "blue"
		    :box nil
                    )

