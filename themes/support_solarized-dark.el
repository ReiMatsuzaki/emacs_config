;;;; comment

;; this setting is for using with solarized-dark theme


;;;; basic

(set-face-background 'region "brightblack")
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


;;;; my-color

(setq idx-solarized-color-type 1)

(defun solarized-color-i (i)
  (elt (elt solarized-colors i) idx-solarized-color-type))


;;;; elscreen


(set-face-attribute 'elscreen-tab-other-screen-face nil
		    :background (solarized-color-i 4)
		    :foreground (solarized-color-i 0)
		    :underline nil)

(set-face-attribute 'elscreen-tab-current-screen-face nil
		    :background (solarized-color-i 9)
		    :foreground (solarized-color-i 0)
		    :underline nil)

(set-face-foreground 'elscreen-tab-background-face (solarized-color-i 2))


(set-face-bold-p 'elscreen-tab-current-screen-face t)
(set-face-bold-p 'elscreen-tab-other-screen-face t)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)


;;;; mode line
;;;;; arrow right 

(defun arrow-right-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 24 2 1\",
\". c %s\",
\"  c %s\",
\".           \",
\"..          \",
\"...         \",
\"....        \",
\".....       \",
\"......      \",
\".......     \",
\"........    \",
\".........   \",
\"..........  \",
\"........... \",
\"............\",
\"........... \",
\"..........  \",
\".........   \",
\"........    \",
\".......     \",
\"......      \",
\".....       \",
\"....        \",
\"...         \",
\"..          \",
\".           \",
\"            \"};"  color1 color2))

;;;;; arrow right mini

(defun arrow-mini-right-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"6 12 2 1\",
\". c %s\",
\"  c %s\",
\".     \",
\"..    \",
\"...   \",
\"....  \",
\"..... \",
\"......\",
\"..... \",
\"....  \",
\"...   \",
\"..    \",
\".     \",
\"      \"};"  color1 color2))


;;;;; aa

(defun aa-mini-right-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"6 12 2 1\",
\". c %s\",
\"  c %s\",
\".     \",
\"..    \",
\"...   \",
\"....  \",
\"..... \",
\"......\",
\"..... \",
\"....  \",
\"...   \",
\"..    \",
\".     \",
\"      \"};"  color1 color2))

;;;;; arrow left

(defun arrow-left-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 24 2 1\",
\". c %s\",
\"  c %s\",
\"           .\",
\"          ..\",
\"         ...\",
\"        ....\",
\"       .....\",
\"      ......\",
\"     .......\",
\"    ........\",
\"   .........\",
\"  ..........\",
\" ...........\",
\"............\",
\" ...........\",
\"  ..........\",
\"   .........\",
\"    ........\",
\"     .......\",
\"      ......\",
\"       .....\",
\"        ....\",
\"         ...\",
\"          ..\",
\"           .\",
\"            \"};"  color2 color1))

;;;;; arrow left mini

(defun arrow-mini-left-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"6 12 2 1\",
\". c %s\",
\"  c %s\",
\"     .\",
\"    ..\",
\"   ...\",
\"  ....\",
\" .....\",
\"......\",
\" .....\",
\"  ....\",
\"   ...\",
\"    ..\",
\"     .\",
\"      \"};"  color2 color1))


;;;;; set

