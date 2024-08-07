(let ((minver "29"))
  (when (version< emacs-version minver)
  (error "Your Emacs is too old -- this config requires v%s or higher" minver)))

(use-package no-littering)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

(setq debug-on-error t)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("elpa" . "http://elpa.gnu.org/packages/")))  
(setq use-package-always-ensure t)

(use-package frames-only-mode)

(use-package eat)
(defun ll/open-ncspot ()
  (eat-other-window)
  (rename-buffer "ncspot" nil)
  (eat-line-send-input "ncspot")
  (vterm-send-return))

(setq
   split-width-threshold 0
   split-height-threshold nil)

(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(setq visible-bell t)
(setq inhibit-startup-message t)

(load "~/.emacs.d/colors.el")
(setq custom-theme-directory "~/.emacs.d/themes")
(set-face-attribute 'default nil :font "Mononoki Nerd Font Mono" :height 180)
(use-package all-the-icons
  :if (display-graphic-p))
(setq x-underline-at-descent-line t)

(set-frame-parameter (selected-frame) 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))

(use-package doom-modeline
:ensure t
:hook (after-init . doom-modeline-mode)
:custom ((doom-modeline-height 10)))

(use-package simple-httpd)
(use-package htmlize)

(defun ll/org-mode-setup ()
  (org-indent-mode)
  (org-modern-mode)
  (mixed-pitch-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . ll/org-mode-setup)
  :config
  (setq org-ellipsis " [x]"))

(use-package org-modern)
(use-package mixed-pitch)

(setq org-adapt-indentation t
      org-hide-leading-stars t
      org-hide-emphasis-markers t
      org-pretty-entities t)

(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "ETBembo" :height 180))))
 '(fixed-pitch ((t ( :family "Mononoki Nerd Font" )))))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
             '("fiction"
               "\\documentclass[submission,letterpaper,courier]{sffms}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
               ("\\chapter*{%s}" . "\\chapter*{%s}"))))
(setq org-latex-hyperref-template "")

(setq org-todo-keywords
      '((sequence "TODO" "HOLD" "WORKING" "REVIEW" "COMPLETE")))

(setq org-clock-in-switch-to-state "WORKING")
(setq org-clock-out-switch-to-state "TODO")

(defun ll/org-agenda-open-hook ()
  "hook ran when opening org-agenda"
  (olivetti-mode))

(add-hook 'org-agenda-mode-hook 'll/org-agenda-open-hook)
(setq org-agenda-custom-commands
      '(("d" "Today's Tasks"
	 ((agenda "" ((org-agenda-span 1)
		      (org-agenda-overriding-header "Today's Tasks")))))))

(setq org-agenda-files
      (directory-files-recursively "~/Documents/org/" "\\.org$"))

(defun ll/org-agenda-view-day ()
    (interactive)
  (org-agenda nil "d"))

(defun ll/org-agenda-view-todos ()
  (interactive)
  (org-agenda nil "t"))

(keymap-global-set "C-c d a d" #'ll/org-agenda-view-day)
(keymap-global-set "C-c d a t" #'ll/org-agenda-view-todos)



(add-hook 'org-mode-hook 'turn-on-flyspell)
;; find aspell and hunspell automatically
(cond
 ;; try hunspell at first
  ;; if hunspell does NOT exist, use aspell
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist
        ;; Please note the list `("-d" "en_US")` contains ACTUAL parameters passed to hunspell
        ;; You could use `("-d" "en_US,en_US-med")` to check with multiple dictionaries
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))

  ;; new variable `ispell-hunspell-dictionary-alist' is defined in Emacs
  ;; If it's nil, Emacs tries to automatically set up the dictionaries.
  (when (boundp 'ispell-hunspell-dictionary-alist)
    (setq ispell-hunspell-dictionary-alist ispell-local-dictionary-alist)))

 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))))

(use-package rainbow-mode)

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))
(use-package quelpa-use-package)
(use-package rustic
  :quelpa (rustic :fetcher github :repo "emacs-rustic/rustic")
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status)))
(setq rustic-format-on-save t)
(setq lsp-eldoc-hook nil)
(setq lsp-enable-symbol-highlighting nil)
(setq lsp-signature-auto-activate nil)

(use-package flycheck)
(use-package flycheck-pos-tip)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))
(flycheck-define-checker vale
  "A checker for prose"
  :command ("vale" "--output" "line"
            source)
  :standard-input nil
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ":" (id (one-or-more (not (any ":")))) ":" (message) line-end))
  :modes (markdown-mode org-mode text-mode)
  )
(add-to-list 'flycheck-checkers 'vale 'append)

(use-package company
  :custom
  (company-idle-delay 0.5)
  :bind
  (:map company-active-map
	("C-n" . company-select-next)
	("C-p" . company-select-previous)
	("M-<" . company-select-first)
	("M->" . company-select-last)))

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all nil)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-inlay-hint-enable nil)
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))


(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-doc-enable nil))
;;(setq lsp-ui-sideline-enable nil)

(define-generic-mode 'bnf-mode 
'("#") 
nil 
'(("^<.*?>" . 'font-lock-variable-name-face) 
  ("<.*?>" . 'font-lock-keyword-face) 
  ("::=" . 'font-lock-warning-face) 
  ("\|" . 'font-lock-warning-face))
'("\\.bnf\\.pybnf\\'") 
nil 
"Major mode for BNF highlighting.")

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

(use-package meow :ensure t)
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))
(require 'meow)
(meow-setup)
(meow-global-mode 1)

(use-package swiper)
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history)))
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper))
  :config
  (ivy-mode 1))
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;;ux
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))
