(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://melpa.stable.melpa.org/packages/") t)
(setq config-home "~/src/emacs_config/")
(load (concat config-home "minimal.el"))

(package-initialize)
(load (concat config-home "common.el"))
(load (concat config-home "prog.el"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (key-chord ggtags yasnippet smooth-scroll smartrep shackle popwin outshine multiple-cursors markdown-mode magit helm-swoop fold-dwim auto-complete auctex anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
