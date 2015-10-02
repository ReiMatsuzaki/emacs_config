;;; package -- Summary
;;; Commentary:
;
;  Minimal setting for Emacs. 
;
;
;;; Code:

;;; Basics
;;;; redo+

(when (require 'redo+ nil t)
  (define-key global-map (kbd "C-'") 'redo))

;;;; smartparens
(require 'smartparens-config)
(smartparens-global-mode t)

;;;; anzu
(require 'anzu)
(global-anzu-mode t)
(setq anzu-search-threshold 1000)
(setq anzu-minimum-input-length 3)
(global-set-key (kbd "C-c r") 'anzu-query-replace)
(global-set-key (kbd "C-c R") 'anzu-query-replace-regexp)

;;;; fold-dwim

(require 'fold-dwim)

(define-key global-map (kbd "C-c f") 'fold-dwim-toggle)
(define-key global-map (kbd "C-c q") 'fold-dwim-show-all)
(define-key global-map (kbd "C-c w") 'fold-dwim-hide-all)

;;;; neotree

(require 'neotree)
(global-set-key (kbd "M-[") 'neotree-show)
(global-set-key (kbd "M-]") 'neotree-hide)
(setq neo-create-file-auto-open t)
(setq neo-keymap-style 'concise)
(setq neo-smart-open t)
(setq neo-theme 'classic)

;;;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md'" . markdown-mode))

;;;; mutli-cursors/smartrep

(require 'multiple-cursors)
(require 'smartrep)

(global-set-key (kbd "C-c l") 'mc/edit-lines)
;(global-set-key (kbd "C-c r") 'mc/mark-all-in-region)

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
(global-set-key (kbd "C-c g") 'magit-status)


;;; EIN

(require 'ein)
;(define-key ein:notebook-python-mode-map [C-return] 'ein:worksheet-execute-cell)
;(define-key ein:notebook-python-mode-map [C-return] 'ein:worksheet-execute-cell)

;;; Elscreen
;;;; basic setting

(require 'elscreen)
(setq elscreen-prefix-key "\C-q")
(elscreen-start)
(setq elscreen-display-tab 5)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)

;;;; eshell utils

(defun eshell-current-elscreen-p (buf)
  (let ((regx (concat
	       "\\*eshell\\*<"
	       (number-to-string (elscreen-get-current-screen))
	       ".>")))
    (string-match regx (buffer-name buf))))


(defun eshell-number-for-this-elscreen (index)
  (+ (* 10 (elscreen-get-current-screen)) index))

(defun eshell-for-this-elscreen (arg)
  (interactive "p")
  (eshell (eshell-number-for-this-elscreen (/ arg 4))))

;;;; key bind

(global-set-key (kbd "C-c t") 'eshell-for-this-elscreen)
;(global-set-key (kbd "C-c t") 'eshell)


;;;; start

(add-hook 'after-init-hook
	  (lambda ()
	    (elscreen-screen-nickname "main")
	    (elscreen-create)
	    (elscreen-screen-nickname "www")
	    (elscreen-create)
	    (elscreen-screen-nickname "ein")
	    (elscreen-create)
	    (elscreen-screen-nickname "src1")
	    (elscreen-create)
	    (elscreen-screen-nickname "src2")
	    (elscreen-create)
	    (elscreen-screen-nickname "src3")
	    (elscreen-create)
	    (elscreen-screen-nickname "el")
	    (elscreen-create)
	    (elscreen-screen-nickname "note")
	    (elscreen-create)
	    (elscreen-screen-nickname "agnd")))


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
(setq org-hide-leading-stars t)

(defun org-fold-this-brunch ()
  (interactive)
  (outline-previous-visible-heading 1)
  (org-cycle))

(global-set-key (kbd "C-c a ") 'org-agenda)
(global-set-key (kbd "C-c m") 'org-capture)

(add-hook 'org-mode-hook
	  (lambda ()
	    (define-key org-mode-map (kbd "\C-c f") 'org-fold-this-brunch)
	    (define-key org-mode-map (kbd "\C-c e") 'org-edit-special)))

;;; elisp
; lispxmp (package)
; unit test package for emacs lisp 
; (require 'lispxmp)

; ert-expectation (package)
; unit test for emacs lisp
; This is not work correctory.
; (require 'ert-expectations)

; emacs lisp hook
(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()
	     (outline-minor-mode)
;	     (outshine-hook-function)
;	     (outshine-fold-to-level-1)
	     (turn-on-eldoc-mode)
	     (setq eldoc-idle-delay 0.2)
	     (setq eldoc-minor-mode-string "")
;	     (define-key emacs-lisp-mode-map (kbd "C-c x") 'lispxmp)
	     ))

;;; helm
;;;; require

(when (require 'helm-config nil t)
  (helm-mode 1))

;;;; key bind

(global-set-key (kbd "C-x C-f") 'find-file)

; (global-set-key (kbd "C-q") 'helm-mini)
;(global-set-key (kbd "C-c r") 'helm-recentf)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-x") 'helm-M-x)

;; ordinary completetion by TAB in helm-find-files
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

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

;;;; helm-swoop

;; setting for helm-swoop is written in gui.el

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
(yas/global-mode 1)
(define-key yas/minor-mode-map (kbd "C-c i") 'yas/insert-snippet)
(define-key yas/minor-mode-map (kbd "C-c n") 'yas/new-snippet)
(define-key yas/minor-mode-map (kbd "C-c v") 'yas/visit-snippet-file)

;;; web-mode

;(require 'web-mode)
;(add-to-list 'auto-mode-alist
;	     '("\\.html?$" . web-mode))

