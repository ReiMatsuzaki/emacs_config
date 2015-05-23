;; ====== before =====
;; (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")

;; ====== Find File 1 ======
(find-file "~/.emacs.d/init.el")
(find-file "c:/Users/matsuzaki/gnupack_basic-11.00/home/.emacs.d/elisp/init_win.el")

;; ====== main =====
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq config-home "c:/Users/matsuzaki/gnupack_basic-11.00/home/.emacs.d/elisp/")
;(load (concat config-home "gui.el"))
(load (concat config-home "move.el"))
(load (concat config-home "minimal.el"))
(load (concat config-home "common.el"))
;(load (concat config-home "prog.el"))
(load (concat config-home "themes/support_blackboard.el"))

(server-start)

;; ====== color theme ====
; Leuven-theme customize
(setq org-fontify-whole-heading-line t)

;; ===== yasnippet =======
;(add-to-list 'yas-snippet-dirs
;	     (concat config-home "snippets"))
(setq yas-snippet-dirs
      '("c:/Users/matsuzaki/gnupack_basic-11.00/home/.emacs.d/elisp/snippets"
	"c:/Users/matsuzaki/AppData/Roaming/.emacs.d/elpa/yasnippet-20130218.2229/snippets"))
;(setq yas-snippet-dirs (list (concat config-home "snippets")))

;; ===== blackboard ======
;(add-to-list 'custom-theme-load-path 
;	     "~/local/themes/emacs-blackboard")
;(load-theme 'blackboard t)
;(load (concat config-home "themes/support_blackboard.el"))


;; -- org ---------------------

(setq dropbox-dir "c:/Users/matsuzaki/Dropbox/")
(setq org-directory (concat dropbox-dir "org"))
(setq org-agenda-files (list (expand-file-name org-directory)))
(setq org-reveal-root "/home/rei/Documents/slide/reveal.js")
;(setq org-mobile-directory (concat dropbox-dir "mobileorg"))
;(setq org-mobile-inbox-for-pull (concat dropbox-dir "mobileorg"))

; -- find-file -----------------
(find-file (concat config-home "minimal.el"))

(global-set-key (kbd "C-x #") '(lambda ()
                           (interactive)				 
                           (split-window-horizontally-n 3)))
(global-set-key (kbd "C-x $") '(lambda ()
				 (interactive)
				 (split-window-horizontally-n 4)))

(custom-set-faces '(default ((t (:height 110)))))
 
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))
