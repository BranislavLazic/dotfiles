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
  (define-key evil-normal-state-map (kbd "<SPC> d o") 'dired)
  ;; Magit
  (define-key evil-normal-state-map (kbd "<SPC> g s") 'magit-status)
  (define-key evil-normal-state-map (kbd "<SPC> g l") 'magit-log)
  (define-key evil-normal-state-map (kbd "<SPC> g r") 'magit-revert)
  ;; Helm
  (define-key evil-normal-state-map (kbd "<SPC> h f") 'helm-find)
  (define-key evil-normal-state-map (kbd "<SPC> h r") 'helm-recentf)
  (define-key evil-normal-state-map (kbd "<SPC> :") 'execute-extended-command)
  ;; Evil nerd commenter
  (define-key evil-normal-state-map (kbd "g c c") 'evilnc-comment-or-uncomment-lines)
  ;; Clojure
  (define-key evil-normal-state-map (kbd "<SPC> c r") 'cider-ns-refresh)
  ;; Go test
  (define-key evil-normal-state-map (kbd "<SPC> t p") 'go-test-current-project)
  (define-key evil-normal-state-map (kbd "<SPC> t f") 'go-test-current-file)
  (define-key evil-normal-state-map (kbd "<SPC> t t") 'go-test-current-test)
  (define-key evil-normal-state-map (kbd "<SPC> t r") 'go-run)
  )

;; Ensure that Emacs picks env vars
(use-package exec-path-from-shell)
(exec-path-from-shell-initialize)

;; Set Doom theme
(use-package doom-themes)
(load-theme 'doom-one t)

;; Evil
(use-package evil)
(evil-mode 1)

;; Doom modeline
(use-package doom-modeline)
(doom-modeline-mode 1)

;; Projectile
(use-package projectile)
(projectile-mode +1)
(setq projectile-project-search-path '("~/code/"))

;; Ido
(use-package ido)
(ido-mode 1)

;; Magit
(use-package magit)

;; Diff hl
(use-package diff-hl)
(global-diff-hl-mode)

;; Helm swoop
(use-package helm-swoop)

;; Helm projectile
(use-package helm-projectile)
(helm-projectile-on)

;; Which key
(use-package which-key)
(which-key-mode)
(setq which-key-idle-delay 0.1)

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Flycheck
(use-package flycheck)
(global-flycheck-mode)

;; Go
(use-package go-mode)
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Haskell
(use-package haskell-mode)
(use-package lsp-haskell)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

(use-package hindent)
(add-hook 'haskell-mode-hook
		  (function (lambda ()
					  (add-hook 'before-save-hook
								'hindent-reformat-buffer))))

;; Clojure
(use-package cider)
(use-package clojure-mode)
(use-package paredit)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;; LSP
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

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
  :hook (lsp-mode . lsp-ui-mode))
(setq lsp-ui-doc-enable nil)

;; Gotest
(use-package gotest)

;; Other
(use-package evil-nerd-commenter)

(use-package smartparens)
(smartparens-global-mode t)

(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))
