;;; init.el -*- lexical-binding: t; -*-

(doom!
  :checkers
  grammar
  (spell +aspell)
  (syntax +childframe +flymake)

  :completion
  (corfu +icons +orderless)
  (vertico +childframe)

  :editor
  (evil +everywhere)
  file-templates
  fold
  (format +onsave +lsp)
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
  (cc +lsp +tree-sitter)
  coq
  (csharp +lsp +tree-sitter +dotnet)
  data
  emacs-lisp
  (javascript +lsp +tree-sitter)
  (json +lsp +tree-sitter)
  (lua +lsp +tree-sitter)
  (markdown +grip)
  (nix +lsp +tree-sitter)
  (org +dragndrop +pandoc +present +pretty +roam2)
  (rust +lsp +tree-sitter)
  (sh +lsp +tree-sitter)
  (web +lsp +tree-sitter)
  (yaml +lsp +tree-sitter)

  :term
  vterm

  :tools
  biblio
  direnv
  editorconfig
  (eval +overlay)
  (lookup +dictionary +docsets +offline)
  (lsp +eglot)
  (magit +forge)
  make
  pdf
  tree-sitter

  :ui
  doom
  doom-dashboard
  doom-quit
  (emoji +ascii +github +unicode)
  hl-todo
  indent-guides
  (ligatures +extra)
  modeline
  nav-flash
  neotree
  ophints
  (popup +defaults)
  vc-gutter
  vi-tilde-fringe
  window-select
  workspaces

  :config
  ;; This needs to be loaded last due to `featurep' use.
  (default +bindings +smartparens))
