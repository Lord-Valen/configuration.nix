;;; init.el -*- lexical-binding: t; -*-

(doom!
  :app
  everywhere

  :checkers
  grammar
  (spell +aspell)
  syntax

  :completion
  (company +childframe +tng)
  (vertico +childframe)

  :editor
  (evil +everywhere)
  file-templates
  fold
  (format +onsave)
  lispy
  multiple-cursors
  parinfer
  rotate-text
  snippets
  word-wrap

  :emacs
  (dired +icons)
  electric
  (ibuffer +icons)
  (undo +tree)
  vc

  :lang
  (cc +lsp)
  common-lisp
  data
  emacs-lisp
  (haskell +lsp)
  (javascript +lsp)
  (json +lsp)
  (latex +fold +lsp)
  (markdown +grip)
  (nix +lsp)
  (org +dragndrop +pandoc +present +pretty +roam2)
  (rust +lsp)
  (sh +lsp)
  (web +lsp)
  (yaml +lsp)

  :term
  vterm

  :tools
  biblio
  direnv
  editorconfig
  (eval +overlay)
  gist
  (lookup +dictionary +docsets +offline)
  (lsp +peek)
  (magit +forge)
  pdf
  rgb
  taskrunner

  :ui
  doom
  doom-dashboard
  doom-quit
  (emoji +github +unicode)
  hl-todo
  indent-guides
  (ligatures +extra)
  modeline
  nav-flash
  ophints
  (popup +defaults)
  vc-gutter
  vi-tilde-fringe
  window-select
  workspaces

  :config
  ;; This needs to be loaded last due to `featurep' use.
  (default +bindings +smartparens))
