;;; init.el -*- lexical-binding:t ; -*-
(use-package use-package
  :demand t
  :preface
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))
  :custom
  (use-package-always-ensure t)
  (use-package-always-defer t)
  (use-package-compute-statistics t))

(use-package no-littering
  :demand t
  :config
  (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  (no-littering-theme-backups))

(use-package meow
  :delight
  :demand t
  :custom
  (meow-cheatsheet-layout meow-cheetsheet-layout-colemak-dh)
  :config
  (meow-define-keys
      'motion
    ;; Use e to move up, n to move down.
    ;; Since special modes usually use n to move down, we only overwrite e here.
    '("e" . meow-prev)
    '("<escape>" . ignore))
  (meow-define-keys 'leader
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
  (meow-define-keys 'normal
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

(use-package emacs
  :demand t
  :bind
  (("C-c k b" . kill-current-buffer))
  :custom
  (visible-bell t)
  (scroll-step 10)
  ;; startup
  (inhibit-startup-message t)
  ;; files
  (backup-by-copying t)
  (delete-old-versions t)
  (kept-new-versions 5)
  (kept-old-versions 5)
  (version-control t)
  :config
  (indent-tabs-mode 0)
  (column-number-mode)
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (tooltip-mode 0)
  (menu-bar-mode 0)
  (set-fringe-mode 10)
  (global-display-line-numbers-mode t))

(use-package command-log-mode
  :delight
  :bind (("C-c l" . clm/toggle-command-log-buffer))
  :config (global-command-log-mode))

;; completion
(use-package vertico
  :delight
  :demand t
  :init (vertico-mode))
(use-package savehist
  :delight
  :demand t
  :init (savehist-mode))
(use-package marginalia
  :delight
  :demand t
  :init (marginalia-mode)
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle)))
(use-package corfu
  :delight
  :demand t
  :init (global-corfu-mode)
  :custom
  (tab-always-indent #'complete))

;; TODO
(use-package embark)
(use-package consult)
(use-package embark-consult
  :after (embark consult)
  :demand t                ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package orderless
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package helpful
  :bind (
         ("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)
         ("C-c d" . helpful-at-point)))

(use-package which-key
  :delight
  :demand t
  :init (which-key-mode)
  :custom
  (which-key-idle-delay 0.3))

(use-package doom-modeline
  :delight
  :demand t
  :init (doom-modeline-mode))

(use-package rainbow-delimiters
  :delight
  :hook (prog-mode . rainbow-delimiters-mode))

;; lisp
(use-package lispy
  :hook (lisp-data-mode . lispy-mode))

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package typst-ts-mode
  :mode "\\.typ\\'")

(use-package gdscript-mode
  :mode "\\.gd\\'")

(use-package treesit-auto
  :config
  (global-treesit-auto-mode))

(use-package apheleia
  :init (apheleia-global-mode))
(use-package treemacs
  :bind ("C-c t" . treemacs))
(use-package eglot)
