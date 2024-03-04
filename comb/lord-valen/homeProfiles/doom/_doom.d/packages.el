;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! exec-path-from-shell)
(package! evil-colemak-basics)  ; Colemak remaps
(package! nushell-ts-mode)
(package! dash)
(package! typst-ts-mode
  :recipe (:host sourcehut :repo "meow_king/typst-ts-mode"))
