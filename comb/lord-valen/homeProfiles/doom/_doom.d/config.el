;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Lord Valen"
      user-mail-address "lord_valen@pm.me")

(setq shell-file-name "nu")

(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font Propo")
      doom-unicode-font (font-spec :family "Noto Color Emoji")
      doom-big-font-increment 8)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-themes-enable-bold t
      doom-themes-enable-italic t
      global-prettify-symbols-mode t
      doom-theme 'doom-outrun-electric)

(setq ispell-dictionary "en_CA")

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
  :after dash
  :config
  (--map (add-to-list 'eglot-server-programs it)
         `((nix-mode . ,(eglot-alternatives '("nil" "nixd")))
           (conf-toml-mode . ("taplo" "lsp" "stdio"))
           (csharp-mode . ("OmniSharp" "-lsp"))
           ((rjsx-mode typescript-tsx-mode) . ("typescript-language-server" "--stdio"))))
  (add-hook! (conf-toml-mode rjsx-mode typescript-tsx-mode) #'lsp!))

(use-package! format-all
  :config
  (set-formatter! 'alejandra "alejandra --quiet" :modes '(nix-mode)))

(use-package! elcord
  :custom
  (elcord-use-major-mode-as-main-icon t)
  :config
  (add-to-list 'elcord-mode-icon-alist '(emacs-lisp-mode . "emacs_icon"))
  (elcord-mode))

(use-package! langtool
  :custom
  (langtool-bin "languagetool-commandline")
  (langtool-default-language "en-CA"))

(use-package! parinfer-rust-mode
  :custom
  (parinfer-rust-preferred-mode "paren"))

(use-package! projectile
  :custom
  (projectile-project-search-path `((,(file-truename "~/dev") . 1))))

(use-package! org-modern
  :config
  (global-org-modern-mode))

(use-package! org-roam
  :custom
  (org-roam-directory (file-truename "~/dev/knowledge-base"))
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head
               "${slug}.org"
               "#+title: ${title}\n")
      :unnarrowed t)
     ("s" "seedling" plain
       "%?"
       :if-new (file+head
                 "${slug}.org"
                 "#+title: ${title}\n"
                 "#+filetags: 🌱\n")
       :unnarrowed t)
     ("e" "evergreen" plain
      "%?"
      :if-new (file+head
                "${slug}.org"
                "#+title: ${title}\n"
                "#+filetags: 🌲\n")
      :unnarrowed t)
     ("p" "person" plain
      "%?"
      :if-new (file+head
                "people/${slug}.org"
                "#+title: ${title}\n"
                "#+filetags: 👨\n")
      :unnarrowed t)
     ("g" "group" plain
      "%?"
      :if-new (file+head
                "groups/${slug}.org"
                "#+title: ${title}\n"
                "#+filetags: 🏢\n")
      :unnarrowed t)
     ("w" "work" plain
      "%?"
      :if-new (file+head
                "works/${slug}.org"
                "#+title: ${title}\n"
                "#+filetags: 📜\n")
      :unnarrowed t)
     ("t" "project" plain
      "* Goals\n\n%?\n\n* Tasks\n\n* Dates"
      :if-new (file+head
                "projects/${slug}.org"
                "#+title: ${title}\n"
                "#+category: ${title}\n"
                "#+filetags: 🛠\n")
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
\\usepackage[notes]{biblatex-chicago}
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
\\usepackage{doi}"
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
