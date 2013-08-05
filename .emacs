;(require 'package)
(package-initialize)
(require 'carton)
(require 'pallet)
(require 'quickrun)
(require 'solarized-theme)
(require 'window-number)
(require 'undo-tree)
(require 'slime)
(require 'jedi)
(require 'icicles)
(require 'golden-ratio)
(require 'flycheck)
(require 'elscreen)
(require 'magit)
(require 'ecb)
(require 'rect-mark)
(require 'rainbow-delimiters)
(require 'undohist)
(require 'python)
(require 'pymacs)
(require 'erc)
(require 'semantic/sb)
(add-to-list 'package-archives
  '("marmalade" .
    "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/"))


;; Typing tools
(undohist-initialize)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(global-set-key (kbd "C-c , -") 'senator-fold-tag)
(global-set-key (kbd "C-c , +") 'senator-unfold-tag))
(setq ns-command-modifier 'meta)
(global-set-key (kbd "C-c e") 'evil-mode)
;(add-hook 'after-init-hook 'evil-mode)
(setq scroll-conservatively most-positive-fixnum)
(setq scroll-step 1)
(cua-selection-mode t) ; because I like rectangle support, 
                       ; global mark mode and other features
                       ; but prefer  standard emacs keys
(which-function-mode 1)
(delete-selection-mode 1)  ;; this allows you to select regions of text and use del
			   ;; to delete it or to type to replace it
(auto-complete-mode 1)

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
(desktop-save-mode 1)   ; enables you to save & restore the set of open windows

;; Development Tools
(semantic-mode 1)
(global-cedet-m3-minor-mode t) ; activates CEDET's context menu bound to the right mouse button
(semantic-speedbar-analysis t)
(global-ede-mode 1)
(setq semantic-complete-inline-analyzer-idle-displayor-class 'semantic-displayor-ghost)
(setq semanticdb-find-default-throttle '(project unloaded system recursive))
(global-semantic-tag-unfolding-mode t)
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
  (elpy-enable) ; python tools
  (elpy-use-cpython)
  (add-hook 'python-mode-hook 'isend-mode)
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;;;;;             C/C++
(defun c++-mode-cedet-hook ()
  (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-semantic)
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert))
(add-hook 'c-mode-common-hook 'c++-mode-cedet-hook)

;; Projects
;;;;;              MODIB
(ede-cpp-root-project "MODIB"
:name "Memory Oriented Dynamic Instrumentation and Interactive Visualization of Binaries"
:file "~/workspace/MODIB/src/CMakeLists.txt"
:srcroot "~/workspace/MODIB/src"
:include-path '("/"
		"/library/dataStructures/include"
		 "/library/graphUtils/include" 
		 "/library/MODIB-gui/include" 
		 "/library/MODIB-Importers/include"
		 "/library/MODIB-Importers/DatabaseImporter/include"
		 "/library/MODIB-Importers/remoteLoader/include"
		 "/library/sharedResources/include"
		 )
)
;;  Python Includes
(setenv "PYTHONPATH" "/home/adam/tulip-build/tulip-build-debug/install/lib/python")
(setenv "LD_LIBRARY_PATH" "/home/adam/tulip-build/tulip-build-debug/install/lib")
;;  C++ Includes
;;; TULIP INCLUDES
(semantic-add-system-include "~/tulip-build/tulip-build-debug/install/include" 'c++-mode)
;;; MODIB INCLUDES
(semantic-add-system-include "~/workspace/MODIB/src/library/dataStructures/include" 'c++-mode)
(semantic-add-system-include "~/workspace/MODIB/src/library/graphUtils/include" 'c++-mode)
(semantic-add-system-include "~/workspace/MODIB/src/library/MODIB-gui/include" 'c++-mode)
(semantic-add-system-include "~/workspace/MODIB/src/library/MODIB-Importers/include" 'c++-mode)
(semantic-add-system-include "~/workspace/MODIB/src/library/MODIB-Importers/DatabaseImporter/include" 'c++-mode)
(semantic-add-system-include "~/workspace/MODIB/src/library/MODIB-Importers/remoteLoader/include" 'c++-mode)
(semantic-add-system-include "~/workspace/MODIB/src/library/sharedResources/include" 'c++-mode)
;;; QT INCLUDES
(semantic-add-system-include "/usr/include/qt5/QtConcurrent"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtCore"			'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtDBus"			'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtGui"			'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtLocation"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtNetwork"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtOpenGL"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtPlatformSupport"	'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtPrintSupport"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtQml"			'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtQmlDevTools"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtQuick"			'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtQuickParticles"	'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtQuickTest"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtSensors"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtSql"			'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtTest"			'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtWebKit"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtWebKitWidgets"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtWidgets"		'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtXml"			'c++-mode)
(semantic-add-system-include "/usr/include/qt5/QtXmlPatterns"		'c++-mode)



;;; Miscellaneous settings
(setq make-backup-files nil)

;;;;;; Stuff managed by Emacs automatically
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(ecb-options-version "2.40")
 '(erc-insert-timestamp-function (quote erc-insert-timestamp-left))
 '(erc-modules (quote (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring services stamp track)))
 '(erc-nick "SuperNoeMan")
 '(erc-system-name "EmacsERC")
 '(erc-timestamp-format "[%a, %D, %H:%M:%S]")
 '(global-semantic-decoration-mode t)
 '(global-semantic-highlight-edits-mode t)
 '(global-semantic-highlight-func-mode t)
 '(global-semantic-idle-completions-mode t nil (semantic/idle))
 '(global-semantic-idle-local-symbol-highlight-mode t nil (semantic/idle))
 '(global-semantic-idle-scheduler-mode t)
 '(global-semantic-idle-summary-mode t)
 '(semantic-python-dependency-system-include-path (quote ("/home/adam/tulip-build/tulip-build-debug/install/lib/python" "/home/adam/tulip-build/tulip-build-debug/install/lib"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
