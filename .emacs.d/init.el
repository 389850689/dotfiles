;; Remove some GUI elements.
(tool-bar-mode -1)   ; disable toolbar.
(scroll-bar-mode -1) ; disable scrollbar.
(menu-bar-mode -1)   ; disable menubar.
; (set-fringe-mode 10) ; add some padding.
 
;; Show empty lines.
; (setq-default indicate-empty-lines t)
; (fringe-mode +1)
; (add-hook 'prog-mode-hook 'vi-tilde-fringe-mode)

;; Enable auto pairs.
(electric-pair-mode 1)

;; Switch between frames using keybinds.
(windmove-default-keybindings)

;; Enable line numbers.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Escape key quits prompts.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Set font.
(set-face-attribute 'default nil :font "Source Code Pro" :height 110)

;; Add melpa repo to package archives.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Run autoloads on packages.
(package-initialize)

;; Check if archive contents exist.
(unless package-archive-contents
  (package-refresh-contents))

;; Ensure that `use-package` is installed.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Install `doom-modeline`, similar to airline from vim.
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Install and configure `doom-themes`
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Install and configure keybinds for `Ivy`.
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :init (ivy-mode 1))

;; Install and configure `LSP Mode` for emacs.
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; Enable hover dialogs for LSP.
(setq lsp-ui-doc-enable t)
;; Enable headerine.
(setq lsp-headerline-breadcrumb-enable t)
;; Enable symbol highlighting.
(setq lsp-enable-symbol-highlighting t)

;; Install company mode, for completion.
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; Install python's jedi language server.
(use-package lsp-jedi
  :ensure t
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))

;; Install `Emacs Python Development Enviornment`.
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; Install `evil mode`, which is a vim keybind emulator.
(use-package evil
  :init (evil-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(elpy vi-tilde-fringe zzz-to-char lsp-treemacs lsp-ivy lsp-ui lsp-mode ivy doom-themes elcord evil doom-modeline use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
