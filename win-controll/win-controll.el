;;; win-control.el --- window controller

;; Copyright (C) 2013  

;; Author:  <rei@REI-WIN7>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:
(print "1")

;; ------------------------------------------
;; buffer and buffer type information
;; ------------------------------------------
;; wincon-info is information for window configuration.
;; buffer-type, whose first element of wincon-info is type of buffer (file or shell or etc..)
;; lambda-buffer-list, whose second element of wincon-info is lambda formula which calculate 
;; buffer list, whose type is equal to buffer-type.

;; wincon-info = '((buffer-type lambda-buffer-list) ..)
;; buffer-type = file | eshell | ..
;; lambda-buffer-list :: () -> (buffer..)

;; buffer-info = '((buffer-type (buffer..))..)

(defun wincon-calc-bufffer-info (wincon-info)
  "wincon-info->buffer-info"
  (flet ((bt-lbl-to-bt-bl (bt-lbl)
			  (list (car bt-lbl) (funcall (cadr bt-lbl)))))
    (mapcar #'bt-lbl-to-bt-bl
	    wincon-info)))
(defun wincon-minor-list-cycle (lst)
  (let ((x (car lst))
	(xs (cdr lst)))
    (append xs (list x))))

(defun wincon-cycle-buffer-info (buffer-type buffer-info)
  (let ((bt-bl (assoc buffer-type buffer-info)))
    (subst 
     (list buffer-type (wincon-minor-list-cycle (cadr bt-bl)))
     bt-bl
     buffer-info)))

;  (setf (cadr (assoc buffer-type buffer-info))
;	(wincon-minor-list-cycle 
;	 (cadr (assoc buffer-type buffer-info)))))
;; --------------------------------------------
;; window and buffer type and number
;; --------------------------------------------

;; window-info :: ( (window1 buffer-type1 number1)..)
(defun wincon-minor-w-bt-number-and-buffer-info-to-w-b (w-bt-number buffer-info)
  "calculate (window buffer) tupple list"
  (let* ((win (car w-bt-number))
	 (bt (cadr w-bt-number))
	 (num (caddr w-bt-number))
	 (bt-bl (car (remove-if-not 
		      (lambda (bt-bl) (eq bt (car bt-bl)))
		      buffer-info))))
    (list win (nth num (cadr bt-bl)))))
(defun wincon-get-window-buffer-pair-list (window-info buffer-info)
  "window-info, buffer-info -> ((window1 buffer1)..)"
  (mapcar (lambda (w-bt-number) 
	    (wincon-minor-w-bt-number-and-buffer-info-to-w-b w-bt-number buffer-info))
	  window-info))

;;------------functional code using number----------------
;; bt-func-list :: (list (buffer-type lambda-id-buffer-list) ..)
;; bt = buffer-type :: file | shell | ... 
;; libl = lambda-id-buffer-list :: () -> (list (id1 buffer1) (id2 buffer2) ..)

;; wincon-get-bt-num-buf-list :: 
;; bt-func-list -> (list (buffer-id buffer) ...)
;; buffer-id :: (buffer-type number)
(defun wincon-minor-bt-libl-to-bt-id-b (bt-libl)
  (let ((buffer-type (car bt-lbl))
	(id-buffer-list (funcall (cadr bt-libl))))
    (mapcar (lambda (id-buffer) 
	      (let ((id (car id-buffer))
		    (buffer (cadr id-buffer)))
		(list buffer-type id buffer)))
	    id-buffer-list)))
(defun wincon-get-bt-num-buf-list (bt-func-list)
  (flet ((bt-func-to-bt-num-buf (bt-func)
				(let ((buf-num-list (funcall (cadr bt-func)))
				      (bt (car bt-func)))
				  (list bt buf-num-list)
				  (mapcar (lambda (buf-num)
					    (list (list bt (car buf-num)) (cadr buf-num)))
					  buf-num-list))))
    (apply 'append
	   (mapcar 'bt-func-to-bt-num-buf
		   bt-func-list))))

; (list (buffer-id buffer) ...)
; (list (window buffer-id) ...)
; ->
; (list (window buffer)...)
;bid = buffer id
(defun wincon-get-win-buf-list (bid-buf-list win-bid-list)
    (mapcar (lambda (w-bid)
	      (let* ((w (car w-bid))
		     (bid (cadr w-bid))
		     (b (cadr (assoc bid bid-buf-list))))
		     (list w b)))
	 win-bid-list))

