;;; tex.el --- tex support

;; Copyright (C) 2013  

;; Author:  <rei@REI-WIN7>
;; Keywords: tex

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

;;============Utility======================
(defun extract-between-a-and-b (label a b)
  (substring label
	     (+ 1 (string-match a label))
	     (string-match b label)))

(defun insert-ref-in-latex (label)
  (insert (concat
	   "\\ref{" label "}")))

;;============insert ref===================

; actionのinには (colnum label-name)の形である。
(setq helm-c-source-label-with-colnum
   '((name . "Label")
     (headline . "label{\\(.*\\)}")
     (subexp . 1)
     (action . (lambda (in)
		 (insert-ref-in-latex 
		   (car (cdr in)))))
     (persistent-action . (lambda (in)
			    (goto-line (car in))
			    (beginning-of-line)
			    (show-all)
			    (recenter-top-bottom)))))

(defun helm-ref-tex-in-org ()
  "search label in this buffer and insert ref{}"
  (interactive)
  (helm-other-buffer
   helm-c-source-label-with-colnum
   "*helm Label")
  (org-global-cycle)
  (org-reveal))

(defun helm-ref-tex ()
  "search label in this buffer and insert ref{}"
  (interactive)
  (save-excursion
    (helm-other-buffer
     '(helm-c-source-label-with-colnum)
     "*helm Label")))

;;==============ref junp to label================
(defun tex-pop-to-label ()
  "point \ref{...} and junp the related \label"
  (interactive)
  (if (looking-at "\\\\ref{\\(.*\\)}")
      (let ((lbl (concat "label{" (match-string-no-properties 1) "}"))
	    (buf (current-buffer)))
	(other-window-or-split 1)
	(switch-to-buffer buf)
	(goto-char (point-min))
	(search-forward lbl)
	(recenter))
    (message "failed to find")))


;(defun helm-ref-tex ()
;  "search label in this buffer and insert ref{}"
;  (interactive)
;  (helm-other-buffer
;   helm-c-source-label-with-colnum
;   "*helm Label")
;  (fold-dwim-hide-all)
;  (beginning-of-line)
;  (fold-dwim-toggle))
  
;(defun LaTeX-fold-eqnarray ()
;  (interactive)
;  (save-excursion
;    (goto-char (point-min))
;    (re-search-forward "begin{eqnarray}" nil t)
;    (let ((ov (make-overlay (match-beginning 0) (match-end 0) nil t t)))
;      (overlay-put ov 'display "be"))))

;(setq tex-command "platex"
;      dvi2-command "xdvi"
;      dviprint-command-format "dvips %s | lpr"
;      YaTeX-kanji-code 3 
;      YaTeX-use-AMS-LaTeX t 
;      )
;=========helm-label(dep on helm)============
;(defun helm-c-print-label-with-colnum ()
;  (interactive)
;  (let (cl-alist)
;    (save-excursion
;      (goto-char (point-min))
;      (let (word col-num)
;	(while (re-search-forward "label" nil t)
;	  (re-search-forward "{.*}" nil t)
;	  (setq word (substring 
;		      (buffer-substring-no-properties 
;		       (match-beginning 0) (match-end 0))
;		      1 -1))
;	  (setq col-num (count-lines (point-min) (point)))
;	  (setq cl-alist (cons (concat (number-to-string col-num) ":" word) cl-alist)))))
;    cl-alist))
;(defun make-colnum-and-label-file-name (base-org-file-name)
;  (concat (substring base-org-file-name 0 -3) "label"))
;(defun collect-colnum-and-label-write-file()
;  (interactive)
;  (let ((cl-alist (helm-c-print-label-with-colnum))
;  	(fn (make-colnum-and-label-file-name(buffer-file-name)))
;	ele)
;    (save-excursion
;      (set-buffer (find-file-noselect fn))
;      (erase-buffer)
;      (while cl-alist
;	(setq ele (car cl-alist))
;	(insert (concat ele "\n"))
;	(setq cl-alist (cdr cl-alist)))
;      (basic-save-buffer))))
	   
;(defun helm-label-with-colnum ()
;  (interactive)
;  (helm-other-buffer
;   '((name ."Label")
;     (headline . "label{\\(.*\\)}")
;     (subexp 1)
;     (action . (lambda (in) 
;		 (insert-ref-in-latex 
;		  (extract-between-a-and-b
;		   (car(cdr in)) "{" "}"))))
;     (type . line))
;   "*helm Label"))

;;; tex.el ends here
