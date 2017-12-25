;;; org
;;;;; config

;; set locale as English
(setq system-time-locale "C")

(setq org-startup-truncated nil)
(setq org-export-latex-classes nil)
(setq org-hide-leading-stars nil)

(defun org-fold-this-brunch ()
  "Fold brunch which the cursol is located."
  (interactive)
  (outline-previous-visible-heading 1)
  (org-cycle))

(global-set-key (kbd "C-c a ") 'org-agenda)
(global-set-key (kbd "C-c m") 'org-capture)

(add-hook 'org-mode-hook
	  (lambda ()
	    (setq truncate-lines t)
	    (define-key org-mode-map (kbd "\C-c 1") 'org-time-stamp-inactive)
	    (define-key org-mode-map (kbd "\C-c f") 'org-fold-this-brunch)
	    (define-key org-mode-map (kbd "\C-c e") 'org-edit-special)))

(setq org-agenda-files '("~/now"))

(smartrep-define-key org-mode-map "C-c"
  '(("C-n" . outline-next-visible-heading)
    ("C-p" . outline-previous-visible-heading)
    ("C-u" . outline-up-heading)
    ("C-f" . org-forward-heading-same-level)
    ("C-b" . org-backward-heading-same-level)))

;; Columns Views
; http://futurismo.biz/archives/3631
(setq org-global-properties (quote ((
      "Effort_ALL" . "00:05 00:10 00:15 00:30 01:00 01:30 02:00 02:30 03:00"))))
;; カラムビューで表示する項目
;; Column の書式は以下.
;; [http://orgmode.org/manual/Column-attributes.html#Column-attributes
(setq org-columns-default-format "%50ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM(Clock){:}")
(setq org-agenda-columns-add-appointments-to-effort-sum t)

; priority means time region
; | priority | time region|
; |    A     | 9:00-12:00 |
; |    B     | 13:00-16:00|
; |    C     | 16:00-19:00|
; |    D     | 21:00-24:00|
(setq org-highest-priority ?A)
(setq org-lowest-priority ?D)
(setq org-default-priority ?A)

;; org latex setting
(setq org-latex-pdf-process
      '("latexmk %f"))
