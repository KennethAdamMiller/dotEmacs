(require 'package) 
(add-to-list 'package-archives
  '("marmalade" .
    "http://marmalade-repo.org/packages/"))
(package-initialize)
(add-hook 'after-init-hook 'evil-mode)
(setq ns-command-modifier 'meta)
(setq scroll-conservatively most-positive-fixnum)
(global-set-key (kbd "C-c e") 'evil-mode)
(cua-selection-mode t)