;;------------non functional code using number-------------
;; ((window buffer) ...) -> buffer is shown in window
(defun wincon-set-buffers (win-buf-list)
  (mapc (lambda (wb)
	  (set-window-buffer (car wb) (cadr wb)))
	win-buf-list))
(defun wincon-construct (config-and-set-win btype-func-list)
  (let* ((w-bid-list (funcall config-and-set-win))
	 (bid-b-list (wincon-get-bt-num-buf-list btype-func-list))
	 (w-b-list (wincon-get-win-buf-list bid-b-list w-bid-list)))
    (wincon-set-buffers w-b-list)))
;;------------customization function----------------------

;; split window and
;; make ((window buffer-id)...)
(defun wincon-set-windows-two-holizon ()
  (delete-other-windows)
  (split-window-horizontally)
  (let (w1 w2)
    (setq w1 (selected-window))
    (setq w2 (next-window))
    (list (list w1 '(file 0)) 
	  (list w2 '(file 1)))))
(defun wincon-set-windows-three-holizon ()
  (delete-other-windows)
  (split-window-horizontally-n 3)
  (let (w1 w2 w3)
    (setq w1 (selected-window))
    (setq w2 (next-window))
    (setq w3 (next-window (next-window)))
    (list (list w1 '(file 0))
	  (list w2 '(file 1))
	  (list w3 '(shell 0)))))
(defun wincon-set-windows-112 ()
    (delete-other-windows)
    (split-window-horizontally-n 3)
    (other-window 2)
    (split-window-below)
    (other-window 2)
    (let (w1 w2 w3 w4 w-list)
      (setq w-list (window-list))
      (setq w1 (car w-list))
      (setq w2 (nth 1 w-list))
      (setq w3 (nth 2 w-list))
      (setq w4 (nth 3 w-list))
      (list (list w1 '(file 0))
	    (list w2 '(file 1))
	    (list w3 '(file 2))
	    (list w4 '(shell 0)))))
(defun wincon-set-windows-2121 ()
  (delete-other-windows)
  (split-window-horizontally-n 4)
  (split-window-vertically)
  (other-window 3)
  (split-window-vertically)
  (other-window 3)
  (let ((w-bid-list ())
	(w-list (window-list)))
    (push (list (nth 0 w-list) '(file  0)) w-bid-list)
    (push (list (nth 1 w-list) '(shell 0)) w-bid-list)
    (push (list (nth 2 w-list) '(file  1)) w-bid-list)
    (push (list (nth 3 w-list) '(file  2)) w-bid-list)
    (push (list (nth 4 w-list) '(shell 1)) w-bid-list)
    (push (list (nth 5 w-list) '(file  3)) w-bid-list)))

;; make bid-buffer list (bid-buffer list => bbl)
(defvar *wincon-size-buf-list* 10)

; functional code
(defun wincon-bufs-to-bbl (b-list bid-max)
  (let ((bid-list (loop for i 
			below bid-max
			collect i))
	(b-num (list-length b-list)))
    (mapcar (lambda (bid)
	      (list bid
		    (nth (mod bid b-num) b-list)))
	    bid-list)))
(defun wincon-get-bbl-in-current-frame (&optional buf-filter-p)
  (let* ((w-list (window-list nil nil (frame-first-window)))
	 (b-list (mapcar 'window-buffer w-list)))
    (wincon-bufs-to-bbl
     (if buf-filter-p
	 (remove-if-not buf-filter-p b-list)
       b-list)
     *wincon-size-buf-list*)))
(defun wincon-get-bbl-all (&optional buf-filter-p)
  (wincon-bufs-to-bbl
   (if buf-filter-p
       (remove-if-not buf-filter-p (buffer-list))
     (buffer-list))
   *wincon-size-buf-list*))
(defun wincon-get-bbl-eshell-for-current-screen ()
  (flet ((eshell-current-elscreen-p 
	  (buf)
	  (let ((regx (concat "\\*eshell\\*<" 
			      (number-to-string (elscreen-get-current-screen))
			      ".>")))
	    (string-match regx (buffer-name buf)))))
    (wincon-get-bbl-all 'eshell-current-elscreen-p)))				    

(provide 'win-control)
;;; win-control.el ends here
