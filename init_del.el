(use-package org-gcal
  :straight t
  :config
  (setq org-gcal-remove-api-cancelled-events t))

(use-package org-roam
  :ensure t
  :hook (after-init . org-roam-mode)
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Dropbox/Roam")
  (org-roam-completion-everywhere t)
  (org-roam-completion-system 'ivy)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("l" "programming language" plain
      "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference:\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
      :unnarrowed t)))
  :config
  (org-roam-setup))

(org-agenda-to-appt)             ;; generate the appt list from org agenda files on emacs launch
(run-at-time "24:01" 3600 'org-agenda-to-appt)           ;; update appt list hourly
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt) ;; update appt list on agenda view

    (org-babel-do-load-languages
     'org-babel-load-languages
     '((C . t)
       (emacs-lisp . t)
       (gnuplot . t)
       (latex . t)
       (makefile . t)
       (js . t)
       (rust . t)
       (solidity . t)
       (plantuml . t)
       (python . t)
       (sass . t)
       (shell . t)
       (sql . t))
     )

(use-package parinfer-rust-mode
  :defer t
  :straight (:build t)
  :diminish parinfer-rust-mode
  :hook emacs-lisp-mode common-lisp-mode scheme-mode
  :init
  (setq parinfer-rust-auto-download     t
        parinfer-rust-library-directory (concat user-emacs-directory
                                                "parinfer-rust/"))
  (add-hook 'parinfer-rust-mode-hook
            (lambda () (smartparens-mode -1)))
  :general
  (dqv/major-leader-key
    :keymaps 'parinfer-rust-mode-map
    "m" #'parinfer-rust-switch-mode
    "M" #'parinfer-rust-toggle-disable))

(straight-use-package '(use-package :build t))

(use-package eshell-info-banner
  :after (eshell)
  :defer t
  :straight (eshell-info-banner :build t
                                :type git
                                :host github
                                :protocol ssh
                                :repo "phundrak/eshell-info-banner.el")
  :hook (eshell-banner-load . eshell-info-banner-update-banner)
  :config
  (setq eshell-info-banner-width 80
        eshell-info-banner-partition-prefixes '("/dev" "zroot" "tank")))