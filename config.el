;;;  Basics      
;;;; Configuration
;;;;; * Serial Number

;(load "~/.emacs.d/elisp/serial-num/serial.el")
(load (concat config-home "serial-num/serial.el"))
(global-set-key (kbd "C-c 0") 'set-serial-num-0)
(global-set-key (kbd "C-c s") 'insert-serial-num)
(global-set-key (kbd "C-c i") 'set-serial-num-n-interface)


;;;; Package Manager
;;;;; * Configuration

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;;; * Install
(mapc 
 (lambda (package)
   (or (package-installed-p package)
       (package-install package)))
 '(
;  ac-math	     
  ac-slime	     
  auctex	     
  auto-complete	     
  bm		     
  cl-lib	     
  color-moccur	     
  el-mock	     
  elscreen	     
  enh-ruby-mode	     
  ert-expectations   
  flymake-easy	     
  flymake-ruby	     
  fold-dwim	     
  ghc		     
  gnuplot	     
  gnuplot-mode	     
  haskell-mode	     
  ghc
  helm		     
  helm-c-moccur	     
  helm-c-yasnippet
  helm-descbinds
  lispxmp	     
  main-line	     
  popup		     
  popwin	     
  powerline	     
  rsense	     
  scala-mode	     
  slime		     
  w3m		     
  yasnippet
  magit
  mmm-mode
  outshine
  outorg
  multiple-cursors
  sage-shell-mode
  )
)

;;;; elscreen
;;;;; color

; Dark 
;(setq my-color-tab "#123550")
;(setq my-color-back "#112230")

(set-face-background 'elscreen-tab-other-screen-face my-color-tab-other-background)
(set-face-foreground 'elscreen-tab-other-screen-face my-color-tab-other-foreground)
(set-face-background 'elscreen-tab-current-screen-face my-color-tab-current-background)
(set-face-foreground 'elscreen-tab-current-screen-face my-color-tab-current-foreground)

(set-face-background 'elscreen-tab-background-face my-color-back)

(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)


;;;;; def (elscreen-frame-title-update), not used

;(defun elscreen-frame-title-update ()
;  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
;    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
;           (screen-to-name-alist (elscreen-get-screen-to-name-alist))
;           (title (mapconcat
;                   (lambda (screen)
;                     (format "%d%s %s"
;                             screen (elscreen-status-label screen)
;                             (get-alist screen screen-to-name-alist)))
;                   screen-list " ")))
;      (if (fboundp 'set-frame-name)
;          (set-frame-name title)
;        (setq frame-title-format title)))))
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


;;;; Appearance
;;;;; Font

 (set-face-attribute 'default nil
 		    :family "DejaVu Sans Mono"
 		    :height (round my-default-font-height))

;;;;; Window 
(when window-system
  (progn
    (setq default-frame-alist
	  (append
	   (list
	    `(width  .  80)
	    `(height .  50)
	    `(alpha  .  100))
	   default-frame-alist))))

;;;;; color-theme (black)
;color theme
;(color-theme-initialize)
;
;(color-theme-billw)
;(set-face-attribute 'font-lock-doc-face nil
;		    :foreground "white")
;(make-face 'face-literate-haskell-code)
;(set-face-background 'face-literate-haskell-code "navy")

;; prompt
;(set-face-foreground 'minibuffer-prompt "white")
;;;;; color-theme (white)

;(color-theme-initialize)
;
;(color-theme-infodoc)
;(set-face-attribute 'font-lock-doc-face nil
;		    :foreground "white")


;;;;; Mode line
;;(load "d:/public_vm/Dropbox/Config/powerline_themes/billw.el")
(set-face-attribute 'mode-line-inactive nil
                    :foreground "black"
                    :background "white"
		    :box nil)

(set-face-attribute 'mode-line nil
                    :foreground "red"
                    :background "white"
		    :box nil
                    )
;;;;; region

(setq transient-mark-mode t)
;(set-face-background 'region "midnight blue")

;;;;; search color

(set-face-attribute 'isearch-lazy-highlight-face nil
                    :foreground "black"
                    :background "yellow"
		    :box nil)

;;;;; hl-line
;; hight light line
; under line
;(setq hl-line-face 'underline)
;(global-hl-line-mode)

;(defface hlline-face
;  '((((class color)
;      (background dark))
;     (:background "dark slate gray"))
;    (((class color)
;      (background light))
;     (:background  "#98FB98"))
;    (t
;     ()))
;  "*Face used by hl-line.")

;(defface hlline-face
;  '((((class color)
;      (background dark))
;     (:background "gray10"))
;    (((class color)
;      (background light))
;     (:background "black"))
;    (t
;     ()))
;  "*Face used by hl-line.")

;(setq hl-line-face 'hlline-face)
;(global-hl-line-mode)

;;;;; main-line
(when window-system
  (require 'main-line))

;(setq main-line-color2 my-color-tab-other-background)
(setq main-line-color2 my-main-line-color-2)
(setq main-line-color1 my-main-line-color-1)
(setq main-line-separator-style 'wave)
;(setq main-line-separator-style 'brace)
;(defmain-line row "%41")
; - contour
; - contour-left
; - contour-right
; - roundstub
; - roundstub-left
; - roundstub-right
; - brace
; - wave
; - zigzag
; - butt
; - wave-left
; - zigzag-left
; - butt-left
; - wave-right
; - zigzag-right
; - butt-right
; - chamfer
; - chamfer14
; - rounded
; - arrow
; - arrow14
; - slant
; - slant-left
; - slant-right
;- curve

;;;;; power line (does not use)

;(require 'powerline)
;(powerline-vim-theme)
;(powerline-default-theme)
;(powerline-center-theme)


			
;;;;; generic mode

;; cf : "Emacs Lisp technique bible (japanese):
;;       written by Rubikichi.

(require 'generic-x)


;;;  control     
;;;; remote
;;;;; tramp via ftp
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
;;;;; tramp method
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



;;;; diredx 

;;=======driedx(package)=================
;(require 'diredx)
;;;; bm
; package
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
;;;; w3m
;package
(require 'w3m)
;;;; color-moccur

; package
(require 'color-moccur)
(setq moccur-split-word t)
(push '("*Moccur*" :height 20  :width  80 :position right) popwin:special-display-config)
(set-face-attribute 'moccur-face nil
                    :foreground "black"
                    :background "yellow"
                    )

;;;; helm

; helm(package)
(require 'helm-config)
(global-set-key (kbd "C-t") 'helm-mini)
(global-set-key (kbd "C-c r") 'helm-recentf)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-x") 'helm-M-x)

;; helm-descbinds(package)
(global-set-key (kbd "C-c b") 'helm-descbinds)

;helm-moccur(package)
(require 'helm-c-moccur)
(define-key isearch-mode-map (kbd "M-o") 'helm-c-moccur-from-isearch)
;;(helm-mode 1)

;;;; mutli-cursors

(require 'multiple-cursors)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;;  Edit        
;;;; smart-chr
;; will be removed
;(add-to-list 'load-path (concat config-home "smartchr"))
;(add-to-list 'load-path "~/.emacs.d/elisp/smartchr")

;(require 'smartchr)
;(global-set-key (kbd "(") (smartchr '("(`!!')" "(")))
;(global-set-key (kbd "{") (smartchr '("{`!!'}" "{")))
;(global-set-key (kbd "[") (smartchr '("[`!!']" "[")))

;(require 'smartchr)
;(global-set-key (kbd "(") (smartchr '("(`!!')" "(")))
;(global-set-key (kbd "{") (smartchr '("{`!!'}" "{")))
;(global-set-key (kbd "[") (smartchr '("[`!!']" "[")))
;(global-set-key (kbd "y") (smartchr '("y" "\\" "\\\\")))
;;;; auto-complete
;;;;; load

(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)

;;;;; config
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


;;;; IME
;;;;; ibus (does not use)
;
; need ibus package.
; this package can be obtained from apt-get:
;   apt-get install ibus-el
; and add the sentence to .Xresources file:
;   Emacs*useXIM: false

;(require 'ibus)
;(add-hook 'after-init-hook 'ibus-mode-on)
;(ibus-define-common-key ?\C-\s nil)
;(setq ibus-cursor-color '("red" "white" "limegreen"))
;(ibus-define-common-key (kbd "C-o") t)

;;;;; mozc

;; need emacs-mozc package of apt-get
(if (window-system)
    (progn
      (require 'mozc)
      (set-language-environment "japanese")
      (setq default-input-method "japanese-mozc")
      (setq mozc-candidate-style 'overlay)))
(setq mozc-candidate-style 'overlay)
;;(setq mozc-candidate-style 'echo-area)))


;;;;; color

;   ;; IME OFF
;   (set-cursor-color "pink")

   (add-hook 'input-method-activate-hook
	     (lambda() (set-cursor-color my-ime-active-color)))
   (add-hook 'input-method-inactivate-hook
	     (lambda() (set-cursor-color my-ime-inactive-color)))

;;;;; key binding

(define-key global-map "\C-o" 'toggle-input-method)


;;;; mmm-mode

(require 'mmm-mode)
;(setq mmm-global-mode t)
(setq mmm-submode-decoration-level 2)
;(set-face-background 'mmm-default-submode-face "Blue")

;;;; fold-dwim

; fold-dwin(package)
;(require 'fold-dwim)
;(define-key global-map (kbd "C-c f") 'fold-dwim-toggle)
;(define-key global-map (kbd "C-c w") 'fold-dwim-hide-all)

;(add-hook 'outline-minor-mode-hook 'outshine-hook-function)

;;;; outshine-face

(set-face-attribute 'outshine-level-1 nil
		    :foreground my-sect-color-1
		    :height (round (* my-default-font-height 1.4))
		    :underline t)
(set-face-attribute 'outshine-level-2 nil
                    :foreground my-sect-color-2
		    :height (round (* my-default-font-height 1.2))
		    :underline t)
(set-face-attribute 'outshine-level-3 nil
		    :foreground "gray40"
		    :underline t
		    :height (round (* my-default-font-height 1.1)))





;;;; yasnippet


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(yas-trigger-key "TAB"))
;;;; add face area
;;;;; RegularExpression -> [(Point . Point)]

;; from Regular Expression, obtaine matching sentence list
(defun rexp-to-point-point-list (rexp)
  (save-excursion
    (goto-char (point-min))
    (let (p0 p1 pp-list)
      (while (re-search-forward rexp nil t)
	(setq p0 (match-beginning 0))
	(setq p1 (match-end 0))
	(setq pp-list (cons (cons p0 p1) pp-list)))
      pp-list)))

;;;;; RegularExpression -> IO (add overlay)_
(defun add-face-to-rexp-area (rexp adapting-face)
  (remove-overlays (point-min) (point-max) 'face adapting-face)
  (let ((pp-list (rexp-to-point-point-list rexp)))
    (mapcar 
     (lambda (pp)
       (let* ((p0 (car pp))
	      (p1 (cdr pp))
	      (ov (make-overlay p0 p1 (current-buffer) t t)))
	 (overlay-put ov 'face adapting-face )))
     pp-list)))

;;;  programming 
;;;; haskell
;;;;; basic
; Haskell(package haskell, ghc)

(require 'haskell-mode)
(require 'haskell-cabal)

;(folding-add-to-marks-list 'haskell-mode "%{" "%}" nil t)
;(folding-add-to-marks-list 'literate-haskell-mode "%{" "%}" nil t)

(add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))
(add-to-list 'load-path "~/.cabal/share/ghc-mod-4.1.5")

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))
;haskell-program-name
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

; by setting (set-input-method "haskell-unicode"), psi [space] produce Greek psi.

;;;;; mmm

(mmm-add-classes
 '((literate-haskell-bird
    :submode text-mode
    :frot "^[^>]"
    :include-from true
    :back "^>\\|$"
    )
   (literate-haskell-latex
    :submode literate-haskell-mode
    :front "^\\\\begin{code}"
;    :front-offset (end-of-line 1)
    :back "^\\\\end{code}"
;    :include-back nil
;    :back-offset (beginning-of-line -1)
    )))

(defun my-haskel-mmm-mode ()
  (make-local-variable 'mmm-global-mode)
  (setq mmm-global-mode 'true))

(let ((literate-haskell-mode-hs-info
       '(literate-haskell-mode
          "\begin{code}"
          "\end{code}"
	  nil
	  nil
          nil)))
  (if (not (member literate-haskell-mode-hs-info hs-special-modes-alist))
      (setq hs-special-modes-alist
            (cons literate-haskell-mode-hs-info hs-special-modes-alist))))

;;;;; face

(defun my-haskell-define-face ()
  (copy-face 'my-face-error-check-warn 'ghc-face-warn)
  (copy-face 'my-face-error-check-error 'ghc-face-error)
)

;;;;; Display Synopsis

; Search whole of file editting and collect synopsis,
; then display these at the other buffer named "Synopsis"

; search file of current buffer and collect synopsis as string
; :: [string]
(defun my-haskell-collect-synopsis ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let (line-list)
      (while (re-search-forward "\\(^> [a-zA-Z0-9]* ::.*$\\|^--\\* .*$\\)" nil t)
	(setq line-list (cons (match-string 0) line-list)))
      line-list)))

; create buffer if not exist, and display strings
(defun my-haskell-display-synopsis ()
  (interactive)
  (save-excursion
    (let ((buf (get-buffer-create "*Synopsis*"))
	  (str-list (reverse (my-haskell-collect-synopsis))))
      (set-buffer buf)
      (erase-buffer)
      (while str-list
	(insert (car str-list))
	(insert "\n")
	(setq str-list (cdr str-list)))
      (my-literate-haskell-color))))

;;;;; hook

(add-hook 'haskell-mode-hook
	  (lambda () (ghc-init)
;	    (flymake-mode)
	    (haskell-indent-mode)
	    (inf-haskell-mode)
;	    (setq haskell-literate-default (quote tex))
	    (my-literate-haskell-color)
	    (add-hook 'after-save-hook 'my-literate-haskell-color)
	    (add-hook 'after-save-hook 'my-haskell-display-synopsis)
;	    (set-input-method "TeX")
	    (outline-minor-mode)
	    (outshine-hook-function)
	    (linum-mode)
	    (outshine-fold-to-level-1)
;	    (define-windmove-key-bindings inferior-haskell-mode-map)
	    (define-key haskell-mode-map (kbd "C-c f") 'fold-dwim-toggle)
	    (define-key haskell-mode-map (kbd "C-c o") 'fold-dwim-show-all)
	    (define-key haskell-mode-map (kbd "C-c w") 'fold-dwim-hide-all)
	    (define-key haskell-mode-map (kbd "C-c C-e") 'my-haskell-dynamical-evaluate)
;	    (define-key inf-haskell-mode-map (kbd "C-n") 'comint-next-input)
;	    (define-key inf-haskell-mode-map (kbd "C-p") 'comint-previous-input)
	    (my-ac-haskell-mode)
	    (my-haskell-define-face)
 ;	    (define-key haskell-mode-map (kbd "C-c o") 'folding-show-all)
;	    (my-haskel-mmm-mode)
	    ))



;;;;; complete

;;----complete by auto-complete and GHC-mode-----
(ac-define-source ghc-mod 
  '((depends ghc)
    (candidates . (ghc-select-completion-symbol))
    (symbol . "s")
    (cache)))

(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod)))

(defun my-haskell-ac-init ()
  (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
    (auto-complete-mode t)
    (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod))))

(add-hook 'find-file-hook 'my-haskell-ac-init)

;;;;; dynamical evaluation

;;-----dynamical evaluation-----
;; Like mathematica, evaluate one line. Before evaluate, *haskell* buffer must be activated.

(defun my-get-one-line ()
  (interactive)  
  (progn
    (end-of-line)
    (let ((p2 (point)))
      (beginning-of-line)
      (let ((p1 (point)))
	(buffer-substring p1 p2)))))

(defun my-haskell-dynamical-evaluate-one-line ()
  (interactive)
  (let* ((p0 (point))
	 (line (my-get-one-line))
	 (res (string-match "^ *> *" line)))
    (if res
	(let* ((idx (match-end 0))
		(line2 (substring line idx))
		(wind (selected-window)))
	  (progn
	    (switch-to-haskell)
	    (insert line2)
	    (comint-send-input)
	    (select-window wind))))
    (goto-char p0)
    res))

(defun my-haskell-dynamical-evaluate ()
  (interactive)
  (while (my-haskell-dynamical-evaluate-one-line)
    (forward-line)))

;;;;; color control 

(defun my-literate-haskell-color ()
  (interactive)
  (add-face-to-rexp-area "\\(^ *>.*\n\\)+" 'face-literate-program-code)
  (add-face-to-rexp-area "^--\\* .*\n" 'face-sectioning)
)



;;;; lisp 

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


;;;; latex-in-org-face

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
;(goto-char 21220)
