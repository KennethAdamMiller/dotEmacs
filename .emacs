;(require 'package)
(package-initialize)
(require 'carton)
(require 'pallet)
(require 'quickrun)
(require 'solarized-theme)
(require 'window-number)
(require 'undo-tree)
(require 'slime)
(require 'quickrun)
(require 'jedi)
(require 'icicles)
(require 'golden-ratio)
(require 'flycheck)
(require 'elscreen)
(require 'magit)
(require 'ecb)
(require 'rect-mark)
;(require 'rainbow-delimiters)

;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-to-list 'package-archives
  '("marmalade" .
    "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/"))
;(add-hook 'after-init-hook 'evil-mode)
(setq ns-command-modifier 'meta)
(setq scroll-conservatively most-positive-fixnum)
(global-set-key (kbd "C-c e") 'evil-mode)
(cua-selection-mode t) ; because I like rectangle support, 
                       ; global mark mode and other features
                       ; but prefer  standard emacs keys
(global-linum-mode 1)
(elscreen-start)
(load-theme 'solarized-dark t)
(setq solarized-contrast 'high)
(golden-ratio-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(window-number-mode)
;(autoload 'window-number-mode "window-number"
;   "A global minor mode that enables selection of windows according to
; numbers with the C-x C-j prefix.  Another mode,
; `window-number-meta-mode' enables the use of the M- prefix."
;   t)
