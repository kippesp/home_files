;Stuff that worked with Intero for Emacs (console version)
;;; If you don't have MELPA in your package archives:
;(require 'package)
;(add-to-list
;  'package-archives
;  '("melpa" . "http://melpa.org/packages/") t)
;(package-initialize)
;(package-refresh-contents)
;
;;; Install Intero
;(package-install 'intero)
;(add-hook 'haskell-mode-hook 'intero-mode)
;
;(require 'evil)
;(evil-mode t)
;
;(custom-set-variables
; ;; custom-set-variables was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; '(package-selected-packages (quote (use-package intero hindent evil-visual-mark-mode))))
;(custom-set-faces
; ;; custom-set-faces was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; )











; todo - iedit package
; magit - iedit package
; projectile - iedit package
(require 'package)

(add-to-list
  'package-archives
  '("melpa" . "http://melpa.org/packages/") t)

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq evil-want-keybinding nil)

(require 'evil)
(evil-mode t)
(evil-collection-init) ;; see https://github.com/emacs-evil/evil-collection

; Haskell Mode, Haskell indent
(use-package haskell-mode
  :ensure t)
(use-package hindent
  :ensure t)

; see https://github.com/purcell/color-theme-sanityinc-tomorrow
(require 'color-theme-sanityinc-tomorrow)

;; M-x package-install RET evil-mode
;
;(custom-set-variables
; ;; custom-set-variables was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; '(package-selected-packages
;   (quote
;    (use-package evil-visual-mark-mode))))
;
;
;(unless (package-installed-p 'use-package)
;  (package-refresh-contents)
;  (package-install 'use-package))
;
;(eval-when-compile
;  (require 'use-package))
;
;;(package-install 'intero)
;;(add-hook 'haskell-mode-hook 'intero-mode)
;(use-package intero
;  :ensure t)
;(add-hook 'haskell-mode-hook 'intero-mode)
;
;
;;; If you don't have MELPA in your package archives:
;
;;; Install Intero
;;(package-install 'intero)
;;(add-hook 'haskell-mode-hook 'intero-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-tomorrow evil-collection use-package intero hindent evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
