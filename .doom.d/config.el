;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq display-line-numbers 'relative
      display-line-numbers-type 'relative
      doom-line-numbers-style 'relative
      doom-font (font-spec :family "Monaco for Powerline" :size 14)
      js-indent-level 2
      company-idle-delay 0
      doom-modeline-vcs-max-length 52)

;; Dumb jump
(setq dumb-jump-debug t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Bindings
(map! :leader
      (:prefix-map ("t" . "toggle")
        :desc "Terminal" "t" #'term)
      (:prefix-map ("c" . "code")
        :desc "Jump go other window" "v" #'dumb-jump-go-other-window))

;; Hooks

;; js2 mode hook
(add-hook 'js2-mode-hook #'(lambda ()
                             (map! :leader
                                   (:prefix-map ("j" . "js2 mode")
                                     :desc "Rename variable" "r" #'js2r-rename-var
                                     :desc "Jump to definition" "j" #'js2-jump-to-definition))
                             (modify-syntax-entry ?_ "w")))

(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode 'prettier-js-mode)

(setq emmet-expand-jsx-className? t
      emmet-self-closing-tag-style " /")

;; Typescript
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
