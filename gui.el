;;;  IME      
;;;; Basic config

;; need emacs-mozc package which can be installed via apt-get
(when (locate-library "mozc")
  (progn
   (require 'mozc)
   (set-language-environment "japanese")
   (setq default-input-method "japanese-mozc")
;   (setq mozc-candidate-style 'overlay)
   (setq mozc-candidate-style 'echo-area)
   (define-key global-map "\C-o" 'toggle-input-method)))


;;;  Migemo

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


;;;; ace-isearch

(require 'ace-isearch)
(global-ace-isearch-mode t)

;;;; helm-swoop
(require 'helm-swoop)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)

;;;  org
;;;;; main

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

;;;;; ox-reveal

;; create reveal.js from org
;(load-library "ox-reveal")
;(setq org-reveal-mathjax t)

;;;;; export html when saving

(defun save-with-exporting-html ()
  (interactive)
  (basic-save-buffer)
  (org-html-export-to-html))

(defvar save-with-html-minor-mode-map
  (let ((kmap (make-sparse-keymap)))
    (define-key kmap (kbd "C-x C-s") 'save-with-exporting-html)
    kmap))

(define-minor-mode save-with-html-minor-mode
  "export html when save org file"
  :global nil)

;;;;; org -> tex

(require 'ox-latex)
(require 'org-bibtex)

; latex
; %f : complete file name
; %b : file name removed its extention
; %o : output directory
(setq org-latex-pdf-process
      '("platex %f"
	"platex %f"
	"bibtex %b"
	"platex %f"
	"platex %f"
	"dvipdfmx %b.dvi"))

(add-to-list 'org-latex-classes
	     '("thesis"
	       "\\documentclass{jarticle}
	       [NO-PACKAGES]
	       [NO-DEFAULT_PACKAGES]
\\usepackage[dvipdfmx]{graphicx}"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))


