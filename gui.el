;;;  IME      
;;;; Basic config

;; need emacs-mozc package which can be installed via apt-get
(require 'mozc)
(set-language-environment "japanese")
(setq default-input-method "japanese-mozc")
(setq mozc-candidate-style 'overlay)
;(setq mozc-candidate-style 'echo-area)

;;;; Key bind 

(define-key global-map "\C-o" 'toggle-input-method)
;(define-key global-map "\C-o" 'mozc-mode)

;;;; Change cursor color

(defun mozc-change-cursor-color ()
  (if mozc-mode
      (set-buffer-local-cursor-color "Red")
    (set-buffer-local-cursor-color nil)))

;(add-hook 'input-method-activate-hook
;	  (lambda () (mozc-change-cursor-color)))



;;;  font     

;(create-fontset-from-ascii-font "Ricty-13:weight=normal:slant=normal" nil "ricty")
;(set-fontset-font "fontset-ricty"
;		  'unicode
;		  (font-spec :family "Ricty" :size 13)
;		  nil
;		  'append)
;(add-to-list 'default-frame-alist '(font . "fontset-ricty"))

;(set-face-attribute 'default nil
;		    :height 85)
;(add-to-list 'default-frame-alist '(font . "ricty-13"))
;(custom-set-faces
; '(variable-pitch ((t (:family "Ricty"))))
; '(fixed-pitch ((t (:family "Ricty")))))


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






     
;;;  elscreen 







