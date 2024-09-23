;; -*- coding: utf-8 -*-

;;-----------------------------------------------------------------------
;; melpa
;;-----------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;;----------------------------------------------------------------------
;; load path
;;----------------------------------------------------------------------
(let ((default-directory  "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(setq load-path
      (append (list "~/.emacs.d/site-lisp")
                      load-path))

;;----------------------------------------------------------------------
;; face
;;----------------------------------------------------------------------
(add-to-list 'default-frame-alist '(cursor-color . "brown"))

(setq frame-title-format
      '((:eval (cond (buffer-file-name (abbreviate-file-name (buffer-file-name)))
                     (dired-directory dired-directory)
                     (t "%b")))
	" - Emacs")
)

(load-library "paren")
(show-paren-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(require 'paren)

(setq isearch-highlight t)
(setq search-highlight t)
(setq query-replace-highlight t)

(delete-selection-mode t)

(setq require-final-newline t)

(setq-default indicate-empty-lines t)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;(which-key-mode 1)

;;  highlight TODO
(defun highlight-todos ()
    (font-lock-add-keywords nil
             '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t))))
(add-hook 'prog-mode-hook 'highlight-todos)

;; terminal mode title
(use-package term-title
  :config
  (term-title-mode)
  )

;; colors
;;(setq frame-background-mode 'dark)
(when (display-graphic-p)
;;  (add-to-list 'default-frame-alist '(background-color . "#f2f2f2"))
;;  (add-to-list 'default-frame-alist '(foreground-color . "#000000"))
;;  (set-face-attribute 'region nil :background "#ccc")
  (load-theme 'gruvbox-dark-hard t)
)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;;(use-package sort-tab
;;  :bind
;;  (("C-M-<right>" . sort-tab-select-next-tab)
;;   ("C-M-<left>" . sort-tab-select-prev-tab)
;;   ("C-M-q" . sort-tab-close-current-tab))
;;  )

;;(setq display-time-default-load-average nil)
;;(display-time)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4c7a1f0559674bf6d5dd06ec52c8badc5ba6e091f954ea364a020ed702665aa1" "18cf5d20a45ea1dff2e2ffd6fbcd15082f9aa9705011a3929e77129a971d1cb3" "f74e8d46790f3e07fbb4a2c5dafe2ade0d8f5abc9c203cd1c29c7d5110a85230" "2dc03dfb67fbcb7d9c487522c29b7582da20766c9998aaad5e5b63b5c27eec3f" "e1b843dd5b1c7b565c9e07e0ecb2fe02440abd139206bd238a2fc0a068b48f84" "3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" default))
 '(org-agenda-files nil)
 '(package-selected-packages
   '(kubernetes-tramp gruvbox-theme graphviz-dot-mode vertico-prescient corfu-prescient prescient ctrlf projectile fzf editorconfig ahk-mode corfu marginalia consult orderless vertico eglot dape clipetty xclip pyim-wbdict pyim js2-mode typescript-mode jinja2-mode company-quickhelp eglot-java go-mode flycheck-plantuml plantuml-mode vterm-toggle su vterm kubernetes all-the-icons mermaid-mode ob-mermaid forge terraform-mode counsel flymake-diagnostic-at-point smex swiper csv-mode dockerfile-mode ag company scala-mode unicad flycheck yasnippet solarized-theme cal-china-x blackboard-theme zenburn-theme magit which-key auto-complete))
 '(show-paren-mode t))
;; '(tramp-password-prompt-regexp
;;   "^.*\\(Pass\\(?:phrase\\|word\\)\\|YUBIKEY\\|pass\\(?:phrase\\|word\\)\\).*:? *")


;; -------------------------------------------------------------------------
;; org mode
;;--------------------------------------------------------------------------
(setq org-directory "~/Org")
(setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))
(setq org-default-notes-file (concat org-directory "/kb.org"))

(defvar my-org-capture-filename nil
  "File name for org capture template.")

(setq org-capture-templates
 '(("t" "Todo" entry (file my-org-capture-filename)
    ;;        "* TODO %?\nEntered on %U\n  %i\n")
    "* TODO %?\n %i\n")
   ("j" "Knowledge Base" entry (file+olp+datetree org-default-notes-file "Capture")
        "* %?\nEntered on %U\n  %i\n  %a")
   ("c" "Protocol Link" entry (file+headline org-default-notes-file "Capture")
    "* [[%:link][%:description]] \n\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n%?\n\nCaptured: %U")))

(defun my-org-capture ()
  "Read file name to capture to."
  (interactive)
  (setq my-org-capture-filename
        (read-file-name "Capture to: " (concat org-directory "/")
                        nil t "todo.org"))
  (call-interactively #'org-capture))

;;(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'my-org-capture)

(org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (shell . t)
     (python . t)
     (R . t)
     (ruby . t)
     (ocaml . t)
     (ditaa . t)
     (dot . t)
     (octave . t)
     (sqlite . t)
     (perl . t)
     (screen . t)
     (plantuml . t)
     (lilypond . t)
     (org . t)
     (makefile . t)
     (mermaid . t)
     ))
(setq org-src-preserve-indentation t)

(require 'org-tempo)

;; track TODO done completion time
(setq org-log-done 'time)

;; export PDF
;;(require 'ox-latex)
;;;; Use XeLaTeX to export PDF in Org-mode
;;(setq org-latex-pdf-process
;;      '("xelatex -8bit -interaction nonstopmode -output-directory %o %f"
;;        "xelatex -8bit -interaction nonstopmode -output-directory %o %f"
;;        "xelatex -8bit -interaction nonstopmode -output-directory %o %f"))
;;(setq tex-compile-commands '(("xelatex %r")))
;;(setq tex-command "xelatex")
;;(setq org-latex-compiler "xelatex")
;;(setq-default TeX-engine 'xelatex)
;;(add-to-list 'org-file-apps '("\\.pdf" . "zathura %s"))

;; export docx
;;(defun org-export-docx ()
;;  (interactive)
;;  (let ((docx-file (concat (file-name-sans-extension (buffer-file-name)) ".docx"))
;;           (template-file "/home/wanjing/Downloads/template.docx"))
;;    (shell-command (format "pandoc %s -r org+east_asian_line_breaks -o %s --reference-doc=%s" (buffer-file-name) docx-file template-file))
;;    (message "Convert finish: %s" docx-file)))
;;
;;;;set system export method to docx
;;;;(setq org-odt-convert-process "unoconv")
;;;; convert org to doc
;;;; M-x org-odt-export-to-odt in an org buffer
;;(setq org-export-odt-preferred-output-format "docx")
;;
;;;; BTW, you can assign "pdf" in above variables if you prefer PDF format
;;
;;;; When I tell Org-Mode to export to ODT at my day job, I actually want DOCX.
;;(setq org-odt-preferred-output-format "docx")

;;(require 'valign)

(setq org-catch-invisible-edits 'show-and-error)

;; customize agenda view
(setq org-agenda-custom-commands
   '(("d" "todays agenda"
	 ((agenda ""))
	 ((org-agenda-span 'day)
	  (org-agenda-start-with-log-mode t)
	  (org-agenda-start-with-clockreport-mode t)
	  (org-agenda-log-mode-items '(closed clock state))
	  (org-agenda-overriding-header "Today's Agenda")))
      ("n" "agenda and all TODOs"
	 ((agenda "" nil)
	  (alltodo "" nil))
	 ((org-agenda-start-with-log-mode t)
	  (org-agenda-log-mode-items '(closed clock))))
      ("w" "Weekly review"
	 ((agenda ""))
         ((org-agenda-span 8)
          (org-agenda-start-day "-7d")
          (org-agenda-start-with-log-mode 'only)
          (org-agenda-log-mode-items '(closed clock))))
     )
)

;;(setq org-todo-keywords
;;      '((sequence "TODO(t)" "WAIT(w@/!)" "DOING(i!/!)" "|" "DONE(d!)")))

;; Always change the task to DOING to clock in.
;;(setq org-clock-in-switch-to-state "DOING")

;; org-jira
;;(require 'org-jira)
;;(setq jiralib-cloud-enabled nil)
;;(setq jiralib-url "https://jira.es.ecg.tools")
;;(setq jiralib-token
;;    (cons "Authorization"
;;          (concat "Bearer " (auth-source-pick-first-password
;;              :host "jira.es.ecg.tools"))))
;;(setq org-jira-working-dir "~/win/Documents/Org/org-jira")
;;(setq jiralib-update-issue-fields-exclude-list '(reporter assignee))

;; only interpret bracket embraced string as subscript to ease my doc with underscore
(setq org-use-sub-superscripts "{}")
;; enable subscript or superscript visual style
(setq org-pretty-entities t)

(setq ob-mermaid-cli-path "/usr/sbin/mmdc")

;;----------------------------------------------------
;; Markdown mode
;;----------------------------------------------------
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
(setq markdown-command "markdown_py -x markdown.extensions.extra")

;;----------------------------------------------------
;;  Fonts
;;----------------------------------------------------
(when (display-graphic-p)

  ;;(eval-when-compile (require 'cl-lib))

  (defun set-font (english chinese english-size chinese-size)
    (defvar default-font (format "%s-%f" english english-size))
    (add-to-list 'default-frame-alist `(font . ,default-font))
    (set-face-attribute 'default nil :font
        (format "%s-%f" english english-size))
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font) charset
			(font-spec :family chinese :size chinese-size))))

  (cl-ecase system-type
    (windows-nt
     (set-font "Source Code Pro" "Microsoft YaHei" 11 14)
     ;;(setq gc-cons-threshold (* 512 1024 1024))
     ;;(setq gc-cons-percentage 0.5)
     ;;(run-with-idle-timer 5 t #'garbage-collect) 
     ;;(setq garbage-collection-messages t)
     ;;(setq inhibit-compacting-font-caches t) 
     )
    (gnu/linux
     (set-font "Source Code Pro" "Source Han Sans CN" 13 14))
    (darwin
     (set-font "monospace" "STHeiti" 16 16))))

;;---------------------------------------------------------
;; magit
;;---------------------------------------------------------
(use-package magit
  :bind (("C-x g" . magit-status))
  )
;; load forge
(use-package forge
  :after magit
  :config
  (add-to-list 'forge-alist '("github.mpi-internal.com"
			      "github.mpi-internal.com/api/v3"
			      "github.mpi-internal.com" forge-github-repository)))

(defun forge-browse-buffer-file ()
  (interactive)
  (browse-url
    (let
        ((rev (magit-get-current-branch))
         (repo (forge-get-repository 'stub))
         (file (magit-file-relative-name buffer-file-name))
	 (line (format "#L%d" (line-number-at-pos))))
      (forge--format repo "https://%h/%o/%n/blob/%r/%f%L"
                     `((?r . ,rev) (?f . ,file) (?L . ,line))))))

(setq smerge-command-prefix "\C-cv")
;;----------------------------------------------------------------------
;; miscellaneous
;;---------------------------------------------------------------------

;;(ac-config-default)
;;(global-auto-complete-mode t)

(setq make-backup-files nil)

(use-package unicad)
(use-package dape
  :ensure t
  )
(server-start)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "wslview")

;;(setq visible-bell 1)

;;copy to system clipboard under tty
(use-package clipetty
  :ensure t
  :hook (after-init . global-clipetty-mode))
;; this onlywork with x11
;; (xclip-mode 1)

;; workaround copy from emacs to windows under wslg
;;(when (and (getenv "WAYLAND_DISPLAY") (not (equal (getenv "GDK_BACKEND") "x11")))
;;  (setq
;;   interprogram-cut-function
;;   (lambda (text)
;;     ;; strangest thing: gui-select-text leads to gui-set-selection 'CLIPBOARD
;;     ;; text -- if I eval that with some string, it mostly lands on the wayland
;;     ;; clipboard, but not when it's invoked from this context.
;;     ;; (gui-set-selection 'CLIPBOARD text)
;;     ;; without the charset=utf-8 in type, emacs / wl-copy will crash when you paste emojis into a windows app
;;     (start-process "wl-copy" nil "wl-copy" "--trim-newline" "--type" "text/plain;charset=utf-8"  text))))

;; clipboard under wayland
(defun wsl-copy-region-to-clipboard (start end)
  "Copy region to Windows clipboard."
  (interactive "r")
  (call-process-region start end "wl-copy" nil 0)
  (deactivate-mark))

(defun wsl-cut-region-to-clipboard (start end)
  (interactive "r")
  (call-process-region start end "wl-copy" nil 0)
  (kill-region start end))

(defun wsl-clipboard-to-string ()
  "Return Windows clipboard as string."
  (let ((coding-system-for-read 'dos))
    (substring; remove added trailing \n
     (shell-command-to-string
      "wl-paste") 0 -1)))

(defun wsl-paste-from-clipboard (arg)
  "Insert Windows clipboard at point. With prefix ARG, also add to kill-ring"
  (interactive "P")
  (let ((clip (wsl-clipboard-to-string)))
    (insert clip)
    (if arg (kill-new clip))))

;; clipboard under terminal
; wsl-copy
(defun wsl-term-copy (start end)
  (interactive "r")
  (shell-command-on-region start end "clip.exe")
  (deactivate-mark))

; wsl-paste
(defun wsl-term-paste ()
  (interactive)
  (let ((clipboard
	 (shell-command-to-string "powershell.exe -command 'Get-Clipboard' 2> /dev/null")))
    (setq clipboard (replace-regexp-in-string "\r" "" clipboard)) ; Remove Windows ^M characters
    (setq clipboard (substring clipboard 0 -1)) ; Remove newline added by Powershell
    (insert clipboard)))

(define-key global-map (kbd "C-x C-y") 'wsl-term-paste)
(define-key global-map (kbd "C-x M-w") 'wsl-term-copy)
;;(define-key global-map (kbd "C-x C-w") 'wsl-cut-region-to-clipboard) ;; conflict with saveas

;;;; use wl-copy and incept cut/paste function
;;(setq wl-copy-process nil)
;;(defun wl-copy (text)
;;  (setq wl-copy-process (make-process :name "wl-copy"
;;                                      :buffer nil
;;                                      :command '("wl-copy" "-f" "-n")
;;                                      :connection-type 'pipe))
;;  (process-send-string wl-copy-process text)
;;  (process-send-eof wl-copy-process))
;;(defun wl-paste ()
;;  (if (and wl-copy-process (process-live-p wl-copy-process))
;;      nil ; should return nil if we're the current paste owner
;;      (shell-command-to-string "wl-paste -n | tr -d \r")))
;;(setq interprogram-cut-function 'wl-copy)
;;(setq interprogram-paste-function 'wl-paste)

(use-package vterm
    :ensure t)
(su-mode +1)

(global-set-key [f2] 'vterm-toggle)
(global-set-key [C-f2] 'vterm-toggle-cd)

(use-package typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  )

(setq auto-mode-alist
      (append '(("\\.yml\\'" . yaml-ts-mode)
		("\\.yaml\\'" . yaml-ts-mode))
		auto-mode-alist))

(ctrlf-mode +1)

(recentf-mode t)

(corfu-prescient-mode t)
(vertico-prescient-mode t)

(use-package graphviz-dot-mode
  :ensure t)

;;-------------------------------------------------
;; china hoilday
;;---------------------------------------------
(use-package cal-china-x
  :config
  (setq mark-holidays-in-calendar t)
  (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
  (setq cal-china-x-general-holidays
	'((holiday-lunar 1 15 "元宵节")
	  (holiday-fixed 3 8 "妇女节")
          (holiday-fixed 3 12 "植树节")
	  (holiday-fixed 5 4 "青年节")
          (holiday-fixed 6 1 "儿童节")
	  (holiday-lunar 9 9 "重阳节")
          (holiday-fixed 9 10 "教师节")))
  (setq other-holidays 
	'((holiday-fixed 2 14 "情人节")
          (holiday-fixed 4 1 "愚人节")
          (holiday-fixed 12 25 "圣诞节")
          (holiday-float 5 0 2 "母亲节")
          (holiday-float 6 0 3 "父亲节")
          (holiday-float 11 4 4 "感恩节")))
  (setq birthday-holidays
	'((holiday-fixed 8 27 "何冰清生日")
	  (holiday-fixed 8 16 "岳父生日")
	  (holiday-lunar 2 3 "妈妈生日")
	  (holiday-lunar 2 18 "爸爸生日")
	  (holiday-fixed 11 18 "宝宝生日")
	  (holiday-lunar 12 25 "万健生日")
	  (holiday-lunar 12 17 "奶奶生日")))
  (setq calendar-holidays
	(append cal-china-x-important-holidays
		cal-china-x-general-holidays
		other-holidays
		birthday-holidays))
  )
;; (setq calendar-holidays cal-china-x-important-holidays) ;; import holiday only

;;--------------------------------------------------------------------
;; tramp
;;--------------------------------------------------------------------
;; for two factor authorization
(customize-set-variable
 'tramp-password-prompt-regexp
  (concat
   "^.*"
   (regexp-opt
    '("passphrase" "Passphrase"
      ;; English
      "password" "Password"
      ;; two factor
      "YUBIKEY")
    t)
   ".*:\0? *"))

;;--------------------------------------------------
;; eglot + treesitter
;;--------------------------------------------------

(use-package treesit
  :config
  (setq major-mode-remap-alist
	'((bash-mode . bash-ts-mode)
	  (css-mode . css-ts-mode)	  
	  (go-mode . go-ts-mode)
	  (go-dot-mod-mode . go-mod-ts-mode)
	  (js-mode . js-ts-mode)
	  (json-mode . json-ts-mode)
	  (rust-mode . rust-ts-mode)
	  (typescript-mode . typescript-ts-mode)
	  (python-mode . python-ts-mode)
	  (yaml-mode . yaml-ts-mode)))
  (setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
  )

(use-package eglot
  :ensure t
  :defer t
  :hook (
	 (bash-ts-mode . eglot-ensure)
	 (css-ts-mode . eglot-ensure)
	 (go-ts-mode . eglot-ensure)
	 (go-mod-ts-mode . eglot-ensure)
	 (html-mode . eglot-ensure)
	 (js-ts-mode . eglot-ensure)
	 (python-ts-mode . eglot-ensure)
	 (rust-ts-mode . eglot-ensure)
	 (tsx-ts-mode . eglot-ensure)
	 (typescript-ts-mode . eglot-ensure)
	 (yaml-ts-mode . eglot-ensure)
	 (java-mode . eglot-ensure)
	 (scala-mode . eglot-ensure)
	 )
  )

(setq python-flymake-command '("flake8" "-") )

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;(add-hook 'after-init-hook 'global-company-mode)
;;(company-quickhelp-mode)
;; (setq completion-ignore-case t)      ;company-capf匹配时不区分大小写

(use-package corfu
  ;; Optional customizations
  :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

;;(unless (display-graphic-p)
;;  (corfu-terminal-mode +1))

;;---------------------------------------------------
;; lsp
;;---------------------------------------------------
;;(require 'lsp-mode)
;;;;(require 'lsp-python-ms)
;;;;(setq lsp-python-ms-auto-install-server t)
;;(add-hook 'python-mode-hook #'lsp-deferred)
;;(add-hook 'go-mode-hook #'lsp-deferred)
;;(add-hook 'js-mode-hook #'lsp-deferred)
;;(add-hook 'typescript-mode-hook #'lsp-deferred)
;;(add-hook 'rust-mode-hook #'lsp-deferred)
;;;; Set up before-save hooks to format buffer and add/delete imports.
;;;; Make sure you don't have other gofmt/goimports hooks enabled.
;;(defun lsp-go-install-save-hooks ()
;;  (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;  (add-hook 'before-save-hook #'lsp-organize-imports t t))
;;(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
;;;; disable signature documentation but keep signature in the minibuffer
;;;;(setq lsp-signature-render-documentation nil)
;;;; showing flymake diagnostics at point
;;(with-eval-after-load 'flymake
;;  (require 'flymake-diagnostic-at-point)
;;  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))
;;(add-hook 'python-mode-hook (lambda () (setq lsp-pylsp-plugins-pyflakes-enabled t)))


;;------------------------------------------------------
;; lsp-bridge
;;------------------------------------------------------
;;(require 'pyvenv)
;;
;;(require 'posframe)
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/lsp-bridge")
;;
;;;;(require 'yasnippet)
;;;;(yas-global-mode 1)
;;
;;(require 'lsp-bridge)
;;(setq lsp-bridge-default-mode-hooks
;;        (remove 'org-mode-hook lsp-bridge-default-mode-hooks))
;;
;;;; handle venv
;;(defun local/lsp-bridge-get-single-lang-server-by-project (project-path filepath)
;;  (let* ((json-object-type 'plist)
;;         (custom-dir (expand-file-name ".cache/lsp-bridge/pyright" user-emacs-directory))
;;         (custom-config (expand-file-name "pyright.json" custom-dir))
;;         (default-config (json-read-file (expand-file-name "site-lisp/lsp-bridge/langserver/pyright.json" user-emacs-directory)))
;;         (settings (plist-get default-config :settings))
;;         )
;;
;;    (plist-put settings :pythonPath (executable-find "python"))
;;
;;    (make-directory (file-name-directory custom-config) t)
;;
;;    (with-temp-file custom-config
;;      (insert (json-encode default-config)))
;;
;;    custom-config))
;;
;;(add-hook 'python-mode-hook (lambda () (setq-local lsp-bridge-get-single-lang-server-by-project 'local/lsp-bridge-get-single-lang-server-by-project)))
;;
;;(add-hook 'pyvenv-post-activate-hooks
;;          (lambda ()
;;            (lsp-bridge-restart-process)))
;;
;;(setq lsp-bridge-enable-hover-diagnostic t)
;;
;;(global-lsp-bridge-mode)
;;
;;(define-key lsp-bridge-mode-map [remap xref-find-definitions] 'lsp-bridge-find-def)
;;(define-key lsp-bridge-mode-map [remap xref-go-back] 'lsp-bridge-find-def-return)
;;(define-key lsp-bridge-mode-map [remap xref-find-references] 'lsp-bridge-find-references)
;;(define-key lsp-bridge-mode-map (kbd "M-/") 'lsp-bridge-find-impl)

;;;;------------------------------------------------------
;;;; EAF
;;;;------------------------------------------------------
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
;;(require 'eaf)
;;(require 'eaf-jupyter)
;;(require 'eaf-git)
;;(require 'eaf-markdown-previewer)
;;(require 'eaf-rss-reader)
;;(require 'eaf-terminal)
;;(require 'eaf-pdf-viewer)
;;(require 'eaf-image-viewer)
;;(require 'eaf-system-monitor)
;;(require 'eaf-map)
;;(require 'eaf-org-previewer)
;;(require 'eaf-browser)
;;(require 'eaf-file-manager)

;;---------------------------------------------------
;; ivy
;;---------------------------------------------------
;;(ivy-mode)
;;(setq ivy-use-virtual-buffers t)
;;(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
;;(global-set-key "\C-s" 'swiper)
;;(global-set-key (kbd "M-x") 'counsel-M-x)
;;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;(global-set-key (kbd "M-y") 'counsel-yank-pop)
;;(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
;;(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
;; make user input as a select item, so it will not always autocomplete our input
;;(setq ivy-use-selectable-prompt t)

;;---------------------------------------------------
;; vertico + orderless + marginalia
;;---------------------------------------------------
;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)
  )

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind (
;;	 ("C-s" . consult-line)
	 ("C-x b" . consult-buffer)
	 ("M-g i" . consult-imenu)
	 ("M-g M-g" . consult-goto-line)
	 :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element
  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  )

;;;; Enable rich annotations using the Marginalia package
;;(use-package marginalia
;;  ;; The :init section is always executed.
;;  :init
;;
;;  ;; Marginalia must be activated in the :init section of use-package such that
;;  ;; the mode gets enabled right away. Note that this forces loading the
;;  ;; package.
;;  (marginalia-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package fzf
  :bind
    ;; Don't forget to set keybinds!
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))
;;---------------------------------------------------
;; input method
;;---------------------------------------------------
(use-package pyim
  :config
  (setq default-input-method "pyim")
  )
(use-package pyim-wbdict
  :config
  (setq pyim-default-scheme 'wubi)
  (pyim-wbdict-v86-enable)
  )

;;---------------------------------------------------
;; disable mouse
;;---------------------------------------------------
;;(global-unset-key [M-mouse-1])
(global-unset-key [M-drag-mouse-1])
(global-unset-key [M-down-mouse-1])
(global-unset-key [M-mouse-3])
(global-unset-key [M-mouse-2])

;;----------------------------------------------------
;; js indent
;;----------------------------------------------------
(defun my-setup-indent ()
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq javascript-indent-level 2)
        (setq js-indent-level 2)
        (setq js2-basic-offset 2)))

  (if (eq major-mode 'web-mode)
      (progn
	(setq web-mode-markup-indent-offset 2)
        (setq web-mode-css-indent-offset 2)
        (setq web-mode-code-indent-offset 2)))

  (if (eq major-mode 'css-mode)
      (setq css-indent-offset 2))

  (setq indent-tabs-mode nil))

(add-hook 'web-mode-hook 'my-setup-indent)
(add-hook 'js2-mode-hook 'my-setup-indent)
(add-hook 'js-mode-hook 'my-setup-indent)
(add-hook 'css-mode-hook 'my-setup-indent)

;;------------------------------------------------------
;; puml
;;-----------------------------------------------------
(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))

(defun puml-export ()
  (interactive)
  (let ((img-file (concat (file-name-sans-extension (buffer-file-name)) ".svg")))
    (shell-command (format "java -jar /usr/share/java/plantuml/plantuml.jar -tsvg %s" (buffer-file-name)))
    (message "Convert finish: %s" img-file)))

(defun puml-compile-command ()
  (interactive)
  (let ((choice (completing-read "Select: " '("export" "preview"))))
    (if (equal choice "preview")
	  (call-interactively #'plantuml-perview)
    (call-interactively #'puml-export))))

(add-hook 'plantuml-mode-hook
	  #'(lambda ()
	     (local-set-key "\C-cc" #'puml-compile-command)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
