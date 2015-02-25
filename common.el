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


;;;; perspective 

(require 'perspective)
(persp-mode 1)

(global-set-key (kbd "C-c n")   'persp-next)
(global-set-key (kbd "C-c C-n") 'persp-next)
(global-set-key (kbd "C-c p")   'persp-prev)
(global-set-key (kbd "C-c C-p") 'persp-prev)
(global-set-key (kbd "C-c s")   'persp-switch)
;;;; Git

(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)

;;;; fold-dwim

(require 'fold-dwim)

(define-key global-map (kbd "C-c f") 'fold-dwim-toggle)
(define-key global-map (kbd "C-c q") 'fold-dwim-show-all)
(define-key global-map (kbd "C-c w") 'fold-dwim-hide-all)

;;;; outshine

(require 'outshine)
(defun outshine-fold-to-level-1  ()
  (interactive)
  (beginning-of-line)
  (while (not (eobp))
    (outline-hide-more)
    (forward-line 1)))

;;;; org
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

(setq org-capture-templates
      '(("t" "Task" entry 
	 (file+headline (expand-file-name (concat org-directory "/task.org")) "Task")
	 "* TODO %?\n   %T")
	("m" "Memo" entry 
	 (file+headline (expand-file-name (concat org-directory "/task.org")) "Memo")
	 "* %?\n    %i    %T")))

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)" "CALCEL(c)")))

(setq org-tag-alist '(("@LAB" . ?l) ("@HOME" . ?h) 
		      ("THINKING" . ?t) ("COMPUTER" . ?c) ("READ" . ?r) ("WRITE" . ?w)))

(setq org-log-done 'time)


;;;;; org-habit

(require 'org-habit)


;;;;; org-babel

; syntax high lighting in source blocks
(setq org-src-fontify-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t )
   (python . t)
   (ruby . t)))



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
	     (turn-on-eldoc-mode)
	     (setq eldoc-idle-delay 0.2)
	     (setq eldoc-minor-mode-string "")
	     (define-key emacs-lisp-mode-map (kbd "C-c x") 'lispxmp)))



;;;; helm
;;;;; require

(when (require 'helm-config nil t)
  (helm-mode 1))
(require 'helm-descbinds)
;(require 'helm-c-moccur)

;;;;; key bind

(global-set-key (kbd "C-x C-f") 'find-file)

(global-set-key (kbd "C-q") 'helm-mini)
(global-set-key (kbd "C-c r") 'helm-recentf)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-x") 'helm-M-x)

;; ordinary completetion by TAB in helm-find-files
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

;;;;; configure regular expression search
; this code is copied from the web site
; d.hatena.ne.jp/a_bicky/20140104/1388822688

(defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
  "Transform the pattern to reflect my intention"
  (let* ((pattern (ad-get-arg 0))
	 (input-pattern (file-name-nondirectory pattern))
	 (dirname (file-name-directory pattern)))
    (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
    (setq ad-return-value
	  (concat dirname
		  (if (string-match "\\^" input-pattern)
		      (substring input-pattern 1)
		    (concat ".*" input-pattern))))))

;;;;; helm-migemo
; rubikichi.com/2014/12/9/helm-migemo/
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
       source)))


;;;;; next/previout matching
; rubikichi.com/2014/11/27/helm-next-error

;; resumable helm/anything buffers
(defvar helm-resume-goto-buffer-regexp
  (rx (or (regexp "Helm Swoop") "helm imenu" (regexp "helm.+grep") "helm-ag"
          "occur"
          "*anything grep" "anything current buffer")))
(defvar helm-resume-goto-function nil)
(defun helm-initialize--resume-goto (resume &rest _)
  (when (and (not (eq resume 'noresume))
             (ignore-errors
               (string-match helm-resume-goto-buffer-regexp helm-last-buffer)))
    (setq helm-resume-goto-function
          (list 'helm-resume helm-last-buffer))))
(advice-add 'helm-initialize :after 'helm-initialize--resume-goto)
(defun anything-initialize--resume-goto (resume &rest _)
  (when (and (not (eq resume 'noresume))
             (ignore-errors
               (string-match helm-resume-goto-buffer-regexp anything-last-buffer)))
    (setq helm-resume-goto-function
          (list 'anything-resume anything-last-buffer))))
(advice-add 'anything-initialize :after 'anything-initialize--resume-goto)

;; next-error/previous-error
(defun compilation-start--resume-goto (&rest _)
  (setq helm-resume-goto-function 'next-error))
(advice-add 'compilation-start :after 'compilation-start--resume-goto)
(advice-add 'occur-mode :after 'compilation-start--resume-goto)
(advice-add 'occur-mode-goto-occurrence :after 'compilation-start--resume-goto)
(advice-add 'compile-goto-error :after 'compilation-start--resume-goto)


(defun helm-resume-and- (key)
  (unless (eq helm-resume-goto-function 'next-error)
    (if (fboundp 'helm-anything-resume)
        (setq helm-anything-resume-function helm-resume-goto-function)
      (setq helm-last-buffer (cadr helm-resume-goto-function)))
    (execute-kbd-macro
     (kbd (format "%s %s RET"
                  (key-description (car (where-is-internal
                                         (if (fboundp 'helm-anything-resume)
                                             'helm-anything-resume
                                           'helm-resume))))
                  key)))
    (message "Resuming %s" (cadr helm-resume-goto-function))
    t))
(defun helm-resume-and-previous ()
  "Relacement of `previous-error'"
  (interactive)
  (or (helm-resume-and- "C-p")
      (call-interactively 'previous-error)))
(defun helm-resume-and-next ()
  "Relacement of `next-error'"
  (interactive)
  (or (helm-resume-and- "C-n")
      (call-interactively 'next-error)))

;; Replace: next-error / previous-error
(require 'helm-config)
(ignore-errors (helm-anything-set-keys))
(global-set-key (kbd "M-n") 'helm-resume-and-next)
(global-set-key (kbd "M-p") 'helm-resume-and-previous)


;;;; auto-complete

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



;;;; yasnippet

(require 'yasnippet)
(yas-global-mode 1)

;; new snippet
(define-key yas-minor-mode-map (kbd "C-c y")
  'yas-new-snippet)




