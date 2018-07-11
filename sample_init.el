(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq config-home "~/src/emacs_config/")
(load (concat config-home "minimal.el"))
