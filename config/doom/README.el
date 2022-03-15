;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(defmacro :hook (hook-name &rest body)
  "A simple wrapper around `add-hook'"
  (declare (indent defun))
  (let* ((hook-name (format "%s-hook" (symbol-name hook-name)))
         (hook-sym (intern hook-name))
         (first (car body))
         (local (eq :local first))
         (body (if local (cdr body) body))
         (first (car body))
         (body (if (consp first)
                   (if (eq (car first) 'quote)
                       first
                     `(lambda () ,@body))
                 `',first)))
    `(add-hook ',hook-sym ,body nil ,local)))

(defun mine/latex-headers (headers)
  (mapconcat (function (lambda (x) (format "#+LATEX_HEADER: %s" x))) headers "\n"))

(setq user-full-name "Lord Valen"
      user-mail-address "lord_valen@pm.me")
(setq shell-file-name "bash")

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font")
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 18))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-themes-enable-bold t
      doom-themes-enable-italic t
      global-prettify-symbols-mode t
      doom-theme 'doom-outrun-electric)

(use-package! evil-colemak-basics
  :after evil
  :init
  (setq evil-colemak-basics-layout-mod `mod-dh)
  :config
  (global-evil-colemak-basics-mode))

(use-package! elfeed-org
 :config
 (setq rmh-elfeed-org-files (--map substitute-env-in-file-name (list "$XDG_CONFIG_HOME/doom/elfeed.org"))
       elfeed-search-filter "@1-week-ago +unread ")
 (add-hook 'elfeed-new-entry-hook (elfeed-make-tagger :before "2 weeks ago" :remove 'unread))
 (add-hook 'elfeed-search-mode-hook 'elfeed-update))

(use-package! eww
  :config
  (setq browse-url-browser-function 'eww-browse-url
        browse-url-secondary-browser-function 'browse-url-default-browser))

(setq creds "$XDG_CONFIG_HOME/doom/creds.el"
      nick "lord-valen")
(defun pass (server) (with-temp-buffer
                        (insert-file-contents-literally creds)
                        (plist-get (read (buffer-string)) :pass)))

(setq circe-network-options
      '(("Freenode" :host "chat.freenode.net" :port (6667 . 6697)
         :tls t
         :nick nick
         :sasl-username nick
         :sasl-password pass
         :channels ("#philosophy"
                    "#idleRPG"
                    "#physics"
                    "#science"
                    "#emacs"
                    "#"))))

(setq circe-format-say "{nick:-16s}> {body}"
      circe-format-self-say "{nick:-16s}> {body}"
      circe-format-message "{nick:-16s} => {chattarget}> {body}"
      circe-format-self-message "{nick:-16s} => {chattarget}> {body}")

(add-hook 'circe-chat-mode-hook 'my-circe-prompt)
(defun my-circe-prompt ()
  (lui-set-prompt
   (concat (propertize (concat (buffer-name) ">")
                       'face 'circe-prompt-face)
           " ")))

(setq circe-reduce-lurker-spam t)

(use-package! projectile
  :config
  (setq projectile-project-root-files-bottom-up (remove ".git" projectile-project-root-files-bottom-up)
        projectile-project-search-path '(("~/dev" . 1))))

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
  (--map (add-to-list 'org-latex-classes it) '(("chicago" "\\documentclass[letterpaper,12pt]{article}
[DEFAULT-PACKAGES]
\\usepackage{newtxtext}
\\usepackage{url}
\\usepackage{doi}
\\usepackage[notes,backend=biber]{biblatex-chicago}
\\usepackage[margin=1in]{geometry}
\\doublespacing
\\addbibresource{./lib.bib}
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
[DEFAULT-PACKAGES]
\\usepackage{newtxtext}
\\usepackage{url}
\\usepackage{doi}
\\addbibresource{./lib.bib}"
                                                ("\\section{%s}" . "\\section*{%s}")
                                                ("\\subsection{%s}" . "\\subsection*{%s}")
                                                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                                                ("\\subsubparagraph{%s}" . "\\subsubparagraph*{%s}")))))
(setq org-latex-hyperref-template nil) ;; stop org adding hypersetup{author..} to latex export
;; (setq org-latex-prefer-user-labels t)
;; deleted unwanted file extensions after latexMK
(setq org-latex-logfiles-extensions
      (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "xmpi" "run.xml" "bcf" "acn" "acr" "alg" "glg" "gls" "ist")))

(use-package! org-roam
  :after org
  :config
  (setq org-roam-directory (file-truename "~/org-roam")
        org-roam-db-location (file-truename "~/org-roam/org-roam.db")
        org-roam-capture-templates '(("d" "default" plain
                                      :target (file+head "${slug}.org" "#+TITLE: ${title}\n")
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

(use-package! org-ref
    :after org
    :config
    (setq org-ref-default-citation-link "autocite"
          bibtex-completion-bibliography '("~/org-roam/lib.bib")
          bibtex-dialect 'biblatex))
(use-package! helm-bibtex
  :after org
  :config
  (add-to-list 'org-capture-templates
               '(("a"                   ; key
                  "Article"             ; name
                  entry                 ; type
                                        ;(file+headline (concatenate 'string org-directory "/foo.org) "Article")  ; target
                  "\* %^{Title} %(org-set-tags)  :article: \n:PROPERTIES:\n:Created: %U\n:Linked: %a\n:END:\n%i\nBrief description:\n%?" ; template
                  :prepend t            ; properties
                  :empty-lines 1        ; properties
                  :created t            ; properties
                  ))))
