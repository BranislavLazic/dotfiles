(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
             ("marmalade" . "http://marmalade-repo.org/packages/")
             ("melpa" . "http://melpa.milkbox.net/packages/")))

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
   (quote
    (helm-projectile helm-swoop badwolf-theme which-key helm projectile magit diff-hl doom-modeline company company-go go-mode evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-frame-font "Monaco 14")
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq default-directory "~/")

;; Hooks
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'go-mode-hook (lambda ()
                        (set (make-local-variable 'company-backends) '(company-go))
                        (company-mode)))
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

;; Windows and buffers
(global-set-key (kbd "C-c w v") 'split-window-horizontally)
(global-set-key (kbd "C-c w w") 'other-window)
(global-set-key (kbd "C-c w s") 'split-window-vertically)
(global-set-key (kbd "C-c w q") 'kill-buffer-and-window)
(global-set-key (kbd "C-c b n") 'switch-to-next-buffer)
(global-set-key (kbd "C-c b p") 'switch-to-prev-buffer)


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
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Ido
(require 'ido)
(ido-mode 1)

;; Magit
(require 'magit)
(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key (kbd "C-c g l") 'magit-log)
(global-set-key (kbd "C-c g r") 'magit-revert)

;; Diff hl
(require 'diff-hl)
(global-diff-hl-mode)

;; Helm
(require 'helm)
(helm-mode 1)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h r") 'helm-recentf)

;; Helm swoop
(require 'helm-swoop)
(global-set-key (kbd "C-s") 'helm-swoop)

;; Helm projectile
(require 'helm-projectile)
(helm-projectile-on)

;; Which key
(require 'which-key)
(which-key-mode)
