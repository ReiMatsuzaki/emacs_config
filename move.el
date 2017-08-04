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


(require 'windmove)

;;;;; * def (flip)


(defun buffer-flip-chose-direction (direction)
  (flet ((buffer-flip (win1 win2)
		      (let ((b1 (window-buffer win1))
			    (b2 (window-buffer win2)))
			(set-window-buffer win1 b2)
			(set-window-buffer win2 b1)
			(select-window win2))))
    (buffer-flip (selected-window) 
		 (windmove-find-other-window direction))))

(defun buffer-flip-up ()
  (interactive)
  (buffer-flip-chose-direction 'up))
(defun buffer-flip-down ()
  (interactive)
  (buffer-flip-chose-direction 'down))
(defun buffer-flip-right ()
  (interactive)
  (buffer-flip-chose-direction 'right))
(defun buffer-flip-left ()
  (interactive)
  (buffer-flip-chose-direction 'left))



;; simple test:
; (buffer-flip-chose-direction 'right)

;;;;; * def (UI), not used

(defun buffer-control-ui ()
  (interactive)
  (message "move:hjkl, bring:HJKL")
  (let ((cmd (read-char))
	(cmd-direction-alist 
	 '((?L . right) (?H . left) (?J . down) (?K . up)))
	(cmd-move-alist
	 '((?l . right) (?h . left) (?j . down) (?k . up)))
	dir)
    (setq dir (cdr (assoc cmd cmd-direction-alist)))
    (when dir
      (buffer-flip-chose-direction dir))
    (setq dir (cdr (assoc cmd cmd-move-alist)))
    (when dir
      (windmove-do-window-select dir))
    (when (equal cmd ?3)
      (wincon-construct
       'wincon-set-windows-three-holizon
       `((file ,(lambda () (wincon-get-l-in-current-frame 'buffer-file-name)))
	 (shell wincon-get-l-eshell-for-current-screen))))
    (when (equal cmd ?4)
      (wincon-construct
       'wincon-set-windows-2121
       `((file ,(lambda () (wincon-get-l-in-current-frame 'buffer-file-name)))
	 (shell wincon-get-l-eshell-for-current-screen))))
    (when (not (equal cmd ?g))
      (buffer-control-ui))))



;;;;  Kept and open 
;;;;; def

(defvar opening-buffer nil)
(defun find-file-and-kept-opening-buffer (file-name)
  "find file and kept it for opening-buffer"
  (interactive)
  (setq opening-buffer (find-file-noselect (expand-file-name file-name))))

(defun save-opening-buffer ()
  "change buffer and kept it for opening-buffer"
  (interactive)
  (setq opening-buffer (current-buffer)))


(defun switch-to-opening-buffer ()
  "open opening-buffer at current window"
  (interactive)
  (if opening-buffer
      (progn
	(switch-to-buffer opening-buffer)
	(setq opening-buffer nil))
  (message "there is no opening-buufer")))
