(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 128 1024 1024))
                  gc-cons-percentage 0.6))

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

;; PARAMS
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(save-place-mode 1)
(recentf-mode 1)
;;(fido-mode t)
;;(fido-vertical-mode t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq scroll-margin 10)
(setq scroll-conservatively 101)
(savehist-mode 1)
;;(desktop-save-mode 1)
(tab-bar-mode -1)
;; global-auto-revert-mode
(setq inhibit-startup-screen t)

(setq dired-listing-switches "-alh")

(setq eglot-events-buffer-size 0)
(fset #'jsonrpc--log-event #'ignore)

(setq native-comp-speed 3)
(setq native-comp-deferred-compilation t)
(setq package-native-compile t)

;;(native-compile-async (expand-file-name "~/.emacs.d/") 'recursively)

(setq read-process-output-max (* 1024 1024))
(setq process-adaptive-read-buffering nil)
(setq create-lockfiles nil)

(defun my-native-recompile-all-packages ()
  "Prune eln cache and native recompile everything in `package-user-dir'."
  (interactive)
  (native-compile-prune-cache)
  (native-compile-async package-user-dir 'recursively))


(when (fboundp 'json-parse-string)
  (setq json-parse-json nil))
;;


(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs loaded %d packages in %.3fs"
                     (length load-path)
                     (float-time (time-subtract after-init-time before-init-time)))))


;; Appearance
(set-face-attribute 'default nil :font "CaskaydiaMono Nerd Font" :height 110)
(load-theme 'wombat t)
;;

;; KEYS
(global-set-key (kbd "M-l") #'forward-word)
(global-set-key (kbd "M-h") #'backward-word)
(global-set-key (kbd "C-`") #'set-mark-command)

(global-set-key (kbd "M-`") #'flymake-show-buffer-diagnostics)
;; M-h mark paragraph

(global-set-key (kbd "M-p") #'xref-find-references)
(global-set-key (kbd "M-R") #'eglot-rename)
(global-set-key (kbd "M-RET") #'eglot-code-actions)
(global-set-key (kbd "C-c h") #'eldoc-doc-buffer)
;;

;; Backups + Autosaves
(let ((backup-dir (locate-user-emacs-file "var/backups/"))
      (autosave-dir (locate-user-emacs-file "var/autosaves/")))
  (make-directory backup-dir t)
  (make-directory autosave-dir t)

  ;; Backups
  (setq backup-directory-alist `(("." . ,backup-dir)))
  
  ;; Auto-saves
  (setq auto-save-file-name-transforms `((".*" ,autosave-dir t))))
;;


;; PACKAGES
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;;

;; GO Lang
(unless (package-installed-p 'go-mode) (package-install 'go-mode))

(use-package go-mode
  :defer t
  :hook (go-mode . (lambda () (add-hook 'before-save-hook #'eglot-format-buffer)))
  :hook (go-mode . subword-mode)
  :hook (go-mode . (lambda () (eglot-ensure)))
  :config (setq-default eglot-workspace-configuration
                      '((:gopls . ((staticcheck . t) (usePlaceholders . t) (analyses . ((unusedparams . t) (unusedwrite . t))))))))

(unless (package-installed-p 'gotest) (package-install 'gotest))
;;

;; Bottom Windows:
(let ((bottom-buffers '("\\*xref\\*"
                        "\\*Go Test\\*")))
  (dolist (buf bottom-buffers)
    (add-to-list 'display-buffer-alist
                 `(,buf
                   (display-buffer-in-side-window)
                   (side . bottom)
                   (window-height . 0.3)))))
;;

;; CORFU
(unless (package-installed-p 'corfu)
  (package-install 'corfu))

(use-package corfu
  :defer t
  :init
  (global-corfu-mode)
  :config
  (corfu-popupinfo-mode)
  (setq corfu-popupinfo-delay 0.2)
  (setq corfu-auto t))

(unless (package-installed-p 'cape)
  (package-install 'cape))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))
;;


;; VTERM
(unless (package-installed-p 'vterm)
  (package-install 'vterm))
;;

;; VERTICO + MARGINALIA + ORDERLESS 
(unless (package-installed-p 'vertico)
  (package-install 'vertico))

(unless (package-installed-p 'marginalia)
  (package-install 'marginalia))

(unless (package-installed-p 'orderless)
  (package-install 'orderless))

(use-package vertico
  :defer t
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t)
  (vertico-count 12))

(use-package marginalia
  :defer t
  :init
  (marginalia-mode))

(use-package orderless
  :defer t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; (with-eval-after-load 'vertico
;;   (define-key vertico-map (kbd "RET") #'vertico-directory-enter)
;;   (define-key vertico-map (kbd "DEL") #'vertico-directory-delete-char)
;;   (define-key vertico-map (kbd "M-DEL") #'vertico-directory-delete-word))

;;

;; CONSULT
(unless (package-installed-p 'consult)
  (package-install 'consult))

(use-package consult
  :defer t
  :bind (
         ("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("M-s g" . consult-ripgrep)
         ("M-g o" . consult-outline)
         ("M-y" . consult-yank-pop))
  :hook (completion-list-mode . consult-preview-at-point-mode))
;;

(unless (package-installed-p 'gitlab-ci-mode)
  (package-install 'gitlab-ci-mode))
