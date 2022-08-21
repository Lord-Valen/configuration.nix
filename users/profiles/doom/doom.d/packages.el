;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.
(package! evil-colemak-basics)  ; Colemak remaps
(package! exec-path-from-shell)
(package! org-modern)           ; Fancy org-mode
(package! elcord)               ; Discord RPC. After all, why not?
(package! git-ontology-snippets ; Snippets for Michael Moreno's git commit ontology
  :recipe (:host github :repo "Lord-Valen/git-ontology-snippets.el"))
