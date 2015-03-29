;;;; comment

;; this setting is for xterm-256 color
;; before loading this file, setq my-color as one of (blue, green, red, gray)

;;;; basic

(set-face-background 'region "gray10")
(set-face-attribute 'isearch-lazy-highlight-face nil
                    :foreground "black"
                    :background "yellow"
		    :box nil)
(set-face-attribute 'isearch nil
                    :foreground "black"
                    :background "magenta"
		    :box nil)

(set-face-attribute 'minibuffer-prompt nil
		    :foreground "cyan")

;(defface hlline-face
;  '((((class color)
;      (background dark))
;    (:background "gray10"))
;    (((class color)
;      (background light))
;     (:background "gray10"))
;    (t
;     ()))
; "*Face used by hl-line.")

;(setq hl-line-face 'hlline-face)
;(global-hl-line-mode)



;;;; my-color



(setq my-blue-light "color-87")
(setq my-blue-dark "color-26")

(setq my-green-light "color-83")
(setq my-green-dark "color-22")

(setq my-orange-dark "color-130")
(setq my-orange-light "color-223")

(setq my-gray-dark "color-239")
(setq my-gray-light "color-253")

(setq my-red-dark "color-124")
(setq my-red-light "color-218")


(cond ((not (boundp 'my-color))
       (setq my-light my-gray-light)
       (setq my-dark  my-gray-dark))
      ((equal my-color "gray")
       (setq my-light my-gray-light)
       (setq my-dark  my-gray-dark))
      ((equal my-color "red")
       (setq my-light my-red-light)
       (setq my-dark  my-red-dark))      
      ((equal my-color "blue")
       (setq my-light my-blue-light)
       (setq my-dark  my-blue-dark))
      ((equal my-color "orange")
       (setq my-light my-orange-light)
       (setq my-dark  my-orange-dark))
      ((equal my-color "green")
       (setq my-light my-green-light)
       (setq my-dark  my-green-dark)))


;;;; elscreen

(set-face-attribute 'elscreen-tab-other-screen-face nil
		    :background my-light
		    :foreground my-dark
		    :underline nil)

(set-face-attribute 'elscreen-tab-current-screen-face nil
		    :background my-dark
		    :foreground my-light
		    :underline nil)

(set-face-background 'elscreen-tab-background-face "black")

(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)


;;;; mode line

;(set-face-attribute 'mode-line-inactive nil
;                    :foreground "black"
;                    :background "white"
;		    :box nil)


(set-face-attribute 'mode-line-inactive nil
                    :foreground my-dark
                    :background my-light
		    :box nil)

(set-face-attribute 'mode-line nil
                    :foreground my-light
                    :background my-dark
		    :box nil
                    )

(set-face-attribute 'mode-line-buffer-id nil
		    :foreground nil
                    :background nil
                    )




;;;; eshell
;;;;; prompt


(defun system-name-for-yablab ()
  (substring (system-name) 0 6))

(setq eshell-prompt-function
      (lambda ()
	(concat
	 (with-face (system-name-for-yablab)
		    :background my-dark
		    :foreground my-light)
	 "<<"
	 (with-face (eshell/pwd)
		    :foreground my-light)
	 ">>"
	 "\n$ ")))

(setq eshell-highlight-prompt nil)
(setq eshell-prompt-regexp "^[$#] ")


;;;;; font

(add-hook 'eshell-mode-hook
	  '(lambda ()
	     (set-face-foreground 'eshell-ls-directory "cyan")
	     (set-face-foreground 'eshell-ls-executable "orange")
	     (set-face-foreground 'eshell-ls-symlink "lightgreen")))


;;;; outshine


(set-face-attribute 'outshine-level-1 nil
		    :foreground my-dark
		    :background my-light
		    :underline nil)
(set-face-attribute 'outshine-level-2 nil
                    :foreground my-light
		    :background nil
		    :underline t)
(set-face-attribute 'outshine-level-3 nil
		    :foreground my-gray-light
		    :underline t)


;;;; font-lock


(set-face-foreground 'font-lock-string-face "color-172")  ;; color-172 is orange similar

(set-face-foreground 'font-lock-keyword-face "yellow")
(set-face-foreground 'font-lock-builtin-face "yellow")
(set-face-foreground 'font-lock-constant-face "purple")

(set-face-foreground 'font-lock-comment-face my-light)
(set-face-foreground 'font-lock-warning-face "red")


(set-face-foreground 'font-lock-function-name-face "color-159")
(set-face-foreground 'font-lock-variable-name-face "cyan")
(set-face-foreground 'font-lock-type-face "magenta")
		    
;;;; old

;; doc
(set-face-attribute 'font-lock-doc-face nil
		    :foreground "white"
		    :background nil)

;; code face in literate programming 
(make-face 'face-literate-program-code)
(set-face-background 'face-literate-program-code "gray")

;; sectioninng 
(setq my-sect-color-1 "cyan")
(setq my-sect-color-2 "purple")
(setq my-sect-color-3 "gray40")

(make-face 'face-sectioning)
;;(set-face-background 'face-sectioning "midnight blue")
(set-face-background 'face-sectioning "blue")
(set-face-foreground 'face-sectioning "white")
(set-face-underline-p 'face-sectioning nil)

;; cursor
(setq my-ime-active-color "white")
(setq my-ime-inactive-color "blue")

;; pale color
(make-face 'my-face-pale)
(set-face-foreground 'my-face-pale "gray")

;; main-line
(setq my-main-line-color-1 "LightSkyBlue4")
;;(setq my-main-line-color-2 "#cdaa7d")
(setq my-main-line-color-2 "azure4")

;; error check
(make-face 'my-face-error-check-error)
(set-face-background 'my-face-error-check-error "pink")

(make-face 'my-face-error-check-warn)
(set-face-background 'my-face-error-check-warn "yellow")

