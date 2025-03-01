(setq
  inhibit-startup-message t
  visible-bell t)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(set-fringe-mode 10)
(menu-bar-mode 0)

(load-theme 'wombat)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(require 'package)

(setq package-archives '(("elpa" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(setq backup-directory-alist `(("." . "~/.local/cache/emacs/backup/"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 5
      kept-old-versions 5
      version-control t
      )
(column-number-mode)
(global-display-line-numbers-mode t)

(use-package meow)

(use-package command-log-mode
  :delight
  :config (global-command-log-mode))

;; completion
(use-package vertico
  :delight
  :init (vertico-mode))
(use-package savehist
  :delight
  :init (savehist-mode))
(use-package marginalia
  :delight
  :init (marginalia-mode)
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle)))
(use-package corfu
  :delight
  :init (global-corfu-mode))
(use-package embark)
(use-package consult)
(use-package embark-consult
  :after (embark consult)
  :demand t		   ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package orderless)

(use-package which-key
  :delight
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

(use-package doom-modeline
  :init (doom-modeline-mode))

(use-package rainbow-delimiters
  :delight
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package projectile)

;; lisp
(use-package lispy
  :hook (lisp-data-mode . lispy-mode))

(use-package helpful)

(use-package apheleia)
(use-package eglot)
