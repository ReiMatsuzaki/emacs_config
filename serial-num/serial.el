;;; serial.el ---insert serial numbers (ex. 1,2,3,...)

;; Copyright (C) 2013  

;; Author:   <rei@REI-WIN7>
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

(defvar *serial-num-current-num* 0)

(defun insert-serial-num ()
  (interactive)
  (insert (number-to-string *serial-num-current-num*))
  (setq *serial-num-current-num* (+ *serial-num-current-num* 1)))

(defun set-serial-num-n (n)
  (setq *serial-num-current-num* n))

(defun set-serial-num-n-interface (n)
  (interactive "nInput initial number n:")
  (set-serial-num-n n))

(defun set-serial-num-0 ()
  (interactive)
  (set-serial-num-n 0))

(defun set-serial-num-1 ()
  (interactive)
  (set-serial-num-n 1))


(provide 'serial)
;;; serial.el ends here
