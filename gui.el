;;;  IME      
;;;; Basic config

;; need emacs-mozc package which can be installed via apt-get
(when (locate-library "mozc")
  (progn
   (require 'mozc)
   (set-language-environment "japanese")
   (setq default-input-method "japanese-mozc")
   (setq mozc-candidate-style 'overlay)
   (define-key global-map "\C-o" 'toggle-input-method)))
;(setq mozc-candidate-style 'echo-area)

;;;  Migemo

(when (locate-library "migemo")
  (progn
    (require 'migemo)
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs"))

    (setq migemo-user-dictionary nil)
    (setq migemo-regex-dictionary nil)
    (setq migemo-coding-system 'utf-8-unix)
    (load-library "migemo")
    (migemo-init)))





     
