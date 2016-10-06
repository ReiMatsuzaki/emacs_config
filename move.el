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

;; C-x o bind to frame move
(define-key global-map (kbd "C-x o") 'other-frame)

