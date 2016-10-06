; to prevent showing message in magit 
(setq magit-last-seen-setup-instructions "1.4.0")

; set character coding as utf
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;; yasnippet 
(setq yas-snippet-dirs (list (concat config-home "snippets")
			     "~/.emacs.d/elpa/yasnippet-0.6.1/snippets"
			     "~/.emacs.d/sinippets"))

;; mac only
(mac-auto-ascii-mode t)

;; -- org -----------------------
(setq org-directory "~/Note")
(setq org-agenda-files (list (expand-file-name "~/Note/task/")))

; read files
(setq config-home "~/src/git/emacs_config/")
(load (concat config-home "minimal.el"))
(load (concat config-home "common.el"))
(load (concat config-home "move.el"))
(load (concat config-home "prog.el"))
(load (concat config-home "gui.el"))
(load (concat config-home "themes/support_blackboard.el"))

; -- find-file -----------------
(find-file (concat config-home "init_mac.el"))

; -- Notebook ----------------
;(require 'folding)


;; -- other buffer -------------
(global-set-key (kbd "C-x #") '(lambda ()
                           (interactive)				 
                           (split-window-horizontally-n 3)))
(global-set-key (kbd "C-x $") '(lambda ()
				 (interactive)
				 (split-window-horizontally-n 4)))

; (custom-set-faces '(default ((t (:height 120 ))))) (custom-set-faces
; '(default  ((t (:height  110 )))))  (custom-set-faces '(default  ((t
					; (:height 100 )))))
; (custom-set-faces '(default ((t (:height 150 )))))
; (custom-set-faces '(default ((t (:height 120 )))))
; (custom-set-faces '(default ((t (:height 90 )))))
; (menu-bar-mode 1) (menu-bar-mode -1)







