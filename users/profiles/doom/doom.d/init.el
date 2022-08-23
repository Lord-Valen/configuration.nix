;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(when (daemonp) (exec-path-from-shell-initialize))
(doom!
  :app
  calendar
  everywhere
  (rss +org)

  :checkers
  grammar
  (spell +aspell)
  syntax

  :completion
  company
  vertico

  :config
  (default +bindings +smartparens)
  literate

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
  (haskell +lsp)                        ; >>=
  (javascript +lsp)
  (json +lsp)
  (latex +fold +lsp)
  markdown
  (nix +lsp)
  (org +dragndrop +pandoc +roam2)
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
  (emoji +github +unicode)              ; 🙂
  hl-todo                               ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
  indent-guides
  (ligatures +extra)                    ; =>>>>=
  modeline
  nav-flash
  ophints
  (popup +defaults)
  tabs
  unicode
  vc-gutter
  vi-tilde-fringe
  window-select
  workspaces)
