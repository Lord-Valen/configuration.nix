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

(when (daemonp)
  (exec-path-from-shell-initialize))
(doom! :input
       ;; (layout)

       :completion
       company
       helm

       :ui
       doom
       doom-dashboard
       doom-quit
       (emoji +unicode)       ; 🙂
       hl-todo                ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       hydra
       indent-guides
       (ligatures +extra)     ; =>>>>=
       modeline
       nav-flash
       ophints
       (popup +defaults)
       tabs
       (treemacs +lsp)
       unicode
       vc-gutter
       vi-tilde-fringe
       window-select
       ;; workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       lispy
       parinfer
       snippets
       word-wrap

       :emacs
       dired
       electric
       ;; ibuffer          ; interactive buffer management
       undo
       vc

       :term
       eshell

       :checkers
       syntax
       (spell +flyspell)
       grammar

       :tools
       ;; ansible
       biblio  ; Writes a PhD for you (citation needed)
       ;; debugger          ; stepping through code, to help you add bugs
       ;; direnv
       (docker +lsp)
       editorconfig                ; let someone else argue about tabs vs spaces
       (eval +overlay)
       gist
       (lookup +dictionary)
       lsp
       (magit +forge)
       ;; make              ; run make tasks from Emacs
       ;; pass              ; password manager for nerds
       pdf
       ;; prodigy           ; managing external services & code builders
       rgb
       ;; tmux              ; an API for interacting with tmux

       :os
       (:if IS-MAC macos)
       tty                              ; improve the terminal Emacs experience

       :lang
       ;; (cc +lsp)
       common-lisp
       ;; (csharp +lsp)
       ;; data              ; config/data formats
       emacs-lisp
       ;; (ess +lsp)        ; emacs speaks statistics
       (haskell +lsp)   ; >>=
       (json +lsp)
       (javascript +lsp)
       (latex +lsp)
       ;; (lua +lsp)         ; one-based indices? one-based indices
       ;; markdown
       (nix +lsp)
       (org +roam2)
       (rust +lsp)
       (sh +lsp)
       (yaml +lsp)

       :app
       calendar
       emms
       everywhere
       irc
       (rss +org)

       :config
       literate
       (default +bindings +smartparens))
