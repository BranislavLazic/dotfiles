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
   '(ido-completing-read+ projectile magit doom-modeline company company-go go-mode evil material-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-frame-font "Monaco 15")
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)
(load-theme 'material t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq default-directory "~/")

;; Hooks
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
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
(require 'ido-completing-read+)
(ido-mode 1)
(ido-everywhere 1)

;; Magit
(require 'magit)
(define-key magit-mode-map (kbd "C-c g s") 'magit-status)
(define-key magit-mode-map (kbd "C-c g l") 'magit-log)
