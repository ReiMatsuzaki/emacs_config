;;;; comment

;; this setting is for using with solarized-dark theme

;;;; outshine

(set-face-attribute 'outshine-level-1 nil
		    :foreground "dodger blue"
		    :height 1.3
		    :bold t
		    :underline nil)
(set-face-attribute 'outshine-level-2 nil
                    :foreground "#edd400"
		    :background nil
		    :height 1.2
		    :underline nil)
(set-face-attribute 'outshine-level-3 nil
		    :foreground "#6ac214"
		    :height 1.1
		    :underline nil)

;;;; Elscreen
(set-face-attribute 'elscreen-tab-other-screen-face nil
		    :background "#14151E"
		    :foreground "white"
		    :underline nil)

(set-face-attribute 'elscreen-tab-current-screen-face nil
		    :background "#14151E"
		    :foreground "#c397d8"
		    :underline nil)

(set-face-background 'elscreen-tab-background-face 
		     "#181a26")

(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)

(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)





