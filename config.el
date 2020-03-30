;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Robert Stuttaford"
      user-mail-address "robert@cognician.com")

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
(setq doom-font (font-spec :family "JetBrains Mono" :size 16))

(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               (123 . ".\\(?:-\\)")
               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)"))))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'sanityinc-tomorrow-night)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(map! "s-x" #'kill-region
      "s-[" #'centaur-tabs-backward
      "s-]" #'centaur-tabs-forward

      [f1]
      (lambda () (interactive) 
        (find-file "~/Code/Cognician/Monolith/dev/scratch/robert.clj"))

      [f2]
      (lambda () (interactive) 
        (find-file "~/Code/Cognician/Base/src/cognician/base/models/program.cljc"))

      [M-f1] #'cider-repl-clear-buffer

      [f3] #'cider-format-edn-region

      [f4]  #'magit-status

      [f6]  #'highlight-regexp
      [M-f6] #'unhighlight-regexp

      [f11]
      (lambda () (interactive) 
        (find-file "~/.clojure/deps.edn"))

      [f12]
      (lambda () (interactive) 
        (find-file "~/.doom.d/config.el"))

      [C-M-f8]
      (lambda () (interactive)
        (cider-connect '(:host "localhost" :port 7888)))

      [C-f8]
      (lambda () (interactive)
        (cider-connect
         (plist-put '(:host "localhost")
                    :port (second (first (cider-locate-running-nrepl-ports))))))

      "C-M-g" #'git-link

      ;; hide/show
      "C-."     #'hs-toggle-hiding
      "C-,"     #'hs-hide-all
      "C-x C-," #'hs-show-all

      ;; Swap current buffer with buffer in direction of arrow
      [M-s-right] #'buf-move-right
      [M-s-left]  #'buf-move-left
      [M-s-up]    #'buf-move-up
      [M-s-down]  #'buf-move-down

      ;; Move active cursor to window
      [C-s-left] #'windmove-left
      [C-s-right] #'windmove-right
      [C-s-up] #'windmove-up
      [C-s-down] #'windmove-down
      )

(add-hook 'clojure-mode-hook
          (lambda ()
            (idle-highlight-mode t)
            (paredit-mode 1)
            (clj-refactor-mode 1)
            (cljr-add-keybindings-with-prefix "s-r")))
