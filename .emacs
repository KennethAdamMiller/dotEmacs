(require 'package)
(add-to-list 'package-archives
  '("marmalade" .
    "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
(require 'cl-lib)
(require 'cask)
(cask-initialize)
(require 'pallet)
(require 'quickrun)
(require 'solarized-theme)
(require 'window-number)
(require 'undo-tree)
(require 'slime)
(require 'jedi)
;(require 'icicles)
(require 'golden-ratio)
(require 'flycheck)
(require 'elscreen)
(require 'magit)
;(require 'ecb)
(require 'rect-mark)
(require 'rainbow-delimiters)
;;(require 'undohist)
(require 'python)
;;(require 'pymacs)
(require 'erc)
(require 'semantic/sb)

(setenv "PATH" (concat (getenv "PATH") ":" (getenv "HOME") "/homebrew/bin"))
(setenv "PATH" (concat (getenv "PATH") ":" "/opt/local/bin"))
(setenv "PATH" (concat (getenv "PATH") ":" "/usr/local/bin"))
(defun opam-env ()
  (interactive nil)
  (dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
    (setenv (car var) (cadr var))))
(opam-env)
(setq exec-path (split-string (getenv "PATH") path-separator))
(load "~/.emacs.d/lisp/PG/generic/proof-site")

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (sh t)
   (org t)
   (lilypond t)))

;; Variable definitions
 
;; Typing tools
;;(undohist-initialize)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(global-set-key (kbd "C-c , -") 'senator-fold-tag)
(global-set-key (kbd "C-c , +") 'senator-unfold-tag)
(global-set-key (kbd "M-s s") 'isend-send)
(setq ns-command-modifier 'meta)
(global-set-key (kbd "C-c e") 'evil-mode)
;(add-hook 'after-init-hook 'evil-mode)
(setq scroll-conservatively most-positive-fixnum)
(setq scroll-step 1)
(setq auto-window-vscroll nil)
(cua-selection-mode t) ; because I like rectangle support, 
                       ; global mark mode and other features
                       ; but prefer  standard emacs keys
(which-function-mode 1)
(delete-selection-mode 1)  ;; this allows you to select regions of text and use del
 			   ;; to delete it or to type to replace it
(auto-complete-mode 1)
(savehist-mode 1)
 
;; Window tools
(winner-mode t)
(golden-ratio-mode 1)
(defadvice window-number-select(around advice-wns activate)
  ad-do-it 
  (golden-ratio)
)
(global-linum-mode 1)  ; add line numbers on all files
(elscreen-start)
(window-number-mode)
;(autoload 'window-number-mode "window-number"
;   "A global minor mode that enables selection of windows according to
; numbers with the C-x C-j prefix.  Another mode,
; `window-number-meta-mode' enables the use of the M- prefix."
;   t)
 
;; Buffer tools
(global-set-key (kbd "C-c C-b") 'ibuffer)
 
;; Theme and appearances changes
(load-theme 'solarized-dark t)
(setq solarized-contrast 'high)
;(desktop-save-mode 0)   ; enables you to save & restore the set of open windows
 
;; Development Tools
(semantic-mode 1)
;(global-cedet-m3-minor-mode t) ; activates CEDET's context menu bound to the right mouse button
  ;; After doing some pallet-updates this no longer works
;(semantic-speedbar-analysis t)
(global-ede-mode 1)
(setq semantic-complete-inline-analyzer-idle-displayor-class 'semantic-displayor-ghost)
(setq semanticdb-find-default-throttle '(project unloaded system recursive))
;(global-semantic-tag-unfolding-mode t)
(global-semantic-decoration-mode 1)
  '(semantic-decoration-styles
    (quote (
 	    ("semantic-decoration-on-protected-members")
 	    ("semantic-decoration-on-private-members")
 	    ("semantic-tag-boundary" . t)
 	    ("semantic-decoration-on-includes"))))
;(add-hook 'find-file-hook 'flymake-find-file-hook)
;(flymake-mode 1)
;;;;;             Python 
  (autoload 'pylint "pylint")
  (add-hook 'python-mode-hook 'pylint-add-menu-items)
  (add-hook 'python-mode-hook 'pylint-add-key-bindings)
  ;(elpy-enable) ; python tools
  ;(elpy-use-cpython)
  ;(add-hook 'python-mode-hook 'isend-mode)
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;;;;;             C/C++
(defun c++-mode-cedet-hook ()
  (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-semantic)
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert))
(add-hook 'c-mode-common-hook 'c++-mode-cedet-hook)
 
;;; Miscellaneous settings
(setq make-backup-files nil)

;; OCaml setup
(defun opam-path (path)
  (let ((opam-share-dir
         (shell-command-to-string
          "echo -n `opam config var share`")))
    (concat opam-share-dir "/" path)))

(add-to-list 'load-path (opam-path "emacs/site-lisp"))
(add-to-list 'load-path (opam-path "tuareg"))
(load "tuareg-site-file")
(add-to-list 'load-path (opam-path "/typerex/ocp-indent/"))
(setq ocp-indent-path (concat (shell-command-to-string "echo -n `opam config var bin`") "/ocp-indent"))

(require 'ocp-indent)
(require 'merlin)
(require 'company)
(add-to-list 'company-backends 'merlin-company-backend)
(add-hook 'merlin-mode-hook 'company-mode)

(define-key merlin-mode-map (kbd "C-c TAB") 'company-complete)
(define-key merlin-mode-map (kbd "C-c C-d") 'merlin-document)
(define-key merlin-mode-map (kbd "C-c d") 'merlin-destruct)


(setq merlin-completion-with-doc t)
(setq merlin-use-auto-complete-mode nil)
(setq tuareg-font-lock-symbols t)
(setq merlin-command 'opam)
(setq merlin-locate-preference 'mli)

(defun change-symbol (x y)
  (setcdr (assq x tuareg-font-lock-symbols-alist) y))

(defun ocp-indent-buffer ()
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (ocp-indent-region (region-beginning)
                       (region-end))))

(add-hook 'tuareg-mode-hook
          (lambda ()
            (merlin-mode)
            (local-set-key (kbd "C-c c") 'recompile)
            (local-set-key (kbd "C-c C-c") 'recompile)
            (auto-fill-mode)
            (tuareg-make-indentation-regexps)
            (add-hook 'before-save-hook 'ocp-indent-buffer nil t)))

(defun opam-env ()
  (interactive nil)
  (dolist (var
           (car (read-from-string
                 (shell-command-to-string "opam config env --sexp"))))
    (setenv (car var) (cadr var))))

(provide 'ocaml)

;;;;;; Stuff managed by Emacs automatically
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(erc-insert-timestamp-function (quote erc-insert-timestamp-left))
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring services)))
 '(erc-nick "SomeDamnBody")
 '(erc-system-name "EmacsERC")
 '(erc-timestamp-format "[%a, %D, %H:%M:%S]")
 '(global-semantic-decoration-mode t)
 '(global-semantic-highlight-edits-mode t)
 '(global-semantic-highlight-func-mode t)
 '(global-semantic-idle-completions-mode t nil (semantic/idle))
 '(global-semantic-idle-local-symbol-highlight-mode t nil (semantic/idle))
 '(global-semantic-idle-scheduler-mode t)
 '(global-semantic-idle-summary-mode t)
 '(muse-project-alist nil)
 '(package-selected-packages
   (quote
    (free-keys docker-api docker emms muse window-number virtualenv undohist tuareg sr-speedbar solarized-theme smex slime rect-mark rainbow-delimiters quickrun python-mode pylint pyde pallet ocp-indent multi-project multi-eshell merlin magit jedi isend-mode hl-todo helm-gtags helm-dired-recent-dirs groovy-mode golden-ratio git ghci-completion ghc ggtags gccsense framesize flymake-python-pyflakes flymake-hlint flymake-haskell-multi flymake-go flycheck floobits fic-mode evil-nerd-commenter evil emr elscreen elpy ein ecukes ecb dsvn disaster dired-efap ctags-update ctags csound-mode comint-better-defaults cmake-project cmake-mode auto-complete-clang-async)))
 '(python-shell-buffer-name "Python3.4")
 '(semantic-python-dependency-system-include-path
   (quote
    ((concat TulipLocation "/tulip-build-debug/install/lib/python")
     (concat TulipLocation "/tulip-build-ebug/install/lib")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
