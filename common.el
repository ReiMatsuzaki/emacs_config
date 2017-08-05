;;; package -- Summary
;;; Commentary:
;
;  Minimal setting for Emacs. 
;
;
;;; Code:

;;; automatic install via Package manage
(setq my-packages
      '(anzu
	fold-dwim
	multiple-cursors
	smartrep
	persp-mode
;	ein
	outshine
	helm
	auto-complete
	yasnippet
					;	ace-link
	smooth-scroll
	auctex
;	magit
	popwin
	))

(require 'cl)
(mapcar (lambda (x)
	  (when (not (package-installed-p x))
	    (package-install x)))
	my-packages)

;;; Basics
;;;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;;;; chackle
;(require 'shackle)
;(setq shackle-rules
;      '(
;	(compilation-mode :frame nil)
;	))
;(shackle-mode 1)
					;(setq shackle-lighter "")

;;;; smooth-scroll
(require 'smooth-scroll)
(setq smooth-scroll/vscroll-step-size 4)
(smooth-scroll-mode t)


;;;; yascroll
(require 'yascroll)
(scroll-bar-mode t)
(global-yascroll-bar-mode t)

;;;; redo+
(when (require 'redo+ nil t)
  (define-key global-map (kbd "C-'") 'redo))

;;;; smartparens
;(require 'smartparens-config)
;(smartparens-global-mode t)

;;;; anzu
(require 'anzu)
(global-anzu-mode t)
(setq anzu-search-threshold 1000)
(setq anzu-minimum-input-length 3)
(global-set-key (kbd "C-c r") 'anzu-query-replace)
(global-set-key (kbd "C-c R") 'anzu-query-replace-regexp)

;;;; window manage
;(require 'smartrep    )
;(smartrep-define-key global-map "C-x"
;  '(("o" . other-window)
;    ("0" . delete-window)
;    ("1" . delete-other-windows)
;    ("2" . split-window-below)
;    ("3" . split-window-right)
;    ("{" . shrink-window-horizontally)
;    ("}" . enlarge-window-horizontally)
;    ("+" . balance-windows)
;    ("^" . enlarge-window)
;    ("-" . shrink-window)))

;;;; fold-dwim
(require 'fold-dwim)
(define-key my-keymap (kbd "C-f") 'fold-dwim-toggle)
(define-key my-keymap (kbd "C-a") 'fold-dwim-show-all)
(define-key my-keymap (kbd "C-w") 'fold-dwim-hide-all)
;(define-key global-map (kbd "C-c f") 'fold-dwim-toggle)
;(define-key global-map (kbd "C-c q") 'fold-dwim-show-all)
;(define-key global-map (kbd "C-c w") 'fold-dwim-hide-all)

;;;; neotree
;(require 'neotree)
;(global-set-key (kbd "M-[") 'neotree-show)
;(global-set-key (kbd "M-]") 'neotree-hide)
;(setq neo-create-file-auto-open t)
;(setq neo-keymap-style 'concise)
;(setq neo-smart-open t)
;(setq neo-theme 'classic)

;;;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md'" . markdown-mode))

;;;; mutli-cursors/smartrep
(require 'multiple-cursors)
(require 'smartrep)

;(global-set-key (kbd "C-c l") 'mc/edit-lines)
;(global-set-key (kbd "C-c r") 'mc/mark-all-in-region)
;(define-key my-keymap (kbd "C-l") 'mc/edit-lines)
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

;;;; Git
(require 'magit)
(define-key my-keymap (kbd "C-t") 'magit-status)


;;; EIN
;(require 'ein)
;(define-key ein:notebook-python-mode-map [C-return] 'ein:worksheet-execute-cell)
;(define-key ein:notebook-python-mode-map [C-return] 'ein:worksheet-execute-cell)

;(defvar hs-special-modes-alist
;  (mapcar 'purecopy
;	  (ein:notebook-multilang-mode "{" "}"  "/[*/]" nil nil)
;	  (c++-mode "{" "}" "/[*/]" nil nil)
;	  (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
;	  (java-mode "{" "}" "/[*/]" nil nil)
;	  (js-mode "{" "}" "/[*/]" nil)))


;(add-hook
; 'ein:notebook-multilang-mode-hook
; '(lambda ()
;    (outline-minor-mode t)
;    (define-key
;      ein:notebook-mode-map
;      (kbd "\C-c 1")
;      (lambda () (interactive) (ein:worksheet-change-to-outlined-heading 1)))    
;    (define-key
;      ein:notebook-mode-map
;      (kbd "\C-c 2")
;      (lambda () (interactive) (ein:worksheet-change-to-outlined-heading 2)))
;    (define-key
;      ein:notebook-mode-map
;      (kbd "\C-c 3")
;      (lambda () (interactive) (ein:worksheet-change-to-outlined-heading 3)))
;    (define-key ein:notebook-mode-map (kbd "M-n") (kbd "C-u 5 C-n"))
;    (define-key ein:notebook-mode-map (kbd "M-p") (kbd "C-u 5 C-p"))))
;
;(defun ein:worksheet-change-to-outlined-heading (level)
;  (ein:worksheet-change-cell-type
;   (ein:worksheet--get-ws-or-error)
;   (ein:worksheet-get-current-cell)
;   "heading" level)
;  (next-line)
;  (let ((count 0))
;    (while (< count level)
;      (insert "*")
;      (setq count (+ count 1))))
;  (insert " "))


					;(define-key (kbd "\C-c 1") 'org-time-stamp-inactive)

;;; persp-mode
(if window-system
    (progn ()
	   (setq persp-keymap-prefix (kbd "C-c p"))
	   (persp-mode)
	   (define-key move-global-minor-mode-map (kbd "M-l") 'persp-next)
	   (define-key move-global-minor-mode-map (kbd "M-h") 'persp-prev)))
	   

;;; Elscreen
;;;; basic setting

;(require 'elscreen)
;(setq elscreen-prefix-key "\C-q")
;(elscreen-start)
;(setq elscreen-display-tab 5)
;(setq elscreen-tab-display-control nil)
;(setq elscreen-tab-display-kill-screen nil)

;;;; eshell utils

;(defun eshell-current-elscreen-p (buf)
 ; (let ((regx (concat
	;       "\\*eshell\\*<"
	;       (number-to-string (elscreen-get-current-screen))
	;       ".>")))
    ;(string-match regx (buffer-name buf))))
;
;
;(defun eshell-number-for-this-elscreen (index)
;  (+ (* 10 (elscreen-get-current-screen)) index))
;
;(defun eshell-for-this-elscreen (arg)
;  (interactive "p")
;  (eshell (eshell-number-for-this-elscreen (/ arg 4))))

;;;; key bind
;(global-set-key (kbd "C-c t") 'eshell-for-this-elscreen)
;(global-set-key (kbd "C-c t") 'eshell)

;(smartrep-define-key global-map "C-q"
;  '(("n" . elscreen-next)
;    ("p" . elscreen-previous)))

;;;; start

;(add-hook 'after-init-hook
;	  (lambda ()
;	    (elscreen-screen-nickname "main")
;	    (elscreen-create)
;	    (elscreen-screen-nickname "src1")
;	    (elscreen-create)
;	    (elscreen-screen-nickname "src2")
;	    (elscreen-create)
;	    (elscreen-screen-nickname "src3")
;	    (elscreen-create)
;	    (elscreen-screen-nickname "prj1")
;	    (elscreen-create)
;	    (elscreen-screen-nickname "prj2")
;	    (elscreen-create)
;	    (elscreen-screen-nickname "prj3")
;	    (elscreen-create)	    
;	    (elscreen-screen-nickname "ein")
;	    (elscreen-create)
;	    (elscreen-screen-nickname "el")
;	    (elscreen-create)
;	    (elscreen-screen-nickname "agnd")))


;;; outshine
(require 'outshine)
(defun outshine-fold-to-level-1  ()
  (interactive)
  (beginning-of-line)
  (while (not (eobp))
    (outline-hide-more)
    (forward-line 1)))

;;; org
;;;;; config

;; set locale as English
(setq system-time-locale "C")

(setq org-startup-truncated nil)
(setq org-export-latex-classes nil)
(setq org-hide-leading-stars nil)

(defun org-fold-this-brunch ()
  "Fold brunch which the cursol is located."
  (interactive)
  (outline-previous-visible-heading 1)
  (org-cycle))

(global-set-key (kbd "C-c a ") 'org-agenda)
(global-set-key (kbd "C-c m") 'org-capture)

(add-hook 'org-mode-hook
	  (lambda ()
	    (setq truncate-lines t)
	    (define-key org-mode-map (kbd "\C-c 1") 'org-time-stamp-inactive)
	    (define-key org-mode-map (kbd "\C-c f") 'org-fold-this-brunch)
	    (define-key org-mode-map (kbd "\C-c e") 'org-edit-special)))

(smartrep-define-key org-mode-map "C-c"
  '(("C-n" . outline-next-visible-heading)
    ("C-p" . outline-previous-visible-heading)
    ("C-u" . outline-up-heading)
    ("C-f" . org-forward-heading-same-level)
    ("C-b" . org-backward-heading-same-level)))

;; Columns Views
; http://futurismo.biz/archives/3631
(setq org-global-properties (quote ((
      "Effort_ALL" . "00:05 00:10 00:15 00:30 01:00 01:30 02:00 02:30 03:00"))))
;; カラムビューで表示する項目
;; Column の書式は以下.
;; [http://orgmode.org/manual/Column-attributes.html#Column-attributes
(setq org-columns-default-format "%50ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM(Clock){:}")
(setq org-agenda-columns-add-appointments-to-effort-sum t)

; priority means time region
; | priority | time region|
; |    A     | 9:00-12:00 |
; |    B     | 13:00-16:00|
; |    C     | 16:00-19:00|
; |    D     | 21:00-24:00|
(setq org-highest-priority ?A)
(setq org-lowest-priority ?D)
(setq org-default-priority ?A)

;;; elisp

;; code for elisp mode are written in prog.el


; lispxmp (package)
; unit test package for emacs lisp 
; (require 'lispxmp)

; ert-expectation (package)
; unit test for emacs lisp
; This is not work correctory.
; (require 'ert-expectations)

; emacs lisp hook
;(add-hook 'emacs-lisp-mode-hook
;	  '(lambda ()
;	     (outline-minor-mode)
;	     (outshine-hook-function)
;	     (outshine-fold-to-level-1)
;	     (turn-on-eldoc-mode)
;	     (setq eldoc-idle-delay 0.2)
;	     (setq eldoc-minor-mode-string "")
;	     (define-key emacs-lisp-mode-map (kbd "C-c x") 'lispxmp)
;	     ))

;;; dired
(require 'dired-details)
(dired-details-install)	    
(setq dired-dwim-target t)
(setq dired-details-hidden-string "")
(setq dired-details-hide-link-target nil)
(define-key my-keymap (kbd "C-d") 'dired-toggle)
(add-hook 'dired-load-hook
	  (lambda ()
	    (define-key dired-mode-map (kbd "j") 'dired-next-line)
	    (define-key dired-mode-map (kbd "k") 'dired-previous-line)))

;;; helm
;;;; require

(when (require 'helm-config nil t)
  (helm-mode 1))

;;;; key bind

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'find-file)
(define-key my-keymap (kbd "C-a") 'helm-apropos)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; ordinary completetion by TAB in helm-find-files
;(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

;;;; configure regular expression search
; this code is copied from the web site
; d.hatena.ne.jp/a_bicky/20140104/1388822688

;(defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
;  "Transform the pattern to reflect my intention"
;  (let* ((pattern (ad-get-arg 0))
;	 (input-pattern (file-name-nondirectory pattern))
;	 (dirname (file-name-directory pattern)))
;    (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
;    (setq ad-return-value
;	  (concat dirname
;		  (if (string-match "\\^" input-pattern)
;		      (substring input-pattern 1)
;		    (concat ".*" input-pattern))))))
;;;; helm-migemo
(when (locate-library "migemo")
  (progn
    (require 'migemo)
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs"))

    (setq migemo-user-dictionary nil)
    (setq migemo-regex-dictionary nil)
    (setq migemo-coding-system 'utf-8-unix)
    (load-library "migemo")
    (migemo-init)))

;;; Search
;;;; helm-migemo
; rubikichi.com/2014/12/9/helm-migemo/
(when (locate-library "helm-migemo")
  (progn 
    (require 'helm-migemo)

    (eval-after-load "helm-migemo"
      '(defun helm-compile-source--candidates-in-buffer (source)
	 (helm-aif (assoc 'candidates-in-buffer source)
	     (append source
		     `((candidates
			. ,(or (cdr it)
			       (lambda ()
				 ;; Do not use `source' because other plugins
				 ;; (such as helm-migemo) may change it
				 (helm-candidates-in-buffer (helm-get-current-source)))))
		       (volatile) (match identity)))
	   source)))))


;;;; helm-swoop
(require 'helm-swoop)
(define-key my-keymap (kbd "C-s") 'helm-swoop)

;;; auto-complete

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(setq ac-auto-start 4)
(setq ac-use-fuzzy t)

;; exclude Japanese from candidates
;; http://d.hatena.ne.jp/IMAKADO/20090813/1250130343
(defadvice ac-word-candidates (after remove-word-contain-japanese activate)
  (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
    (setq ad-return-value
	  (remove-if contain-japanese ad-return-value))))

;;; yasnippet
(require 'yasnippet)

(define-key yas-minor-mode-map (kbd "C-c i") 'yas/insert-snippet)
(define-key yas-minor-mode-map (kbd "C-c n") 'yas/new-snippet)
(define-key yas-minor-mode-map (kbd "C-c v") 'yas/visit-snippet-file)
(setq yas-snippet-dirs (list (concat config-home "snippets")))

(yas/global-mode 1)

;;; web-mode

;(require 'web-mode)
;(add-to-list 'auto-mode-alist
;	     '("\\.html?$" . web-mode))

;;; eww
;;;; Basic

(require 'eww)
; set search engine for Google
(setq eww-search-prefix "http://www.google.co.jp/search?q=")
;(setq eww-search-prefix "https://duckduckgo.com/html/?kl=jp-jp&kl=-1&kc=1&kf=-1&q=")

;;;; ace jump

;(require 'ace-link)
;(eval-after-load 'eww 
;  '(define-key eww-mode-map "f" 'ace-link-eww))
;(ace-link-setup-default)

;;;; keybind

;(defun eww-mode-hook--rename-buffer()
;  "Rename eww's buffer so sites open in new pane"
;  (rename-buffer "eww" t))
;(add-hook 'eww-mode-hook 'eww-mode-hook--rename-buffer)

;; key bind
(define-key global-map (kbd "C-c e") 'eww)

;; eww key bindings
(define-key eww-mode-map "j" 'next-line)
(define-key eww-mode-map "k" 'previous-line)
(define-key eww-mode-map "l" 'forward-char)
(define-key eww-mode-map "h" 'backward-char)
(define-key eww-mode-map "r" 'eww-reload)
(define-key eww-mode-map "p" 'scroll-down)
(define-key eww-mode-map "n" 'scroll-up)
(define-key eww-mode-map "H" 'eww-back-url)
(define-key eww-mode-map "L" 'eww-forward-url)

;;;; image

;see http://futurismo.biz/archives/2950
(defun eww-disable-images ()
  "do not show images in eww"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image-alt)
  (eww-reload))

(defun eww-enable-images ()
  "show images in eww"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image)
  (eww-reload))
(defun shr-put-image-alt (spec alt &optional flags)
  (insert alt))

(defun eww-mode-hook--disable-image ()
  (setq-local shr-put-image-function 'shr-put-image-alt))
(add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)

;;;; multi eww support

;; these functions work incorrect

(defun eww-buffer-list ()
  "Gives eww buffer list."
  (remove-if 
   (lambda (buf)
     (not (string-match "^\\*eww" (buffer-name buf))))
   (buffer-list)))

(defun eww-with-rename ()
  "Lunch eww with renaming buffer."
  (interactive)
  (let ((url-or-key (read-from-minibuffer "Enter URL or keywords")))
    (eww url-or-key)
    (rename-buffer url-or-key t)))

;;; view-mode
(setq view-read-only t)
(defvar pager-keybind
  '(("h" . backward-char)
    ("l" . forward-char)
    ("k" . previous-line)
    ("j" . next-line)
    ("b" . scroll-down)
    (" " . scroll-up)
;    ("n" . '(lambda () (interactive) (scroll-up 1)))
;    ("p" . '(lambda () (interactive) (scroll-down 1)))
    ))

(defun define-many-keys (keymap key-table)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
	    cmd (cdr key-cmd))
      (define-key keymap key cmd)))
  keymap)

(defun view-mode-hook0 ()
  (define-many-keys view-mode-map pager-keybind)
  (hl-line-mode 1)
  (define-key view-mode-map " " 'scroll-up))
(add-hook 'view-mode-hook 'view-mode-hook0)

;(require 'key-chord)
;(setq key-chord-two-keys-delay 0.04)
;(key-chord-mode 1)
;(key-chord-define-global "fj" 'view-mode)

;;; elviewer
					;(require 'elviewer)


;;; End
(provide 'common)
;;; common.el ends here
