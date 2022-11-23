;;; init.el -*- lexical-binding: t; -*-

(when (daemonp) (exec-path-from-shell-initialize))
(doom!
  :app
  calendar
  everywhere

  :checkers
  grammar
  (spell +aspell)
  syntax

  :completion
  company
  vertico

  :config
  (default +bindings +smartparens)

  :editor
  (evil +everywhere)
  file-templates
  fold
  (format +onsave)
  lispy
  multiple-cursors
  rotate-text
  parinfer
  snippets
  word-wrap

  :emacs
  (dired +icons)
  electric
  (ibuffer +icons)
  (undo +tree)
  vc

  :lang
  common-lisp
  data
  emacs-lisp
  (haskell +lsp)
  (javascript +lsp)
  (json +lsp)
  (latex +fold +lsp)
  markdown
  (nix +lsp)
  (org +dragndrop +pandoc)
  (rust +lsp)
  (sh +lsp)
  (web +lsp)
  (yaml +lsp)

  :os
  tty

  :term
  eshell

  :tools
  biblio
  direnv
  editorconfig
  (eval +overlay)
  gist
  (lookup +dictionary +offline)
  lsp
  (magit +forge)
  pdf
  rgb
  taskrunner

  :ui
  doom
  doom-dashboard
  doom-quit
  (emoji +github +unicode)    ; :rocket: 🙂
  hl-todo                     ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
  indent-guides
  (ligatures +extra)                    ; =>>>>=
  modeline
  nav-flash
  ophints
  (popup +defaults)
  tabs
  vc-gutter
  vi-tilde-fringe
  window-select
  workspaces)
