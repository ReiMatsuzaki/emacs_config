;; ====== before =====
(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")

;; ====== main =====
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq config-home "~/src/config/emacs_config/")
(load (concat config-home "minimal.el"))
(load (concat config-home "common.el"))
(load (concat config-home "prog.el"))
(load (concat config-home "gui.el"))

;; ====== color theme ====
; Leuven-theme customize
(setq org-fontify-whole-heading-line t)

; moe-theme
;(require 'powerline)
;(require 'moe-theme)
;(moe-light)   ;; chose moe-light or moe-dark
;(setq moe-theme-resize-org-title '(3.0 2.0 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
;(moe-theme-set-color 'orange)
;(powerline-moe-theme)

;; ===== yasnippet =======
;(add-to-list 'yas-snippet-dirs
;	     (concat config-home "snippets"))
(setq yas-snippet-dirs (list (concat config-home "snippets")))

;; ===== blackboard ======
(add-to-list 'custom-theme-load-path 
	     "~/local/themes/emacs-blackboard")
(load-theme 'blackboard t)
;(load (concat config-home "themes/support_blackboard.el"))

;; -- org -----------------------
(setq org-agenda-files (list (expand-file-name "~/Dropbox/org")))
(setq org-directory "~/Dropbox/org")
(setq org-reveal-root "/home/rei/Documents/slide/reveal.js")

; -- find-file -----------------
(find-file (concat config-home "minimal.el"))
(find-file "~/.emacs.d/init.el")

;; ~/src/config/emacs_config/minimal.el
;; ~/src/config/emacs_config/themes/soft-color.el
;; ~/src/config/emacs_config/themes/support_solarized-dark.el
;; ~/src/config/emacs_config/themes/dark-color.el
;; ~/src/config/emacs_config/gui.el

(global-set-key (kbd "C-x #") '(lambda ()
                           (interactive)				 
                           (split-window-horizontally-n 3)))
(global-set-key (kbd "C-x $") '(lambda ()
				 (interactive)
				 (split-window-horizontally-n 4)))

(custom-set-faces '(default ((t (:height 100)))))
 
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))
