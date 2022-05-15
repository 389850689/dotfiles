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

(setq inhibit-startup-message t)

(tool-bar-mode -1)   ; disable toolbar.
(scroll-bar-mode -1) ; disable scrollbar.
(menu-bar-mode -1)   ; disable menubar.

; smooth scrolling
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

; enable line numbers.
(global-display-line-numbers-mode t)

;; TODO: write a hook here to disable line numbers in org mode.

(electric-pair-mode 1)

;; install `all-the-icons` font.
(use-package all-the-icons)

(set-face-attribute 'default nil :font "Source Code Pro" :height 110)

(use-package elcord
  :init (elcord-mode)
  :config (setq elcord-editor-icon "doom_icon"))

;; Install `evil mode`, which is a vim keybind emulator.
(use-package evil
  :init (evil-mode 1))



;; Escape key quits prompts.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package neotree
  :init (global-set-key [f8] 'neotree-toggle))

;; Install `doom-modeline`, similar to airline from vim.
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; Install and configure `doom-themes`
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-nord t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-tommorrow-night") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package centaur-tabs
  :demand
  :config
    (centaur-tabs-mode t)
    (setq centaur-tabs-set-icons t)
    (setq centaur-tabs-style "bar")
    (setq centaur-tabs-height 32)
    (setq centaur-tabs-set-modified-marker t)
    (setq centaur-tabs-show-navigation-buttons t)
    (setq centaur-tabs-set-bar 'left)
    (setq centaur-tabs-gray-out-icons 'buffer)
  :bind
  (:map evil-normal-state-map
    ("g t" . centaur-tabs-forward)
    ("g T" . centaur-tabs-backward)))

;; Automatically tangle our emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
		      (expand-file-name "~/.emacs.d/emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

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

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package swiper)

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
    :map minibuffer-local-map
    ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1))

(use-package company
  :init (global-company-mode))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.1))

(use-package eglot
  ; this'll work for now, but should have a language specific list.
  :hook (prog-mode . eglot-ensure))

(use-package solaire-mode
  :init (setq solaire-mode-remap-fringe t) (solaire-global-mode +1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package clojure-mode)
(use-package cider)
