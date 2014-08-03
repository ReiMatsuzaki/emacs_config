;; soft color setting 

;; use color-theme
(color-theme-initialize)
(color-theme-infodoc)

;; doc
(set-face-attribute 'font-lock-doc-face nil
		    :foreground "black"
		    :background nil)

;; code face in literate programming 
(make-face 'face-literate-program-code)
(set-face-background 'face-literate-program-code "snow")

;; sectioninng 
(setq my-sect-color-1 "blue4")
(setq my-sect-color-2 "chocolate")
(setq my-sect-color-3 "dark orchid")

;; cursor
(setq my-ime-active-color "red")
(setq my-ime-inactive-color "blue")

;; pale color
(make-face 'my-face-pale)
(set-face-foreground 'my-face-pale "gray")

;; tab or etc
(setq my-color-tab-other-background "tan3")
(setq my-color-tab-other-foreground "white")
(setq my-color-tab-current-background "wheat")
(setq my-color-tab-current-foreground "dark red")
(setq my-color-back "burlywood3")

;; main-line
(setq my-main-line-color-1 "#cd853f")
(setq my-main-line-color-2 "#cdaa7d")



;; error check

(make-face 'my-face-error-check-error)
(set-face-background 'my-face-error-check-error "pink")

(make-face 'my-face-error-check-warn)
(set-face-background 'my-face-error-check-warn "yellow")


	   
