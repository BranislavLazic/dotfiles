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

;; Hooks
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(with-eval-after-load 'evil-maps
  ;; Files
  (define-key evil-normal-state-map (kbd "<SPC> f f") 'find-file)
  (define-key evil-normal-state-map (kbd "<SPC> f s") 'save-buffer)
  ;; Helm swoop
  (define-key evil-normal-state-map (kbd "<SPC> s") 'helm-swoop)
  ;; Windows and buffers
  (define-key evil-normal-state-map (kbd "<SPC> w v") 'split-window-horizontally)
  (define-key evil-normal-state-map (kbd "<SPC> w w") 'other-window)
  (define-key evil-normal-state-map (kbd "<SPC> w s") 'split-window-vertically)
  (define-key evil-normal-state-map (kbd "<SPC> w q") 'kill-buffer-and-window)
  (define-key evil-normal-state-map (kbd "<SPC> b n") 'switch-to-next-buffer)
  (define-key evil-normal-state-map (kbd "<SPC> b p") 'switch-to-prev-buffer)
  (define-key evil-normal-state-map (kbd "<SPC> p") 'projectile-command-map)
  ;; Magit
  (define-key evil-normal-state-map (kbd "<SPC> g s") 'magit-status)
  (define-key evil-normal-state-map (kbd "<SPC> g l") 'magit-log)
  (define-key evil-normal-state-map (kbd "<SPC> g r") 'magit-revert)
  ;; Helm
  (define-key evil-normal-state-map (kbd "<SPC> h f") 'helm-find)
  (define-key evil-normal-state-map (kbd "<SPC> h r") 'helm-recentf)
  )

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

;; Ido
(use-package ido)
(ido-mode 1)

;; Magit
(use-package magit)

;; Diff hl
(use-package diff-hl)
(global-diff-hl-mode)

;; Helm
(use-package helm)
(helm-mode 1)

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

(use-package go-mode)

;; LSP
(use-package lsp-mode)

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package company)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay .1)
(setq company-echo-delay 0)
(add-hook 'after-init-hook 'global-company-mode)

