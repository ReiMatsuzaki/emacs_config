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

(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)

;;;  move     

(defvar move-global-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (setq windmove-wrap-around t)
    (define-key map (kbd "M-j") 'windmove-down)
    (define-key map (kbd "M-k") 'windmove-up)
    (define-key map (kbd "M-l") 'windmove-right)
    (define-key map (kbd "M-h") 'windmove-left)
    (define-key map (kbd "M-h") 'windmove-left)
    (define-key map (kbd "M-J") 'buffer-flip-down)
    (define-key map (kbd "M-K") 'buffer-flip-up)
    (define-key map (kbd "M-L") 'buffer-flip-right)
    (define-key map (kbd "M-H") 'buffer-flip-left)
    (define-key map (kbd "M-s") 'save-opening-buffer)
    (define-key map (kbd "M-m") 'switch-to-opening-buffer)
    map))

(define-minor-mode move-global-minor-mode
  "move minor mode"
  :global t)

(move-global-minor-mode t)






     
