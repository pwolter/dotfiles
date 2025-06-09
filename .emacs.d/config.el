;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Pablo Wolter"
      user-mail-address "pwolter@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(set-face-attribute 'default nil :font "MesloLGS NF" :weight 'regular :height 150)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)
(setq doom-themes-treemacs-theme "doom-colors")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "/Users/pwolter/iCloud/Notes/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Org-mode
(require 'org)

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-toggle-inline-images t)
(setq org-startup-with-inline-images t)

(setq org-agenda-files
  '("~/iCloud/Notes/Tasks/Tasks.org"
    "~/iCloud/Notes/Tasks/Birthdays.org"))

(setq org-todo-keywords
  '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)" "CANCELED(c)")))

(setq org-refile-targets
  '(("Archive_2022.org" :maxlevel . 1)
    ("Tasks.org" :maxlevel . 1)))

;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(setq org-capture-templates
  `(("r" "Reference" entry (file+headline "~/iCloud/Notes/Tasks/Tasks.org" "Inbox")
    "* TODO %?\n %U\n %a\n %i %t" :empty-lines 1)
  ("t" "Todo" entry (file+headline "~/iCloud/Notes/Tasks/Tasks.org" "Tasks")
    "* TODO %?\n %U\n %i" :empty-lines 1)
  ("m" "Meeting" entry (file+olp+datetree "~/iCloud/Notes/Tasks/Meetings.org")
    "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
    :empty-lines 1)
  ("i" "Note" entry (file+olp+datetree "~/iCloud/Notes/Tasks/Inbox.org")
    "* %<%I:%M %p> - %a :inbox:\n\n%?\n\n"
    :empty-lines 1)
   )
)

;; org-roam setup here
(setq org-roam-directory "/Users/pwolter/iCloud/Notes/")
;;(org-roam-db-autosync-mode)
(setq-default org-download-image-dir "~/iCloud/Notes/Attachments")

;; Python support
(use-package python-pytest)

(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))

;; C/C++
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; Latex viewer
(setq +latex-viewers '(pdf-tools))

;; ox-hugo
(use-package ox-hugo
  :after ox)

;; Visual column settings
(setq-default word-wrap t)
(setq fill-column 90)
(setq visual-fill-column-width 90)
(global-visual-fill-column-mode +1)
