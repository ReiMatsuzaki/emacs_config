;;; gui.el --- gui setting

;; Copyright (C) 2015  Rei

;; Author: Rei <rei@rei-VirtualBox-xubuntu>
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


;;;  IME   


;; need emacs-mozc package which can be installed via apt-get
(require 'mozc)
(set-language-environment "japanese")
(setq default-input-method "japanese-mozc")
;(setq mozc-candidate-style 'overlay)
(setq mozc-candidate-style 'echo-area)

(define-key global-map "\C-o" 'toggle-input-method)




