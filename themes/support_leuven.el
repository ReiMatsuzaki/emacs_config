;;; package -- Summary
;;; Commentary:
;
;; this setting is for using with solarized-dark theme
;
;
;;; Code:
;;;; color

(defvar my-light "#85CEEB")
(defvar my-dark "#335EA8")
(defvar my-white "#F0F0EF")
(defvar my-gray "#9B9C97")

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

(set-face-attribute 'elscreen-tab-current-screen-face nil
		    :background my-dark
		    :foreground my-white
		    :underline nil)

(set-face-attribute 'elscreen-tab-other-screen-face nil
		    :background my-gray
		    :foreground my-white
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


;;;; Eshell

(defun leuven-shell-prompt ()
  (concat 
   (with-face (system-name) :background my-dark :foreground my-light)
   (with-face (concat " " (eshell/pwd) " ") :background my-dark :foreground my-white)
   (with-face "\n $" :foreground my-dark)
   (with-face " " :foreground "black")))


(setq eshell-prompt-function 'leuven-shell-prompt)