(require 'powerline)

(defun right-xpm(a b) 
  (arrow-mini-right-xpm a b))
(defun left-xpm(a b) 
  (arrow-mini-left-xpm a b))

(set 'left-xpm  'arrow-mini-left-xpm)

(set-face-attribute 'mode-line nil
                    :foreground (solarized-color-i 7)
                    :background "black"
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :foreground (solarized-color-i 7)
                    :background "#000")

(defconst color1 (solarized-color-i 7))
;(defconst color2 (solarized-color-i 1))
;(defconst color3 (solarized-color-i 13))

;(defconst color2 "pale green")
;(defconst color3 "dark green")
(defconst color2 "sky blue")
(defconst color3 "dark cyan")

(make-face 'mode-line-color-1)
(set-face-attribute 'mode-line-color-1 nil
                    :foreground color1
                    :background (solarized-color-i 1))

(make-face 'mode-line-color-2)
(set-face-attribute 'mode-line-color-2 nil
                    :foreground color2
                    :background color3)

(make-face 'mode-line-color-3)
(set-face-attribute 'mode-line-color-3 nil
                    :foreground color3
                    :background color2)

(setq arrow-right-1 (create-image (right-xpm color1 color2) 'xpm t :ascent 'center))
(setq arrow-right-2 (create-image (right-xpm color2 color3) 'xpm t :ascent 'center))
(setq arrow-right-3 (create-image (right-xpm color3 "None") 'xpm t :ascent 'center))
(setq arrow-left-1  (create-image (left-xpm  color2 color1) 'xpm t :ascent 'center))
(setq arrow-left-2  (create-image (left-xpm  "None" color2) 'xpm t :ascent 'center))

(setq-default mode-line-format
 (list  '(:eval (concat (propertize " %* %b " 'face 'mode-line-color-1)
                        (propertize " " 'display arrow-right-1)))
        '(:eval (concat (propertize " %Z " 'face 'mode-line-color-2)
                        (propertize " " 'display arrow-right-2)))
        '(:eval (concat (propertize " %m " 'face 'mode-line-color-3)
                        (propertize " " 'display arrow-right-3)))

        ;; Justify right by filling with spaces to right fringe - 16
        ;; (16 should be computed rahter than hardcoded)
        '(:eval (propertize " " 'display '((space :align-to (- right-fringe 17)))))

        '(:eval (concat (propertize " " 'display arrow-left-2)
                        (propertize " %p " 'face 'mode-line-color-2)))
        '(:eval (concat (propertize " " 'display arrow-left-1)
                        (propertize "%4l:%2c  " 'face 'mode-line-color-1)))
))




;;;; eshell
;;;;; prompt


(defun system-name-for-yablab ()
  (substring (system-name) 0 6))

(setq eshell-prompt-function
      (lambda ()
	(concat
	 (with-face (system-name)
		    :background nil
		    :foreground "magenta")
	 "<<"
	 (with-face (eshell/pwd)
		    :foreground "yellow")
	 ">>"
	 "\n$ ")))

(setq eshell-highlight-prompt nil)
(setq eshell-prompt-regexp "^[$#] ")


;;;;; font

;(add-hook 'eshell-mode-hook
;	  '(lambda ()
;	     (set-face-foreground 'eshell-ls-directory "cyan")
;	     (set-face-foreground 'eshell-ls-executable "orange")
;	     (set-face-foreground 'eshell-ls-symlink "lightgreen")))


;;;; outshine


(set-face-attribute 'outshine-level-1 nil
		    :foreground (solarized-color-i 0)
		    :background (solarized-color-i 14)
		    :underline nil)
(set-face-attribute 'outshine-level-2 nil
                    :foreground (solarized-color-i 14)
		    :background nil
		    :underline t)
(set-face-attribute 'outshine-level-3 nil
		    :foreground (solarized-color-i 3)
		    :underline t)




;;;; font-lock


;(set-face-foreground 'font-lock-string-face "color-172")  ;; color-172 is orange similar
;(set-face-foreground 'font-lock-keyword-face "yellow")
;(set-face-foreground 'font-lock-builtin-face "yellow")
;(set-face-foreground 'font-lock-constant-face "purple")
;(set-face-foreground 'font-lock-comment-face my-light)
;(set-face-foreground 'font-lock-warning-face "red")
;(set-face-foreground 'font-lock-function-name-face "color-159")
;(set-face-foreground 'font-lock-variable-name-face "cyan")
;(set-face-foreground 'font-lock-type-face "magenta")


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

