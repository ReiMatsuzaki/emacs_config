;;; package -- Summary
;;; Commentary:
;
;  Minimal setting for Emacs. 
;
;
;;;  Control    
;;;; compile
;;;;; key

(setq my-packages
      '(;flycheck
	auto-complete
	ggtags
	key-chord
	auctex
	flycheck
;	outline-magic
	))

(require 'cl)
(mapcar (lambda (x)
	  (when (not (package-installed-p x))
	    (package-install x)))
	my-packages)


;(global-set-key "\C-cc" 'compile)

;(require 'smart-compile)
;(global-set-key (kbd "C-c c") 'smart-compile)



;(global-set-key "\C-ck" 'mode-compile-kill)


;;;;; font-lock for compilation mode

;(add-hook 'compilation-mode-hook
;	  '(lambda ()	     
;	     (progn
;	       (add-to-list 
;		'compilation-mode-font-lock-keywords
;		'("\\(^ *\\[.*\\]\\)" (1 font-lock-keyword-face)))
;	       (add-to-list 
;		'compilation-mode-font-lock-keywords
;		'("\\(^ *\\[ *FAILED *\\]\\)" (1 compilation-error-face))))))

(add-hook
 'compilation-mode-hook
 '(lambda ()
    (setq compilation-mode-font-lock-keywords
	  '((compilation--ensure-parse)
	    ("\\(^ *\\[ *FAILED *\\]\\)" (1 compilation-error-face))
	    ("\\(^ *\\[.*\\]\\)" (1 font-lock-function-name-face))
	    ("^[Cc]hecking \\(?:[Ff]or \\|[Ii]f \\|[Ww]hether \\(?:to \\)?\\)?\\(.+\\)\\.\\.\\. *\\(?:(cached) *\\)?\\(\\(yes\\(?: .+\\)?\\)\\|no\\|\\(.*\\)\\)$" (1 font-lock-variable-name-face) (2 (compilation-face ...)))
	    ("^\\([[:alnum:]_/.+-]+\\)\\(\\[\\([0-9]+\\)\\]\\)?[ 	]*:" (1 font-lock-keyword-face) (3 compilation-line-face nil t))
	    (" --?o\\(?:utfile\\|utput\\)?[= ]\\(\\S +\\)" . 1)
	    ("^Compilation \\(finished\\).*" (0 (quote ...) t) (1 compilation-info-face))
	    ("^Compilation \\(exited abnormally\\|interrupt\\|killed\\|terminated\\|segmentation fault\\)\\(?:.*with code \\([0-9]+\\)\\)?.*" (0 (quote ...) t) (1 compilation-error-face) (2 compilation-error-face nil t))))))

;;;; GAMESS mode

(define-derived-mode gamess-mode text-mode
  "GAMESS"
  "editing GAMESS input mode"
  (setq gamess-font-lock-keywords
	'(("^ *!.*$" . font-lock-comment-face)
	  ("[A-Za-z0-9_]+=" . font-lock-keyword-face)
	  (" \\$[A-Za-z0-9_]+" . font-lock-variable-name-face)))
  (setq font-lock-defaults '(gamess-font-lock-keywords)))
(add-to-list 'auto-mode-alist '("\\.inp\\'" . gamess-mode))


;;;; flycheck
;(require 'flycheck)
;(global-flycheck-mode)
;(add-hook 'after-init-hook #'global-flycheck-mode)
;(require 'flymake)
;(set-face-background 'flymake-warnline "yello")

;;;  Programming 
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
;	    (define-key ruby-mode-map (kbd "C-c d") 'credmp/flymake-display-err-minibuf)
	    (hs-hide-all)
	    ))

;;;;; flymake

;flymake-ruby(package)
;(require 'flymake-ruby)
;(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;(defun credmp/flymake-display-err-minibuf ()
;  "Displays the error/warning for the current line in the minibuffer"
;  (interactive)
;  (let* ((line-no             (flymake-current-line-no))
;         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;         (count               (length line-err-info-list))
;         )
;    (while (> count 0)
;      (when line-err-info-list
;        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;          (message "[%s] %s" line text)
;          )
;        )
;      (setq count (1- count)))))

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

;;;; Haskell

;(require 'haskell-mode)
;(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
;(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))
;(autoload 'ghc-init "ghc" nil t)
;(autoload 'ghc-debug "ghc" nil t)
;(add-hook 'haskell-mode-hook
;	  (lambda () 
;	    (turn-on-haskell-indentation)
;	    (turn-on-haskell-doc-mode)
;	    (ghc-init)
;	    (haskell-indent-mode)))


;;;; python

;(require 'jedi)
;(setq jedi:complete-dot t)

;; Add support for HideShow
(defcustom py-hide-show-keywords '("def")
  "*Keywords used by hide-show"
  :type '(repeat string)
  :group 'python)

(defcustom py-hide-show-hide-docstrings t
  "*If doc strings shall be hidden"
  :type 'boolean
  :group 'python)

(add-to-list 'hs-special-modes-alist (list
				      'python-mode (concat (if py-hide-show-hide-docstrings "^\\s-*\"\"\"\\|" "") (mapconcat 'identity (mapcar #'(lambda (x) (concat "^\\s-*" x "\\>")) py-hide-show-keywords ) "\\|")) nil "#"
				      (lambda (arg)
					(py-goto-beyond-block)
					(skip-chars-backward " \t\n"))
				                   nil))

;(add-hook 'python-mode-hook
;	  '(lambda()
;	     ;(hs-minor-mode t)
;	     (hs-hide-all)))

;; outline mode
;(require 'outline-magic)
(defun py-outline-level-old ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "    ")
      (current-column))))
(defun py-outline-level ()
  (interactive)
  (let ((str nil))
    (looking-at outline-regexp)
    (setq str (buffer-substring-no-properties 
	       (match-beginning 0) (match-end 0)))
    (cond 
     ((string-match "class" str) 1)
     ((string-match "class" str) 2)
     (t (+ 6 (length str))))))

(defun my-python-outline-hook ()
  ;(setq outline-regexp "[ \t]*# \\|[ \t]+\\(class\\|def\\) ")
  (setq outline-regexp "[ \t]*\\(class\\|def\\) ")
  (setq outline-level 'py-outline-level)
  (outline-minor-mode t)
  (hide-body)
  (show-paren-mode 1)
  )


(add-hook 'python-mode-hook 'my-python-outline-hook)


;;;; wolfram


(add-to-list 'load-path (expand-file-name (concat config-home "packages/wolfram-mode-master/")))
(autoload 'wolfram-mode "wolfram-mode" nil t)
(autoload 'run-wolfram "wolfram-mode"  nil t)
(setq wolfram-program "/usr/local/bin/MathKernel")
(add-to-list 'auto-mode-alist '("\\.m$" . wolfram-mode))

(defun wolfram-insert-comment ()
  (interactive)
  (insert "(* *)")
  (backward-char)
  (backward-char))


(add-hook 'wolfram-mode-hook
	  '(lambda()
	     (outline-minor-mode)
	     (outshine-hook-function)
	     (define-key wolfram-mode-map (kbd "C-c ;") 
	       'wolfram-insert-comment)
	     (linum-mode t)))

;;;; fortran
(add-hook 'fortran-mode-hook
	  '(lambda()
	     (hs-minor-mode 1)))
(add-to-list 'auto-mode-alist '("\\.src\\'" . fortran-mode))

;;;; fortran 90/95
;;;;; hideshow
; to be removed
(defun hs-hide-function-or-subroutine ()
  (interactive)
  (end-of-line)
  (if (re-search-backward "^ *\\(subroutine\\|recursive\\|function\\|type\\)" nil t)
      (progn (end-of-line)
	     (hs-toggle-hiding))))
; to be removed
(defun hs-hide-whole-function-and-subroutine ()
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "^ *\\(recursive\\|subroutine\\|function\\|type\\)" nil t)
    (beginning-of-line)    
    (hs-hide-block)
    (forward-line 1)
    (beginning-of-line)))

;;;;; keybind
(add-hook 'f90-mode-hook
	  '(lambda()
	     (hs-minor-mode 1)
	     (flycheck-mode 1)
	     (flycheck-define-checker fortran-gfortran
  "An Fortran syntax checker using GCC.

Uses GCC's Fortran compiler gfortran.  See URL
`https://gcc.gnu.org/onlinedocs/gfortran/'."
  :command ("gfortran"
            "-cpp"
	    "-ffree-line-length-512"
            "-fsyntax-only"
            "-fshow-column"
            "-fno-diagnostics-show-caret" ; Do not visually indicate the source location
            "-fno-diagnostics-show-option" ; Do not show the corresponding
                                        ; warning group
            ;; Fortran has similar include processing as C/C++
            "-iquote" (eval (flycheck-c/c++-quoted-include-directory))
;            (option "-std=" flycheck-gfortran-language-standard concat)
            (option "-f" flycheck-gfortran-layout concat
                    flycheck-option-gfortran-layout)
            (option-list "-W" flycheck-gfortran-warnings concat)
            (option-list "-I" flycheck-gfortran-include-path concat)
            (eval flycheck-gfortran-args)
            source)
  :error-patterns
  ((error line-start (file-name) ":" line (or ":" ".") column (or ": " ":\n")
          (or (= 3 (zero-or-more not-newline) "\n") "")
          (or "Error" "Fatal Error") ": "
          (message) line-end)
   (warning line-start (file-name) ":" line (or ":" ".") column (or ": " ":\n")
            (or (= 3 (zero-or-more not-newline) "\n") "")
            "Warning: " (message) line-end))
  :modes (fortran-mode f90-mode))
;	     (setq flycheck-gfortran-language-standard "")
	     (rplacd (assoc
		      'f90-mode hs-special-modes-alist)
		     `(
		       ,(rx (or "function" "subroutine" "recursive" "program"))
		       ,(rx (or "end"))
		       ,(rx (or "!"))
		       f90-end-of-block))
	     ))

;; see https://coderwall.com/p/u-l0ra/ruby-code-folding-in-emacs
;(eval-after-load "hideshow"  
;  '(add-to-list 'hs-special-modes-alist
;		`(f90-mode
;		  ,(rx (or "function" "subroutine" "recursive" "type"))
;		  ,(rx (or "end"))
;		  ,(rx (or "!"))
					;		  f90-end-of-block)))
;(eval-after-load "hideshow"
;  (rplacd (assoc
;	   'f90-mode hs-special-modes-alist)
;	  `(
;	    (rx (or "function" "subroutine" "recursive" "type"))
;	    ,(rx (or "end"))
;	    ,(rx (or "!"))
;	    f90-end-of-block)))
(setq auto-mode-alist
      (cons (cons "\\.f95$" 'f90-mode) auto-mode-alist))


;;;; scala
;(require 'scala-mode2)
;(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))


;;;; elisp
(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()

;	     (outline-minor-mode)
;	     (outshine-hook-function)
;	     (outshine-fold-to-level-1)
;	     (turn-on-eldoc-mode)
;	     (setq eldoc-idle-delay 0.2)
;	     (setq eldoc-minor-mode-string "")
;	     (define-key emacs-lisp-mode-map (kbd "C-c x") 'lispxmp)
	     ))


;;;; c/c++
;;;;; refactoring

;(require 'srefactor)

;(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)

;;;;; flymake

;(require 'flymake)

;(add-hook 'c-mode-common-hook
;          '(lambda ()
;             (flymake-mode t)))

;(defun flymake-cc-init ()
;  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;                       'flymake-create-temp-inplace))
;         (local-file  (file-relative-name
;                       temp-file
;                       (file-name-directory buffer-file-name))))
;    (list "g++" (list "-std=c++11" "-Wall" "-Wextra" "-fsyntax-only" local-file))))

;(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

;;;;; fly check

;(setq flycheck-clang-args )
;(require 'flycheck)

;(defun init-flycheck-for-c ()
;   (setq flycheck-clang-include-path
;	 (list
;	  (expand-file-name "/System/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7/")
;	  (expand-file-name "~/src/git/rescol/include")
;           (expand-file-name "~/local/src/petsc-3.6.1/include")
;           (expand-file-name "~/local/src/slepc-3.6.1/include")
;           (expand-file-name "~/local/src/petsc-3.6.1/")
;           (expand-file-name "~/local/src/petsc-3.6.1/complex/include")
;           (expand-file-name "~/local/src/slepc-3.6.1/complex/include")

;)))


;(flycheck-define-checker c/c++
;  "A C/C++ checker using g++"
;  :command ("g++" "-Wall" "-Wextra" "-std=c++11" source)
;  :error-patterns ((error line-start
;			  (file-name) ":" line ":" column ":" " Error:" (message) line-end)
;		   (warning line-start
;			    (file-name) ":" line ":" "Warning" (message) line-end))
;  :modes (c-mode c++-mode))

;;;;; color control


;(defun my-cplus-color ()
;  (interactive)
;  (add-face-to-rexp-area "^ *// +\\* .*\n" 'face-sectioning)
 ;; (add-face-to-rexp-area "^ *//> .*$\\(.*\n\\)*^//<.*$" 'face-literate-program-code)

;;;;; section

;(defun my-cplus-insert-outsine-section ()
;  (interactive)
;  (beginning-of-line)
;  (insert "// \*"))

;;;;; hide for c++

(defun hs-hide-under (re f)
  "hide under sentence represented by regular expression re"
  (goto-char (point-min))
  (while (re-search-forward re nil t)
    (progn
      (hs-show-block)
      (next-line)
      (funcall f))))

(defun hs-hide-for-c++  ()
  (interactive)
  "hide functions under namespace for c++ code"
  (let ((hide-1 (lambda () (hs-hide-level 1)))
	(current-point (point)))
    (hs-hide-under "namespace +{" 'hs-hide-block)
    (hs-hide-under "namespace +.+ *{" hide-1)
    (hs-hide-under "class +.+ *{" hide-1)
    (goto-char current-point)))

;;;;; config

;(require 'auto-complete-c-headers)
;(require 'auto-complete-clang-async)
;(require 'ggtags)

(add-hook 'c++-mode-hook
	  (lambda ()
	    (hs-minor-mode)
	    (define-key c++-mode-map (kbd "C-o C-l") 'hs-hide-level)
;	    (c-set-offset 'innamespace 0)
	    (c-set-offset 'inextern-lang 0)
;	    (hs-hide-for-c++)
;            (flycheck-mode t)
;            (init-flycheck-for-c)
					;            (setq ac-sources (append ac-sources '(ac-source-c-headers)))
	    (define-key c++-mode-map (kbd "C-o C-l") 'hs-hide-level)
	    (linum-mode t)))

(add-hook 'c-mode-hook
	  (lambda ()
;            (flycheck-mode t)
;            (flycheck-select-checker 'c/c++-clang)
					;            (init-flycheck-for-c)
	    (define-key c++-mode-map (kbd "C-o C-l") 'hs-hide-level)
	    (hs-minor-mode)
	    (c-set-offset 'inextern-lang 0)
 ;           (ggtags-mode 1)
;            (setq ac-sources (append ac-sources '(ac-source-c-headers)))
	    (linum-mode)))

;;;;; auto insert

(define-auto-insert "\\.cpp" "cpp_template.cpp")
(define-auto-insert "\\.h" "h_template.h")


;;;; gnuplot
;(require 'gnuplot-mode)

;; ;; specify the gnuplot executable (if other than /usr/bin/gnuplot)
;; (setq gnuplot-program "/sw/bin/gnuplot")

;; ;; automatically open files ending with .gp or .gnuplot in gnuplot mode
; (add-to-list 'auto-mode-alist
;              '("\\.\\(gp\\|gnuplot\\)$" . gnuplot-mode) t)

;  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
;  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot-mode" t)
;  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode))
;			           auto-mode-alist))

;auto insert
;(defun insert-gp-template ()
;  (interactive)
;  (yas/expand-snippet
;  "set term postscript eps enhanced color
;   set output '`(file-name-nondirectory (file-name-sans-extension (buffer-file-name)))`.eps'
;   set size 0.5,0.5
;   set grid
;   set key right
;   $0
;"
;  (point) (point)
;  ))
;(define-auto-insert "\\.gp$" 'insert-gp-template)


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
;(load "tex-site")
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
    (define-key TeX-mode-map (kbd "C-c w") 'TeX-fold-buffer)
    (define-key TeX-mode-map (kbd "C-c f") 'TeX-fold-dwim)
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
	     (add-to-list 'LaTeX-fold-math-spec-list '("¢å({1})" ("sqrt")))	     
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




