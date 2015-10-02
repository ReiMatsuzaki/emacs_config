;;; package -- Summary
;;; Commentary:
;
;; this setting is for using with solarized-dark theme
;
;
;;; Code:
;;;; outshine
;(set-face-attribute 'outshine-level-1 nil
;		    :foreground "dodger blue"
;		    :height 1.3
;		    :bold t
;		    :underline nil)
;(set-face-attribute 'outshine-level-2 nil
;                    :foreground "#edd400"
;		    :background nil
;		    :height 1.2
;		    :underline nil)
;(set-face-attribute 'outshine-level-3 nil
;		    :foreground "#6ac214"
;		    :height 1.1
;		    :underline nil)

;;;; Elscreen
(set-face-attribute 'elscreen-tab-other-screen-face nil
		    :background "SlateGray3"
		    :foreground "white"
		    :underline nil)

(set-face-attribute 'elscreen-tab-current-screen-face nil
		    :background "RoyalBlue3"
		    :foreground "LightBlue1"
		    :underline nil)

(set-face-background 'elscreen-tab-background-face 
		     "white")

(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)

(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)




