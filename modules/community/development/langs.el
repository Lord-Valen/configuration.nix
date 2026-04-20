;;; -*- lexical-binding: t; -*-
(use-package eglot
  :ensure nil)
(use-package treesit-auto
  :hook
  (emacs-startup . global-treesit-auto-mode))
(provide 'langs)
