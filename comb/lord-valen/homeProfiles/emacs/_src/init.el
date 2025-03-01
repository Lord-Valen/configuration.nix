(setq
  inhibit-startup-message t
  visible-bell t)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(set-fringe-mode 10)
(menu-bar-mode 0)

(load-theme 'wombat)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package xdg
  :config
  (defun my/emacs-cache (&optional &rest components)
    (apply #'file-name-concat (xdg-cache-home) "emacs" components))
  (make-directory (my/emacs-cache "autosave") t)
  (make-directory (my/emacs-cache "backup") t)
  (setq auto-save-file-name-transforms `((".*" ,(file-name-concat (xdg-cache-home) "emacs/autosave/\\2") 1))
    backup-directory-alist `(("." . ,(file-name-concat (xdg-cache-home) "emacs/backup/")))
    backup-by-copying t
    delete-old-versions t
    kept-new-versions 5
    kept-old-versions 5
    version-control t
    ))
(column-number-mode)
(global-display-line-numbers-mode t)

(use-package meow
  :delight
  :demand t
  :config 
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-colemak-dh)
  (meow-motion-define-key
   ;; Use e to move up, n to move down.
   ;; Since special modes usually use n to move down, we only overwrite e here.
   '("e" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   '("?" . meow-cheatsheet)
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("1" . meow-expand-1)
   '("2" . meow-expand-2)
   '("3" . meow-expand-3)
   '("4" . meow-expand-4)
   '("5" . meow-expand-5)
   '("6" . meow-expand-6)
   '("7" . meow-expand-7)
   '("8" . meow-expand-8)
   '("9" . meow-expand-9)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("/" . meow-visit)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("e" . meow-prev)
   '("E" . meow-prev-expand)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-mark-word)
   '("H" . meow-mark-symbol)
   '("i" . meow-right)
   '("I" . meow-right-expand)
   '("j" . meow-join)
   '("k" . meow-kill)
   '("l" . meow-line)
   '("L" . meow-goto-line)
   '("m" . meow-left)
   '("M" . meow-left-expand)
   '("n" . meow-next)
   '("N" . meow-next-expand)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("r" . meow-replace)
   '("s" . meow-insert)
   '("S" . meow-open-above)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-search)
   '("w" . meow-next-word)
   '("W" . meow-next-symbol)
   '("x" . meow-delete)
   '("X" . meow-backward-delete)
   '("y" . meow-save)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore))
  (meow-global-mode 1))

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
  :init (global-corfu-mode)
  :custom
  (tab-always-indent #'complete))

;; TODO
(use-package embark)
(use-package consult)
(use-package embark-consult
  :after (embark consult)
  :demand t		   ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

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

;; lisp
(use-package lispy
  :hook (lisp-data-mode . lispy-mode))

(use-package treesit)

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package typst-ts-mode
  :straight '(:type git :host codeberg :repo "meow_king/typst-ts-mode")
  :mode "\\.typ\\'")
;; TODO
(use-package helpful)
(use-package apheleia)
(use-package eglot)
