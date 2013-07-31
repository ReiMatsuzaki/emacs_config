;-------test character-------------
(setq *buffer-info-test* '((file ("buf1" "buf2")) (shell ("buf3"))))
(setq *window-info-test* '(("win1" file 0) ("win2" file 1) ("win3" shell 0)))

(car *window-info-test*)
(wincon-minor-w-bt-number-and-buffer-info-to-w-b (car *window-info-test*) *buffer-info-test*)
(wincon-get-window-buffer-pair-list *window-info-test* *buffer-info-test*)

;--------test new---------------
(setq *wincon-info-test* `((file ,(lambda ()  (list (get-buffer "win-controll.el")
						    (get-buffer "test.el"))))
			     (shell ,(lambda () (list (get-buffer "*eshell*<1>"))))))

(setq *wincon-info-num-test* `((file ,(lambda () (list "buffer1" "buffer2")))
			       (shell ,(lambda () (list "buffer3" "buffer4")))))



(wincon-calc-bufffer-info *wincon-info-num-test*)



;--------using number------------
(defvar *btype-number-collect-t* `((file ,(lambda ()  `((0 ,(get-buffer "win-controll.el"))
							(1 ,(get-buffer "test.el")))))
				   (shell ,(lambda () `((0 ,(get-buffer "*eshell*<1>")))))))
(funcall (cadr (car *btype-number-collect-t*)))

(setq bid-buf-list (win-control-get-bt-num-buf-list *btype-number-collect-t*))

(setq win-bt-num-list-t (let ((w-list (window-list)))
			  `( (,(car   w-list) (file 0))
			     (,(cadr  w-list) (file 1))
			     (,(caddr w-list) (shell 0)))))

(win-control-get-win-buf-list (win-control-get-bt-num-buf-list *btype-number-collect-t*)
			 win-bt-num-list-t)

(win-control-set-buffers (win-control-get-win-buf-list 
			  (win-control-get-bt-num-buf-list *btype-number-collect-t*)
			  win-bt-num-list-t))

(win-control-set-windows-three-holizon)
(setq win-bid-list (win-control-set-windows-three-holizon))
(princ win-bid-list)

(setq win-bid-list (win-control-set-windows-two-holizon))
(win-control-set-buffers (win-control-get-win-buf-list 
			  (win-control-get-bt-num-buf-list *btype-number-collect-t*)
			  win-bid-list))

(win-control-construct 
 'win-control-set-windows-two-holizon 
 *btype-number-collect-t*)

(win-control-construct 
 'win-control-set-windows-three-holizon
 *btype-number-collect-t*)

(win-control-construct
 'win-control-set-windows-three-holizon
 '((file win-control-get-bid-buf-list-files-seeable)
   (shell win-control-get-bid-buf-eshell-for-this-elscreen)))
;;---------make window------------------
(win-control-set-windows-112)


;;---------make buffer---------------------
(wincon-bufs-to-bbl
 (mapcar 'window-buffer (window-list))
 4)

(wincon-get-bbl-in-current-frame)
(wincon-get-bbl-in-current-frame 'buffer-file-name)

(wincon-get-bbl-all)

(wincon-get-bbl-all 
 (lambda (buf)
   (let ((regx (concat "\\*eshell\\*<" 
		       (number-to-string (elscreen-get-current-screen))
		       ".>")))
     (string-match regx (buffer-name buf)))))

(wincon-get-bbl-eshell-for-current-screen)
 
;;-------TEST------------------------------
(wincon-construct
 'wincon-set-windows-2121
 '((file wincon-get-bbl-in-current-frame)
   (shell wincon-get-bbl-eshell-for-current-screen)))

(wincon-construct
 'wincon-set-windows-three-holizon
 '((file wincon-get-bbl-in-current-frame)
   (shell wincon-get-bbl-eshell-for-current-screen)))

(wincon-get-bbl-in-current-frame 'buffer-file-name)

