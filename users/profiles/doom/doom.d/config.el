;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Lord Valen"
      user-mail-address "lord_valen@pm.me")

(setq shell-file-name "bash")

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font")
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 18)
      doom-unicode-font doom-font)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-themes-enable-bold t
      doom-themes-enable-italic t
      global-prettify-symbols-mode t
      doom-theme 'doom-outrun-electric)

(plist-put! +ligatures-extra-symbols
            ;; Types
            :true       "⊤"
            :false      "⊥")

(use-package! evil-colemak-basics
  :after evil
  :init
  (setq evil-colemak-basics-layout-mod `mod-dh)
  :config
  (global-evil-colemak-basics-mode))

(use-package! elcord
  :config
  (add-to-list 'elcord-mode-icon-alist '(emacs-lisp-mode . "emacs_icon"))
  (setq elcord-use-major-mode-as-main-icon t)
  (elcord-mode))

(use-package! eww
  :config
  (setq browse-url-browser-function 'eww-browse-url
        browse-url-secondary-browser-function 'browse-url-default-browser))

(use-package! lsp-mode
  :config
  (add-to-list 'lsp-language-id-configuration '(nix-mode . "nil"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "nil")
                    :activation-fn (lsp-activate-on "nil")
                    :server-id 'nil-ls)))

(use-package! projectile
  :config
  (setq projectile-project-search-path '(("~/dev" . 1))))

(use-package! org
  :config
  (setq org-directory "~/org-roam/"
        org-agenda-files '("~/org-roam/agenda.org"))
  (add-hook 'org-mode-hook #'org-modern-mode))

(use-package! ox-latex
  :after org
  :init
  :config
  (setq org-export-headline-levels 5
        org-export-with-section-numbers nil)
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
(setq org-latex-hyperref-template nil
      org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "xmpi" "run.xml" "bcf" "acn" "acr" "alg" "glg" "gls" "ist")))
