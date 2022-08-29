(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "http://elpa.gnu.org/packages/")))

;; Install packages if they don't exist
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package)
       (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Basic UI config
(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-frame-font "Monaco 13")
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(global-hl-line-mode)

(setq default-directory "~/")
(setq scroll-conservatively 10)
(setq scroll-margin 7)
(setq-default tab-width 4)

;; Hooks
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(with-eval-after-load 'evil-maps
  ;; Files
  (define-key evil-normal-state-map (kbd "<SPC> f o") 'find-file)
  (define-key evil-normal-state-map (kbd "<SPC> f s") 'save-buffer)
  (define-key evil-normal-state-map (kbd "<SPC> f r") 'helm-recentf)
  ;; Buffer
  (define-key evil-normal-state-map (kbd "<SPC> b q") 'kill-buffer)
  (define-key evil-normal-state-map (kbd "<SPC> b e") 'eval-buffer)
  (define-key evil-normal-state-map (kbd "<SPC> r") 'query-replace)
  ;; Helm swoop
  (define-key evil-normal-state-map (kbd "<SPC> s") 'helm-swoop)
  ;; Windows and buffers
  (define-key evil-normal-state-map (kbd "<SPC> w v") 'split-window-horizontally)
  (define-key evil-normal-state-map (kbd "<SPC> w w") 'other-window)
  (define-key evil-normal-state-map (kbd "<SPC> w s") 'split-window-vertically)
  (define-key evil-normal-state-map (kbd "<SPC> w q") 'kill-buffer-and-window)
  (define-key evil-normal-state-map (kbd "<SPC> w l") 'windmove-right)
  (define-key evil-normal-state-map (kbd "<SPC> w h") 'windmove-left)
  (define-key evil-normal-state-map (kbd "<SPC> w k") 'windmove-up)
  (define-key evil-normal-state-map (kbd "<SPC> w j") 'windmove-down)
  (define-key evil-normal-state-map (kbd "<SPC> b n") 'switch-to-next-buffer)
  (define-key evil-normal-state-map (kbd "<SPC> b p") 'switch-to-prev-buffer)
  ;; LSP
  (define-key evil-normal-state-map (kbd "<SPC> l r") 'lsp-rename)
  (define-key evil-normal-state-map (kbd "<SPC> l j") 'lsp-find-definition)
  (define-key evil-normal-state-map (kbd "<SPC> l d") 'lsp-find-declaration)
  ;; Projectile
  (define-key evil-normal-state-map (kbd "<SPC> p") 'projectile-command-map)
  ;; Dired
  (define-key evil-normal-state-map (kbd "<SPC> d") 'dired)
  ;; Magit
  (define-key evil-normal-state-map (kbd "<SPC> g s") 'magit-status)
  (define-key evil-normal-state-map (kbd "<SPC> g l") 'magit-log)
  (define-key evil-normal-state-map (kbd "<SPC> g r") 'magit-revert)
  (define-key evil-normal-state-map (kbd "<SPC> g c") 'magit-commit)
  (define-key evil-normal-state-map (kbd "<SPC> g f") 'with-editor-finish)
  (define-key evil-normal-state-map (kbd "<SPC> g q") 'with-editor-cancel)
  (define-key evil-normal-state-map (kbd "<SPC> g p") 'magit-push)
  (define-key evil-normal-state-map (kbd "<SPC> g P") 'magit-pull)

  (define-key evil-normal-state-map (kbd "<SPC> :") 'execute-extended-command)
  ;; Evil nerd commenter
  (define-key evil-normal-state-map (kbd "g c c") 'evilnc-comment-or-uncomment-lines)
  ;; Clojure
  (define-key evil-normal-state-map (kbd "<SPC> c r") 'cider-ns-refresh)
  ;; Debugging
  (define-key evil-normal-state-map (kbd "<SPC> D a") 'dap-breakpoint-add)
  (define-key evil-normal-state-map (kbd "<SPC> D r") 'dap-breakpoint-delete)
 )

;; Ensure that Emacs picks env vars
(use-package exec-path-from-shell
  :ensure t
  :init
  (exec-path-from-shell-initialize))

;; Set Doom theme
(use-package doom-themes
  :ensure t)
(load-theme 'doom-one t)

;; Evil
(use-package evil
  :ensure t
  :init
  (evil-mode 1))

;; Doom modeline
(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1))

;; Projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode 1))
(setq projectile-project-search-path '("~/code/"))

;; Helm projectile
(use-package helm-projectile
  :ensure t
  :init
  (helm-projectile-on))

;; Ido
(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-mode 1)
  (ido-vertical-mode 1))

;; Magit
(use-package magit
  :ensure t)

;; Diff hl
(use-package diff-hl
  :ensure t
  :init
  (global-diff-hl-mode))

;; Helm swoop
(use-package helm-swoop
  :ensure t)

;; Which key
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  (setq which-key-idle-delay 0.1)
)

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Flycheck
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

;; Go
(use-package go-mode
  :ensure t)
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Gotest
(use-package gotest)
(add-hook 'go-mode-hook
		  (function (lambda ()
					  (define-key evil-normal-state-map (kbd "<SPC> t p") 'go-test-current-project)
					  (define-key evil-normal-state-map (kbd "<SPC> t f") 'go-test-current-file)
					  (define-key evil-normal-state-map (kbd "<SPC> t t") 'go-test-current-test)
					  (define-key evil-normal-state-map (kbd "<SPC> t r") 'go-run))))

;; Haskell
(use-package haskell-mode
  :ensure t)
(use-package lsp-haskell
  :ensure t)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

(use-package hindent
  :ensure t)
(add-hook 'haskell-mode-hook
  (function (lambda ()
	(add-hook 'before-save-hook
			  'hindent-reformat-buffer))))

;; Clojure
;; (use-package cider)
;; (use-package clojure-mode)
;; (use-package paredit)
;; (add-hook 'cider-repl-mode-hook #'company-mode)
;; (add-hook 'cider-mode-hook #'company-mode)

(use-package scala-mode
  :ensure t
  :interpreter
    ("scala" . scala-mode))

(use-package lsp-metals
  :ensure t)

;; LSP
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred)
        (scala-mode . lsp-deferred))

;; Company
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode))
(setq company-minimum-prefix-length 1)
(setq company-idle-delay .1)
(setq company-echo-delay 0)
(add-hook 'after-init-hook 'global-company-mode)

;; LSP UI
(use-package lsp-ui
  :ensure t
  :init
  (setq lsp-ui-doc-enable nil)
  :hook (lsp-mode . lsp-ui-mode))


;; Debugging
(use-package dap-mode
  :ensure t
  :init
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1)
)

(require 'dap-dlv-go)

;; Other
(use-package evil-nerd-commenter
  :ensure t)

(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode t))

;; Goggles
(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

;; Redo/Undo
(use-package undo-fu
  :ensure t)
(use-package evil
  :ensure t
  :init
  (setq evil-undo-system 'undo-fu)
  (setq evil-redo-function 'undo-fu-only-redo))

(use-package zoom)
(custom-set-variables
 '(zoom-mode t)
 '(zoom-size '(0.618 . 0.618)))

(use-package web-mode
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))

(use-package add-node-modules-path)
(defun web-mode-init-prettier-hook ()
  (add-node-modules-path))

(add-hook 'web-mode-hook 'web-mode-init-prettier-hook)
(add-hook 'web-mode-hook #'lsp)
