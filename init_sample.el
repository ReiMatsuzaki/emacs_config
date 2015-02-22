(setq config-home "~/source/emacs_config/")
(load (concat config-home "minimal.el"))
(load (concat config-home "common.el"))
(load (concat config-home "prog.el"))
(load (concat config-home "gui.el"))
(load (concat config-home "themes/support_blackboard.el"))

;; -- yasnippet ---------------
(setq yas-snippet-dirs
      '("c:/Users/matsuzaki/gnupack_basic-11.00/home/.emacs.d/elisp/snippets"
	"c:/Users/matsuzaki/AppData/Roaming/.emacs.d/elpa/yasnippet-20130218.2229/snippets"))

; -- find-file -----------------
(find-file (concat config-home "minimal.el"))
(find-file "d:/gnupack_basic-11.00/home/.emacs.d/init.el")

;; -- org -----------------------
(setq org-agenda-files (list (expand-file-name "~/Dropbox/org")))
(setq org-directory "~/Dropbox/org")
(setq org-mobile-directory "~/Dropbox/mobileorg")
(setq org-mobile-inbox-for-pull "~/Dropbox/mobileorg.org")

;; -- other buffer -------------
(global-set-key (kbd "C-x #") '(lambda ()
                           (interactive)				 
                           (split-window-horizontally-n 3)))
(global-set-key (kbd "C-x $") '(lambda ()
				 (interactive)
				 (split-window-horizontally-n 4)))

;(custom-set-faces
; '(default ((t (:height 90 )))))
;(menu-bar-mode 1)
;(menu-bar-mode -1)
