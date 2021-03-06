;; dark color setting

;; use color-theme as basic color configuration
(color-theme-initialize)
(color-theme-gnome2)

;; default font size
(setq my-default-font-height 80)


;; doc
(set-face-attribute 'font-lock-doc-face nil
		    :foreground "white"
		    :background nil)

;; code face in literate programming 
(make-face 'face-literate-program-code)
(set-face-background 'face-literate-program-code "gray")

;; sectioninng 
(setq my-sect-color-1 "blue4")
(setq my-sect-color-2 "chocolate")
(setq my-sect-color-3 "slate gray")

(make-face 'face-sectioning)
;;(set-face-background 'face-sectioning "midnight blue")
(set-face-background 'face-sectioning "cadet blue")
(set-face-foreground 'face-sectioning "white")
(set-face-underline-p 'face-sectioning nil)

;; cursor
(setq my-ime-active-color "red")
(setq my-ime-inactive-color "dodger blue")

;; pale color
(make-face 'my-face-pale)
(set-face-foreground 'my-face-pale "gray")

;; tab or etc
(setq my-color-tab-other-background "LightSkyBlue4")
(setq my-color-tab-other-foreground "white")
(setq my-color-tab-current-background "LightSkyBlue4")
(setq my-color-tab-current-foreground "red")
(setq my-color-back "azure4")

;; main-line
(setq my-main-line-color-1 "LightSkyBlue4")
;;(setq my-main-line-color-2 "#cdaa7d")
(setq my-main-line-color-2 "azure4")

;; error check
(make-face 'my-face-error-check-error)
(set-face-background 'my-face-error-check-error "pink")

(make-face 'my-face-error-check-warn)
(set-face-background 'my-face-error-check-warn "yellow")

