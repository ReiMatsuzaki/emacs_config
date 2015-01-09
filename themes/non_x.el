;;;; default font size
(setq my-default-font-height 80)


;;;; elscreen

(set-face-background 'elscreen-tab-other-screen-face "white")
(set-face-foreground 'elscreen-tab-other-screen-face "Black")

(set-face-background 'elscreen-tab-current-screen-face "Red")
(set-face-foreground 'elscreen-tab-current-screen-face "White")

(set-face-background 'elscreen-tab-background-face "black")

(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)


;;;; mode line

(set-face-attribute 'mode-line-inactive nil
                    :foreground "black"
                    :background "white"
		    :box nil)

(set-face-attribute 'mode-line nil
                    :foreground "white"
                    :background "red"
		    :box nil
                    )

(set-face-attribute 'mode-line-buffer-id nil
		    :foreground "Black"
                    :background "white"
                    )

;;;; eshell

(setq eshell-prompt-function
      (lambda ()
	(concat
	 (user-login-name)
	 "@" (substring (system-name) 0 6) 
	 "[" 
	 (if (string-match "/home/matsuzak" (eshell/pwd))
	     (concat "~" (substring (eshell/pwd) 14))
	   (eshell/pwd))
	 "] \n$ ")))


(defun system-name-for-yablab ()
  (substring (system-name) 0 6))
(defun i-current-direcotry-name()
  (concat "["
	  (if (string-match "/home/matsuzak" (eshell/pwd))
	      (concat "~" (substring (eshell/pwd) 14)))
	  "]"))

(setq eshell-prompt-function
      (lambda ()
	(concat
	 (with-face (system-name-for-yablab)
		    :foreground "magenta")
	 (with-face (git-prompt)
		    :foreground "green")
	 (with-face (i-current-direcotry-name) 
		    :foreground "yellow")
	 "\n$ ")))

(setq eshell-prompt-function
      (lambda ()
	(concat
	 (with-face (system-name-for-yablab)
		    :foreground "magenta")
	 (with-face (i-current-direcotry-name) 
		    :foreground "yellow")
	 "\n$ ")))


(setq eshell-highlight-prompt nil)

(setq eshell-prompt-regexp "^[$#] ")


;;;; outshine

(set-face-attribute 'outshine-level-1 nil
		    :foreground "white"
		    :background "color-166"
		    :underline nil)
(set-face-attribute 'outshine-level-2 nil
                    :foreground "brightred"
		    :underline t)
(set-face-attribute 'outshine-level-3 nil
		    :foreground "white"
		    :underline t)

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

