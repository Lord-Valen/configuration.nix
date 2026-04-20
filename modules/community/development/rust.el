;;; -*- lexical-binding: t; -*-
(use-package rust-mode
  :mode "\\.rs\\'"
  :custom
  (rust-mode-treesitter-derive t)
  )
(provide 'rust)
