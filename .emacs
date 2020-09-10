(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)
(package-initialize)
;; Install packages if they don't exist
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(flycheck lsp-ui lsp-haskell hlint-refactor format-all company-ghci helm-projectile doom-themes helm-swoop which-key helm projectile magit diff-hl doom-modeline company company-go go-mode evil company-ghci haskell-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-frame-font "Monaco 13")
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(load-theme 'doom-one t)
(setq default-directory "~/")
(setq scroll-conservatively 10)
(setq scroll-margin 7)

;; Hooks
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'go-mode-hook (lambda ()
                        (set (make-local-variable 'company-backends) '(company-go))
                        (company-mode)))
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

;; Evil
(require 'evil)
(evil-mode 1)

;; Company
(require 'company)
(require 'company-go)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay .1)
(setq company-echo-delay 0)

;; Doom modeline
(require 'doom-modeline)
(doom-modeline-mode 1)

;; Projectile
(require 'projectile)
(projectile-mode +1)

;; Ido
(require 'ido)
(ido-mode 1)

;; Magit
(require 'magit)

;; Diff hl
(require 'diff-hl)
(global-diff-hl-mode)

;; Helm
(require 'helm)
(helm-mode 1)

;; Helm swoop
(require 'helm-swoop)

;; Helm projectile
(require 'helm-projectile)
(helm-projectile-on)

;; Which key
(require 'which-key)
(which-key-mode)

;; Haskell
(require 'haskell-mode)
(require 'lsp)
(require 'lsp-haskell)
(setq lsp-haskell-process-path-hie "hie-wrapper")
(add-hook 'haskell-mode-hook 'lsp)
