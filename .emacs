;see https://melpa.org/#/getting-started
(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

(package-initialize)

;(package-refresh-contents)

; see https://github.com/purcell/color-theme-sanityinc-tomorrow
(require 'color-theme-sanityinc-tomorrow)
(require 'use-package)

; Haskell mode, Haskell indent
;(use-package haskell-mode
;  :ensure t)
;(use-package hindent
;  :ensure t)

; enable REPL for any haskell file
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'hindent-mode)

(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  ;; OR:
  ;; (add-hook 'haskell-mode-hook 'flymake-mode)
  (add-hook 'haskell-mode-hook 'dante-mode)
  )

; set path to ghc
; later see: https://github.com/purcell/exec-path-from-shell
(add-to-list 'exec-path "/Users/kippesp/.ghcup/bin")

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
    (hindent use-package haskell-mode color-theme-sanityinc-tomorrow dante attrap lcr))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; FUNCTIONS
(defun font-exists-p (font) "check if font exists" (if (null (x-list-fonts font)) nil t))

;;; ADJUSTMENTS

(blink-cursor-mode 0)

(global-display-line-numbers-mode)

(tool-bar-mode -1)
(toggle-scroll-bar -1)

; font picker
(cond
 ((find-font (font-spec :name "Source Code Pro"))
  (set-frame-font "Source Code Pro-12"))
 ((find-font (font-spec :name "Inconsolata"))
  (set-frame-font "Inconsolata-13"))
 ((find-font (font-spec :name "Lucida Console"))
  (set-frame-font "Lucida Console-12"))
 ((find-font (font-spec :name "Consolas"))
  (set-frame-font "Consolas-14"))
 ((find-font (font-spec :name "Courier"))
  (set-frame-font "Courier-12")))
