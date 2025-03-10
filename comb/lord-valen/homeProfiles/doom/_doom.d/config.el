;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Load home-manager's `extraConfig'
;;(load! "extraConfig.el")

(setq
  user-full-name "Lord Valen"
  user-mail-address "lord_valen@pm.me")

;; Doom reload doesn't work with nushell
(setq shell-file-name "bash")

(setq
 nerd-icons-font-names '("SymbolsNerdFontMono-Regular.ttf")
 doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 16)
 doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font Propo")
 doom-symbol-font (font-spec :family "Noto Color Emoji")
 doom-big-font-increment 8)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq
  doom-themes-enable-bold t
  doom-themes-enable-italic t
  global-prettify-symbols-mode t)

(setq ispell-dictionary "english")

(plist-put! +ligatures-extra-symbols
            ;; Types
            :true       "⊤"
            :false      "⊥")

(use-package! evil-colemak-basics
  :after evil
  :custom
  (evil-colemak-basics-layout-mod `mod-dh)
  :config
  (global-evil-colemak-basics-mode))

(use-package! eglot
  :after dash typst-ts-mode
  :config
  (--map (add-to-list 'eglot-server-programs it)
    `((nix-mode . ("nixd" :initializationOptions (:formatter (:command ["nixfmt"]))))
      (conf-toml-mode . ("taplo" "lsp" "stdio"))
      (csharp-mode . ("OmniSharp" "-lsp"))
      ((rjsx-mode typescript-tsx-mode) . ("typescript-language-server" "--stdio"))
      (typst-ts-mode . ("tinymist"))))

  (add-hook! (conf-toml-mode rjsx-mode typescript-tsx-mode typst-ts-mode) #'lsp!))

(use-package! langtool
  :custom
  (langtool-bin "languagetool-commandline")
  (langtool-default-language "en-CA"))

(use-package! nov
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package! parinfer-rust-mode
  :custom
  (parinfer-rust-preferred-mode "paren"))

(use-package! projectile
  :custom
  (projectile-project-search-path `((,(file-truename "~/dev") . 3)))
  (projectile-indexing-method 'alien))

(use-package! typst-ts-mode
  :after apheleia
  :config
  (set-formatter! 'typstyle '("typstyle") :modes '(typst-ts-mode))

  :custom
  (typst-ts-mode-watch-options "--open"))

(use-package! org-roam
  :custom
  (org-roam-directory (file-truename "~/dev/github/Lord-Valen/knowledge-base"))
  (citar-bibliography `(,(file-name-concat org-roam-directory "lib.bib")))
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head
               "${slug}.org"
               "${title}\n")
      :unnarrowed t)
     ("s" "seedling" plain
      "%?"
      :if-new (file+head
               "${slug}.org"
               "${title}\n#+filetags: 🌱\n")
      :unnarrowed t)
     ("e" "evergreen" plain
      "%?"
      :if-new (file+head
               "${slug}.org"
               "${title}\n#+filetags: 🌲\n")
      :unnarrowed t)
     ("p" "person" plain
      "%?"
      :if-new (file+head
               "people/${slug}.org"
               "${title}\n#+filetags: 👨\n")
      :unnarrowed t)
     ("g" "group" plain
      "%?"
      :if-new (file+head
               "groups/${slug}.org"
               "${title}\n#+filetags: 🏢\n")
      :unnarrowed t)
     ("w" "work" plain
      "%?"
      :if-new (file+head
               "works/${slug}.org"
               "${title}\n#+filetags: 📜\n")
      :unnarrowed t)
     ("t" "project" plain
      "* Goals\n\n%?\n\n* Tasks\n\n* Dates"
      :if-new (file+head
               "projects/${slug}.org"
               "${title}\n#+category: ${title}\n#+filetags: 🛠\n")
      :unnarrowed t)))
  :config
  (map! :leader
        "n r I" #'my/org-roam-node-insert-immediate))

(defun my/org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let
      ((args (cons arg args))
       (org-roam-capture-templates (list (append
                                          (car org-roam-capture-templates)
                                          '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(use-package! ox-latex
  :after org dash
  :custom
  (org-export-headline-levels 5)
  (org-export-with-section-numbers nil)
  (org-latex-hyperref-template nil)
  :config
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines))
  (--map (add-to-list 'org-latex-classes it)
         '(("chicago"
            "\\documentclass[letterpaper,12pt]{article}
[PACKAGES]
\\usepackage{newtxtext}
\\usepackage{url}
\\usepackage{doi}
\\usepackage{ellipsis}
\\usepackage{csquotes}
\\usepackage[notes,backend=biber]{biblatex-chicago}
\\usepackage[margin=1in]{geometry}
"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
            ("\\subsubparagraph{%s}" . "\\subsubparagraph*{%s}"))
           ("turabian"
            "\\documentclass{turabian-researchpaper}
[PACKAGES]
\\usepackage{newtxtext}
\\usepackage{url}
\\usepackage{doi}
\\usepackage{ellipsis}
\\usepackage{csquotes}
\\usepackage[notes,backend=biber]{biblatex-chicago}
\\usepackage{turabian-formatting}
"
            ("\\section{%s}" . "\\section{%s}")
            ("\\subsection{%s}" . "\\subsection{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection{%s}")
            ("\\paragraph{%s}" . "\\paragraph{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph{%s}")
            ("\\subsubparagraph{%s}" . "\\subsubparagraph{%s}"))
           ("apa"
            "\\documentclass[stu,biblatex,12pt]{apa7}
[PACKAGES]
\\usepackage{newtxtext}
\\usepackage{url}
\\usepackage{doi}
\\usepackage{ellipsis}
\\usepackage{csquotes}
"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
            ("\\subsubparagraph{%s}" . "\\subsubparagraph*{%s}"))
           ("altacv"
            "\\documentclass[10pt,letterpaper,ragged2e,withhyper]{altacv}
[PACKAGES]
\\usepackage{paracol}
\\usepackage[rm]{roboto}
\\usepackage[defaultsans]{lato}

[EXTRA]
% Page layout
\\geometry{left=1.25cm,right=1.25cm,top=1.5cm,bottom=1cm,columnsep=0.5cm}

% Use roboto and lato for fonts
\\renewcommand{\\familydefault}{\\sfdefault}

% Fonts
\\renewcommand{\\namefont}{\\Huge\\rmfamily\\bfseries}
\\renewcommand{\\personalinfofont}{\\footnotesize}
\\renewcommand{\\cvsectionfont}{\\LARGE\\rmfamily\\bfseries}
\\renewcommand{\\cvsubsectionfont}{\\large\\bfseries}

% Colours
\\definecolor{SlateGrey}{HTML}{2E2E2E}
\\definecolor{LightGrey}{HTML}{666666}
\\definecolor{DarkPastelRed}{HTML}{450808}
\\definecolor{PastelRed}{HTML}{8F0D0D}
\\definecolor{GoldenEarth}{HTML}{E7D192}

\\colorlet{name}{black}
\\colorlet{tagline}{PastelRed}
\\colorlet{heading}{DarkPastelRed}
\\colorlet{headingrule}{GoldenEarth}
\\colorlet{subheading}{PastelRed}
\\colorlet{accent}{PastelRed}
\\colorlet{emphasis}{SlateGrey}
\\colorlet{body}{LightGrey}

% Change the bullets for itemize and rating marker for \\cvskill
\\renewcommand{\\itemmarker}{{\\small\\textbullet}}
\\renewcommand{\\ratingmarker}{\\faCircle}
"
            ("\\cvsection{%s}" . "\\cvsection{%s}")))))
