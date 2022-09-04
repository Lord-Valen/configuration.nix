;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(defun mine/latex-headers (headers)
  (mapconcat (function (lambda (x) (format "#+LATEX_HEADER: %s" x))) headers "\n"))

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

(use-package! elfeed-org
 :config
 (setq rmh-elfeed-org-files (--map (substitute-env-in-file-name it) (list "$XDG_CONFIG_HOME/doom/elfeed.org"))
       elfeed-search-filter "@1-week-ago +unread ")
 (add-hook 'elfeed-new-entry-hook (elfeed-make-tagger :before "2 weeks ago" :remove 'unread))
 (add-hook 'elfeed-search-mode-hook 'elfeed-update))

(use-package! eww
  :config
  (setq browse-url-browser-function 'eww-browse-url
        browse-url-secondary-browser-function 'browse-url-default-browser))

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
         '(("chicago" "\\documentclass[letterpaper,12pt]{article}
[PACKAGES]
\\usepackage{newtxtext}
\\usepackage{url}
\\usepackage{doi}
\\usepackage[notes,backend=biber]{biblatex-chicago}
\\usepackage[margin=1in]{geometry}

[EXTRA]
\\doublespacing
\\makeatletter
\\newcommand\\@mymakefnmark{\\normalfont\\@thefnmark.\\hfill}
\\renewcommand\\@makefntext[1]{%
    \\parindent 1em%
    \\noindent
    \\hb@xt@1.8em{\\hss\\@mymakefnmark}\\RaggedRight#1}
\\def\\studentnum#1{\\gdef\\@studentnum{#1}}
\\def\\course#1{\\gdef\\@course{#1}}
\\def\\instructor#1{\\gdef\\@instructor{#1}}
\\def\\institution#1{\\gdef\\@affiliation{#1}}
\\renewcommand{\\maketitle}{
\\begin{titlepage}
\\begin{center}
\\null
\\vfill
\\@title \\\\
\\@subtitle \\\\
\\vfill
\\@author \\\\
\\@studentnum \\\\
\\@course \\\\
\\@coursenum \\\\
\\@coursesec \\\\
\\@instructor \\\\
\\@institution \\\\
\\@date \\\\
\\vfill
\\end{center}
\\end{titlepage}}
\\makeatother"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
            ("\\subsubparagraph{%s}" . "\\subsubparagraph*{%s}"))

           ("apa" "\\documentclass[stu,biblatex,12pt]{apa7}
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

           '("altacv" "\\documentclass[10pt,letterpaper,ragged2e,withhyper]{altacv}
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

(use-package! org-roam
  :after org
  :config
  (setq org-roam-directory (file-truename "~/org-roam")
        org-roam-db-location (file-truename "~/org-roam/org-roam.db")
        org-roam-capture-templates '(("d" "default" plain "%?"
                                      :if-new (file+head "${slug}.org" "#+TITLE: ${title}")
                                      :unnarrowed t))
        org-roam-extract-new-file-path "${slug}.org")
  (cl-defmethod org-roam-node-slug (node org-roam-node)
    (let ((title (org-roam-node-title node))
          (slug-trim-chars '(;; Combining Diacritical Marks https://www.unicode.org/charts/PDF/U0300.pdf
                             768            ; U+0300 COMBINING GRAVE ACCENT
                             769            ; U+0301 COMBINING ACUTE ACCENT
                             770            ; U+0302 COMBINING CIRCUMFLEX ACCENT
                             771            ; U+0303 COMBINING TILDE
                             772            ; U+0304 COMBINING MACRON
                             774            ; U+0306 COMBINING BREVE
                             775            ; U+0307 COMBINING DOT ABOVE
                             776            ; U+0308 COMBINING DIAERESIS
                             777            ; U+0309 COMBINING HOOK ABOVE
                             778            ; U+030A COMBINING RING ABOVE
                             780            ; U+030C COMBINING CARON
                             795            ; U+031B COMBINING HORN
                             803            ; U+0323 COMBINING DOT BELOW
                             804            ; U+0324 COMBINING DIAERESIS BELOW
                             805            ; U+0325 COMBINING RING BELOW
                             807            ; U+0327 COMBINING CEDILLA
                             813      ; U+032D COMBINING CIRCUMFLEX ACCENT BELOW
                             814      ; U+032E COMBINING BREVE BELOW
                             816      ; U+0330 COMBINING TILDE BELOW
                             817)))   ; U+0331 COMBINING MACRON BELOW
      (cl-flet* ((nonspacing-mark-p (char)
                                    (memq char slug-trim-chars))
                 (strip-nonspacing-marks (s)
                                         (ucs-normalize-NFC-string
                                          (apply #'string (seq-remove #'nonspacing-mark-p
                                                                      (ucs-normalize-NFD-string s)))))
                 (cl-replace (title pair)
                             (replace-regexp-in-string (car pair) (cdr pair) title)))
        (let* ((pairs `(("[^[:alnum:][:digit:]]" . "-")
                        ("--*" . "-")
                        ("^-" . "")
                        ("-$" . "")))
               (slug (-reduce-from #'cl-replace (strip-nonspacing-marks title) pairs)))
          (downcase slug)))))
  ;; for org-roam-buffer-toggle
  ;; Use side-window like V1
  ;; This can take advantage of slots available with it
  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
                 (display-buffer-in-side-window)
                 (side . right)
                 (slot . 0)
                 (window-width . 0.25)
                 (preserve-size . (t nil))
                 (window-parameters . ((no-other-window . t)
                                       (no-delete-other-windows . t))))))
