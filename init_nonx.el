;; ====== before =====
;(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")

; -- find-file -----------------
(find-file "~/.emacs.d/init.el")
(find-file (concat config-home "init_nonx.el"))

;; ====== main =====
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq config-home "~/src/config/emacs_config/")
(load (concat config-home "minimal.el"))
(load (concat config-home "common.el"))
(load (concat config-home "prog.el"))
;(load (concat config-home "gui.el"))
(load (concat config-home "move.el"))
(server-start)

; -- find-file -----------------
(find-file (concat config-home "minimal.el"))
(find-file (concat config-home "common.el"))

; -- theme ---------------------
(setq my-color "orange")
(setq my-color "gray")
(setq my-color "blue")
(setq my-color "red")
(setq my-color "green")
(load (concat config-home "themes/color_non_x.el"))


; ~/src/config/emacs_config/common.el

;; ====== color theme ====
; Leuven-theme customize
(setq org-fontify-whole-heading-line t)

;; ===== yasnippet =======
;(add-to-list 'yas-snippet-dirs
;	     (concat config-home "snippets"))
(setq yas-snippet-dirs (list (concat config-home "snippets")))


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

