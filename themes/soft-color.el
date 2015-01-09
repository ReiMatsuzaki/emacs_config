;; == soft color setting ==
;;;; basic

;; use color-theme
(color-theme-initialize)
(color-theme-infodoc)

;; default font size
(setq my-default-font-height 80)

;;;; elscreen

(set-face-background 'elscreen-tab-other-screen-face "tan3")
(set-face-foreground 'elscreen-tab-other-screen-face "white")
(set-face-background 'elscreen-tab-current-screen-face "wheat")
(set-face-foreground 'elscreen-tab-current-screen-face "dark red")

(set-face-background 'elscreen-tab-background-face "burlywood3")

(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)

;;;; mode line
;;;;; mode line

(set-face-attribute 'mode-line-inactive nil
                    :foreground "black"
                    :background "peru"
		    :box nil)

(set-face-attribute 'mode-line nil
                    :foreground "black"
                    :background "peru"
		    :box nil
                    )

(set-face-attribute 'mode-line-buffer-id nil
		    :foreground "black"
                    :background "peru"
                    )
;;;;; main line

; peru #cd853f

(require 'main-line)
(setq main-line-color2 "#cd853f")
(setq main-line-color1 "#cdaa7d")
(setq main-line-separator-style 'wave)


;;;; hiwin(require)

; (require 'hiwin)
; (hiwin-activate)
; (set-face-background 'hiwin-face "burlywood1")

;;;; eshell

(setq eshell-prompt-function
      (lambda ()
	(concat
	 (with-face (system-name-for-yablab)
		    :foreground "magenta")
	 (with-face (i-current-direcotry-name) 
		    :foreground "yellow")
	 "\n$ ")))

(setq eshell-prompt-function
      (lambda ()
	(concat
	 (with-face (git-prompt)
		    :foreground "dark green"
		    :bold t)
	 "["
	 (with-face (eshell/pwd)
		    :foreground "dark red")
	 "]"
	 "\n$ ")))


(setq eshell-highlight-prompt nil)

(setq eshell-prompt-regexp "^[$#] ")


;;;; section face
;;;;; outhine

(set-face-attribute 'outshine-level-1 nil
		    :foreground "white"
		    :background "darkorange2"
		    :height 130
		    :underline nil)

(set-face-attribute 'outshine-level-2 nil
                    :foreground "chocolate"
		    :underline t)
(set-face-attribute 'outshine-level-3 nil
		    :foreground "dim gray"
		    :underline nil)

;;;;; latex

(add-hook 'TeX-mode-hook
	  '(lambda ()
	     (set-face-attribute 
	      'font-latex-sectioning-2-face nil
	      :foreground "blue"
	      :background nil
	      :underline nil)
	     (set-face-attribute 
	      'font-latex-sectioning-3-face nil
	      :foreground "chocolate"
	      :underline nil)
	     (set-face-attribute 
	      'font-latex-sectioning-4-face nil
	      :foreground "dim gray"
	      :underline t)))


;;;; ime

(add-hook 'input-method-activate-hook
	  (lambda() (set-cursor-color "dark green")))
(add-hook 'input-method-inactivate-hook
	  (lambda() (set-cursor-color "red")))


;;;; old
;
; main-line
;(setq my-main-line-color-1 "#cd853f")
;(setq my-main-line-color-2 "#cdaa7d")
;
;
;
; doc
;(set-face-attribute 'font-lock-doc-face nil
;		    :foreground "black"
;		    :background nil)
;
; code face in literate programming 
;(make-face 'face-literate-program-code)
;(set-face-background 'face-literate-program-code "snow")
;
; sectioninng 
;(setq my-sect-color-1 "blue4")
;(setq my-sect-color-2 "chocolate")
;(setq my-sect-color-3 "dark orchid")
;
;(make-face 'face-sectioning)
;(set-face-background 'face-sectioning "darkorange2")
;(set-face-foreground 'face-sectioning "white")
;(set-face-underline-p 'face-sectioning nil)
;
; cursor
;(setq my-ime-active-color "red")
;(setq my-ime-inactive-color "blue")
;
; pale color
;(make-face 'my-face-pale)
;(set-face-foreground 'my-face-pale "gray")
;
; tab or etc
;(setq my-color-tab-other-background "tan3")
;(setq my-color-tab-other-foreground "white")
;(setq my-color-tab-current-background "wheat")
;(setq my-color-tab-current-foreground "dark red")
;(setq my-color-back "burlywood3")
;
; main-line
;(setq my-main-line-color-1 "#cd853f")
;(setq my-main-line-color-2 "#cdaa7d")
;
; error check
;(make-face 'my-face-error-check-error)
;(set-face-background 'my-face-error-check-error "pink")
;
;(make-face 'my-face-error-check-warn)
;(set-face-background 'my-face-error-check-warn "yellow")
;
;
;	   
