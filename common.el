;;;; mutli-cursors/smartrep

(require 'multiple-cursors)
(require 'smartrep)

(global-set-key (kbd "C-c l") 'mc/edit-lines)
(global-set-key (kbd "C-c r") 'mc/mark-all-in-region)

(global-unset-key "\C-t")

(smartrep-define-key global-map "C-t"
  '(("C-t" . 'mc/mark-next-like-this)
    ("n"   . 'mc/mark-next-like-this)
    ("p"   . 'mc/mark-previous-like-this)
    ("m"   . 'mc/mark-more-like-this-extended)
    ("u"   . 'mc/unmark-next-like-this)
    ("U"   . 'mc/unmark-previous-like-this)
    ("s"   . 'mc/skip-to-next-like-this)
    ("S"   . 'mc/skip-to-previous-like-this)
    ("*"   . 'mc/mark-all-like-this)
    ("d"   . 'mc/mark-all-like-this-dwim)
    ("i"   . 'mc/insert-numbers)
    ("o"   . 'mc/sort-regions)
    ("O"   . 'mc/reverse-regions)))


;;;; perspective 

(require 'perspective)
(persp-mode 1)

(global-set-key (kbd "C-c n")   'persp-next)
(global-set-key (kbd "C-c C-n") 'persp-next)
(global-set-key (kbd "C-c p")   'persp-prev)
(global-set-key (kbd "C-c C-p") 'persp-prev)
(global-set-key (kbd "C-c s")   'persp-switch)
;;;; Git

(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)

;;;; fold-dwim

(require 'fold-dwim)

(define-key global-map (kbd "C-c f") 'fold-dwim-toggle)
(define-key global-map (kbd "C-c a") 'fold-dwim-show-all)
(define-key global-map (kbd "C-c w") 'fold-dwim-hide-all)


;;;; outshine

(require 'outshine)
(defun outshine-fold-to-level-1  ()
  (interactive)
  (beginning-of-line)
  (while (not (eobp))
    (outline-hide-more)
    (forward-line 1)))

