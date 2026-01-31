;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. "~/.mycontribs/")
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     git
     helm
     ;; lsp
     ;; markdown
     multiple-cursors
     org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     (org :variables org-enable-trello-support t)
     ;; spell-checking
     ;; syntax-checking
     version-control
     treemacs
     tabs)


   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages
   '(
     git-auto-commit-mode
     org-cliplink
     (elgantt :location local))  ;; removed ox-html org-table

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need to
   ;; compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;;
   ;; WARNING: pdumper does not work with Native Compilation, so it's disabled
   ;; regardless of the following setting when native compilation is in effect.
   ;;
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'nil

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "all-the-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-light
                         spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. This setting has no effect when
   ;; running Emacs in terminal. The font set here will be used for default and
   ;; fixed-pitch faces. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '("Go Mono"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab t

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'nil

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; It is also possible to use a posframe with the following cons cell
   ;; `(posframe . position)' where position can be one of `center',
   ;; `top-center', `bottom-center', `top-left-corner', `top-right-corner',
   ;; `top-right-corner', `bottom-left-corner' or `bottom-right-corner'
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default t) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' to obtain fullscreen
   ;; without external boxes. Also disables the internal border. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes the
   ;; transparency level of a frame background when it's active or selected. Transparency
   ;; can be toggled through `toggle-background-transparency'. (default 90)
   dotspacemacs-background-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols nil

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Color highlight trailing whitespace in all prog-mode and text-mode derived
   ;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
   ;; (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )


(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )


(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  (add-to-list 'load-path "/home/dev/.emacs.d/private/local/taskjuggler")
  (require 'ox-taskjuggler)
  (require 'org-table)
  (require 'ox-html)
  (require 'ox-md)
  ;; (require 'elgantt)  ;; can't get dependencies right
  ;; these were first set using Customize, but don't seem to work all that well?
  (setq system-time-locale "C")
  (setq blink-cursor-interval 0.3)
  (setq blink-cursor-mode t)
  (setq golden-ratio-mode 1)
  (setq org-export-backends '(ascii html latex md odt))
  (setq org-export-initial-scope 'subtree)
  (setq org-clock-report-include-clocking-task t)
  (setq org-log-note-clock-out t)
  (setq org-time-stamp-rounding-minutes '(0 0))
  (setq evil-jumps-across-buffers nil)
  (setq org-file-apps
        '(("\\.png\\'" . default)
          (auto-mode . emacs)
          (directory . emacs)
          ("\\.mm\\'" . default)
          ("\\.x?html?\\'" . default)
          ("\\.pdf\\'" . default)))
  (setq org-use-sub-superscripts nil)
  (setq org-export-with-sub-superscripts nil)
  (setq org-export-with-broken-links 'mark)
  (setq evil-escape-key-sequence "ii")
  (setq evil-escape-delay 0.3)
  (setq org-taskjuggler-process-command "c:\\ruby33-x64\\bin\\tj3 --silent --output-dir %o %f")
  (setq browse-url-browser-function 'browse-url-xdg-open)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
  (setq org-latex-compiler "tectonic")
  (setq org-latex-pdf-process
        '("tectonic -X compile %f"))

  ;; progress summary per tag
  (defun my-org-subtree-progress ()
    "Calculate and update per-tag TODO progress in the parent subtree, including untagged tasks."
    (interactive)
    (save-excursion
      ;; Move to the parent heading if available
      (when (org-up-heading-safe)
        (let* ((tags-progress '())
               (untagged-counts '(0 0)) ;; Count of untagged tasks [Total, Done]
               (heading (org-get-heading t t t t))
               (tasks (org-map-entries t "TODO|DONE" 'tree))
               tag-counts)

          ;; Count the tasks for each tag and untagged tasks
          (dolist (task tasks)
            (org-back-to-heading t)
            (let ((tags (org-get-tags)))
              (if tags
                  (dolist (tag tags)
                    (setq tag-counts
                          (assoc-default tag tags-progress #'string= (list 0 0))) ;; default to [0/0]
                    (if (org-entry-is-done-p)
                        (setf (nth 1 tag-counts) (1+ (nth 1 tag-counts)))) ;; DONE task
                    (setf (nth 0 tag-counts) (1+ (nth 0 tag-counts))) ;; Total tasks
                    (setf (alist-get tag tags-progress nil nil #'string=) tag-counts))
                ;; If no tags, update untagged counts
                (if (org-entry-is-done-p)
                    (setf (nth 1 untagged-counts) (1+ (nth 1 untagged-counts))))
                (setf (nth 0 untagged-counts) (1+ (nth 0 untagged-counts))))))

          ;; Create the progress strings for each tag
          (let ((progress-string
                 (concat
                  ;; Add untagged tasks progress
                  (when (> (car untagged-counts) 0)
                    (format "[%d/%d]" (cadr untagged-counts) (car untagged-counts)))
                  " "
                  ;; Add tagged tasks progress
                  (mapconcat (lambda (tag-count)
                               (let ((tag (car tag-count))
                                     (total (cadr tag-count))
                                     (done (caddr tag-count)))
                                 (format "%s %d/%d" tag done total)))
                             tags-progress " "))))

            ;; Update the parent heading with the progress
            (org-edit-headline (concat heading ">3 " progress-string)))))))

  ;;(add-hook 'org-after-todo-state-change-hook #'my-org-subtree-progress)

  (defun my/move-window-to-new-frame ()
    "Move the current window to a new frame."
    (interactive)
    (let ((buffer (current-buffer)))
      ;; Create a new frame
      (select-frame (make-frame-command))
      ;; Display the buffer in the new frame
      (set-window-buffer (selected-window) buffer)
      ;; Delete the window in the old frame
      (delete-other-windows)))

  ;; Optionally bind the function to a key (like 'SPC w T')
  (spacemacs/set-leader-keys "wT" 'my/move-window-to-new-frame)

  ;; custom agenda view for translations tasks
  (setq org-agenda-custom-commands
        '(("l" "Translations"
           ((agenda "" ((org-agenda-span 'month))))
           ((org-agenda-tag-filter-preset '("+translation"))))))


  ;; workflow keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)")))
  (setq org-todo-keyword-faces
        '(("WAIT" . '(shadow org-todo))))

  ;; export html with embedded images (mhtml)
  ;; https://niklasfasching.de/posts/org-html-export-inline-images/#footnote-1
  (defun my-org-html-export-to-mhtml (async subtree visible body)
    (cl-letf (((symbol-function 'org-html--format-image) 'format-image-inline))
      (org-html-export-to-html nil subtree visible body)))

  (defun format-image-inline (source attributes info)
    (let* ((ext (file-name-extension source))
           (prefix (if (string= "svg" ext) "data:image/svg+xml;base64," "data:;base64,"))
           (data (with-temp-buffer (url-insert-file-contents (concat "file:" source)) (buffer-string)))
           (data-url (concat prefix (base64-encode-string data)))
           (attributes (org-combine-plists `(:src ,data-url) attributes)))
      (org-html-close-tag "img" (org-html--make-attribute-string attributes) info)))

  (with-eval-after-load 'ox-html
    (org-export-define-derived-backend 'html-inline-images 'html
      :menu-entry '(?h "Export to HTML" ((?m "As MHTML file" my-org-html-export-to-mhtml)))))

  (defun my-org-html-export-to-mhtml-and-move (async subtree visible body)
    (interactive)
    (let* ((exported-file (my-org-html-export-to-mhtml nil subtree visible body))  ; Export to HTML
           (destination-dir "public/")
           (destination-file (concat (file-name-as-directory destination-dir)
                                     (file-name-nondirectory exported-file)))
           (link (concat "http://192.168.68.119:8088/" (file-name-nondirectory exported-file))))
      (unless (file-exists-p destination-dir)
        (make-directory destination-dir t))  ; Ensure the directory exists
      (rename-file exported-file destination-file t)  ; Move the file
      ;; Insert the link after the heading
      (save-excursion
        (org-back-to-heading t)
        (org-entry-put (point) "EXPORT_LINK" link))  ; Store link in property
      (message "Exported and moved to %s" destination-file)))

  (with-eval-after-load 'ox-html
    (org-export-define-derived-backend 'html-inline-images-move 'html
      :menu-entry '(?h "Export to HTML" ((?p "As MHTML file and move to public" my-org-html-export-to-mhtml-and-move)))))

  ;; activate org-indent-mode
  (setq org-startup-indented t)

  ;; custom key
  (spacemacs/set-leader-keys "oe" 'org-emphasize)

  ;; obsolete auto-save-visited-mode used because auto-save doesn't trigger git-auto-commit-mode
  ;; https://github.com/syl20bnr/spacemacs/issues/16432#issuecomment-2149864333
  (auto-save-visited-mode t)
  (setq auto-save-visited-file-name t)

  ;; settings for git-auto-commit-mode
  (setq-default gac-ask-for-summary-p nil)
  (setq-default gac-automatically-push-p t)
  (setq-default gac-silent-message-p t)

  ;; custom script to push card to trello when file is saved
  (defun my-org-trello-push-card-on-save ()
    (when (and (string-equal (file-name-extension buffer-file-name) "org")
               (save-excursion
                 (goto-char (point-min))
                 (re-search-forward "^\\s-*#\\+PROPERTY: board-name\\s-+" nil t)))
      (spacemacs/org-trello-push-card)))
  (add-hook 'after-save-hook 'my-org-trello-push-card-on-save)

  ;; custom script to pull repo when project is opened
  (defun my-git-pull-orgme ()
    "Perform a git pull if the current project directory contains a specific substring."
    (let ((project-root (projectile-project-root)))
      (when (and project-root
                 (string-match-p "orgme" project-root))
        (shell-command "git pull"))))
  (add-hook 'find-file-hook 'my-git-pull-orgme)
  (spacemacs/declare-prefix "og" "git")
  (spacemacs/set-leader-keys "ogp" (lambda () (interactive) (my-git-pull-orgme)))

  ;; custom script to pull buffer from trello when file is opened
  (defun my-org-trello-pull-buffer-on-open ()
    (when (and (string-equal (file-name-extension buffer-file-name) "org")
               (save-excursion
                 (goto-char (point-min))
                 (re-search-forward "^\\s-*#\\+PROPERTY: board-name\\s-+" nil t)))
      (spacemacs/org-trello-pull-buffer)))
  (add-hook 'find-file-hook 'my-org-trello-pull-buffer-on-open)

  ;; paste url as link with title
  (spacemacs/declare-prefix "ol" "link")
  (spacemacs/set-leader-keys "olc" 'org-cliplink)

  ;; use TAB to collapse sections (almost) anywhere
  (setq org-cycle-emulate-tab nil)

  ;; open file with all sections collapsed
  (setq org-startup-folded t)

  ;; automatically save buffers associated with files on buffer switch
  ;; and on windows switch
  ;; (disabled as auto-save-visited-mode seems to work!)
  ;; https://batsov.com/articles/2012/03/08/emacs-tip-number-5-save-buffers-automatically-on-buffer-or-window-switch/
  ;; (defadvice switch-to-buffer (before save-buffer-now activate)
  ;;   (when buffer-file-name (save-buffer)))
  ;; (defadvice other-window (before other-window-now activate)
  ;;   (when buffer-file-name (save-buffer)))

  ;; Keep the indentation well structured by. OMG this is a must have. Makes
  ;; it feel less like editing a big text file and more like a purpose built
  ;; editor for org mode that forces the indentation.
  (setq org-startup-indented t)

  ;; Enable automatic inline image rendering
  ;; =:org-toggle-inline-images=  to disable
  ;; http://orgmode.org/manual/In_002dbuffer-settings.html
  (setq org-startup-with-inline-images t)

  ;; image functions
  (spacemacs/declare-prefix "oi" "image")

  ;; don't include download links when pasting images
  (setq org-download-annotate-function (lambda (_link) ""))

  ;; paste image from link with fixed width
  (spacemacs/set-leader-keys "oil" 'my-org-insert-image-from-link)
  (defun my-org-insert-image-from-link ()
    (interactive)
    (insert "#+ATTR_ORG: :width 300")
    (org-download-yank)
    (org-display-inline-images)
    (shell-command "git add *.img")
    )

  ;; paste image from local file with fixed width
  (spacemacs/set-leader-keys "oif" 'my-org-insert-image-from-file)
  (defun my-org-insert-image-from-file (file-path)
    "Copy an image from a local file path to `org-download-image-dir` and insert it in org-mode."
    (interactive "fSelect image file: ")
    (let* ((org-download-image-dir (or org-download-image-dir "./images"))
           (target-path (concat (file-name-as-directory org-download-image-dir)
                                (file-name-nondirectory file-path))))
      ;; Create the directory if it doesn't exist
      (unless (file-exists-p org-download-image-dir)
        (make-directory org-download-image-dir t))
      ;; Copy the file to `org-download-image-dir`
      (copy-file file-path target-path t)
      ;; Insert the link to the copied file
      (insert (format "#+ATTR_ORG: :width 300\n[[file:%s]]\n" target-path))
      (org-display-inline-images)
      ;; Add the copied file to Git if needed
      (shell-command (format "git add %s" (shell-quote-argument target-path)))))

  ;; paste image from clipboard with fixed width
  ;; org-download-screenshot vs. org-download-clipboard??
  (spacemacs/set-leader-keys "oip" 'my-org-paste-image)
  (defun my-org-paste-image ()
    (interactive)
    (insert "#+ATTR_ORG: :width 300")
    (if (eq system-type 'gnu/linux)
        (org-download-clipboard)
      (org-download-screenshot))
    (org-display-inline-images)
    (shell-command "git add *.img")
    )
  (setq org-download-screenshot-method "powershell -c Add-Type -AssemblyName System.Windows.Forms;$image = [Windows.Forms.Clipboard]::GetImage();$image.Save('%s', [System.Drawing.Imaging.ImageFormat]::Png)")

  ;; paste image from clipboard in WSL with fixed width
  ;; https://www.alexrampp.de/articles/how-to-paste-images-into-emacs-org-mode-running-in-windows-subsystem-for-linux/
  (spacemacs/set-leader-keys "oic" 'my-org-paste-image-wsl)
  (defun my-org-paste-image-wsl ()
    "Paste an image into a time stamped unique-named file in the
  same directory as the org-buffer and insert a link to this file."
    (interactive)
    (let* ((target-file
            (concat
             (make-temp-name
              (concat (buffer-file-name)
                      ".img/"
                      (format-time-string "%Y%m%d_%H%M%S_"))) ".png"))
           (wsl-path
            (concat (as-windows-path(file-name-directory target-file))
                    "\\"
                    (file-name-nondirectory target-file)))
           (ps-script
            (concat "(Get-Clipboard -Format image).Save('" wsl-path "')"))
           (nircmd-script
            (concat "nircmd.exe clipboard saveimage '" wsl-path "'")))

      (message (run-command-sync nircmd-script))

      (if (file-exists-p target-file)
          (progn (shell-command (concat "git add " target-file))
                 (insert "#+ATTR_ORG: :width 300")
                 (newline)
                 (insert (concat "[[" target-file "]]"))
                 (org-display-inline-images))
        (user-error
         "Error pasting the image, make sure you have an image in the clipboard!"))
      ))
  (defun as-windows-path (unix-path)
    "Takes a unix path and returns a matching WSL path (e.g. \\\\wsl$\\Ubuntu-20.04\\tmp)"
    ;; substring removes the trailing \\n
    (substring
     (shell-command-to-string
      (concat "wslpath -w " unix-path)) 0 -1))
  (defun run-command-sync (command)
    "Run a command synchronously and return the output as a string."
    (let ((output (shell-command-to-string command)))
      (string-trim output)))
  (defun run-powershell-command-sync (command)
    "Run a PowerShell command synchronously and return the output as a string."
    (let ((output (shell-command-to-string (concat "powershell.exe -Command \"" command "\""))))
      (string-trim output)))

  ;; open links in WSL
  ;; https://www.reddit.com/r/bashonubuntuonwindows/comments/70i8aa/comment/dossi64/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
  (setq-default sysTypeSpecific  system-type) ;; get the system-type value

  (cond
   ;; If type is "gnu/linux", override to "wsl/linux" if it's WSL.
   ((eq sysTypeSpecific 'gnu/linux)
    (when (string-match "Linux.*Microsoft.*Linux"
                        (shell-command-to-string "uname -a"))

      (setq-default sysTypeSpecific "wsl/linux") ;; for later use.
      (setq
       cmdExeBin"/mnt/c/Windows/System32/cmd.exe"
       cmdExeArgs '("/c" "start" "") )
      (setq
       browse-url-generic-program  cmdExeBin
       browse-url-generic-args     cmdExeArgs
       browse-url-browser-function 'browse-url-generic)
      )))

  ;; navigating to a result of `SPC /` expands the entry if it was collapsed
  (defun my-org-reveal-match ()
    "Reveal the current match by expanding the entry if necessary."
    (org-show-context))

  (defun my-org-search-function ()
    "Search function that reveals the match in org mode."
    (interactive)
    (call-interactively 'spacemacs/helm-project-smart-do-search)
    (when (derived-mode-p 'org-mode)
      (my-org-reveal-match)))

  (spacemacs/set-leader-keys "/" 'my-org-search-function)

  ;; clocking
  ;; Dynamic block that renders clocking tables for 5 consecutive weeks with hours per day/per project.
  ;; Parameter: :months-back
  (defun dates-weeks-back (weeks-back)
    "return 5 dates in YYYY-MM-DD format for the weekdays of <weeks-back> ago"
    ;; ChatGPT helped me with this
    (let* ((current-date (calendar-current-date))
           (days-back (* weeks-back 7))
           (target-date (calendar-gregorian-from-absolute
                         (- (calendar-absolute-from-gregorian current-date) days-back)))
           (day-of-week (calendar-day-of-week target-date))
           (monday-date (calendar-gregorian-from-absolute
                         (- (calendar-absolute-from-gregorian target-date)
                            (if (= day-of-week 0) 6 (1- day-of-week)))))
           (weekdays (mapcar (lambda (days)
                               (let* ((date (calendar-gregorian-from-absolute
                                             (+ (calendar-absolute-from-gregorian monday-date) days)))
                                      (year (nth 2 date))
                                      (month (nth 0 date))
                                      (day (nth 1 date)))
                                 (format "%04d-%02d-%02d" year month day)))
                             '(0 1 2 3 4))))
      weekdays))

  (defun nth-elements (n list-of-lists)
    "Extracts the n-th elements from each sublist in list-of-lists."
    (mapcar (lambda (lst) (nth n lst)) list-of-lists))

  (defun union-of-lists (list-of-lists)
    "Creates a union of all elements in list-of-lists."
    (let ((result nil))
      (dolist (sublist list-of-lists result)
        (dolist (element sublist)
          (unless (member element result)
            (push element result))))
      (nreverse result)))

  (defun draw-one-week-clocking-table (weeks-back)
    (let* ((days (dates-weeks-back weeks-back))
           (data (mapcar #'(lambda (day)
                             (let ((params (list :scope 'file :maxlevel 1 :block day :link nil :narrow '20!)))
                               (list day (nth 2 (org-clock-get-table-data buffer-file-name params))))) days))
           ;; data is a list of day records (date,list of clocking records (level,heading,blah,blah,minutes,blah))
           (list-of-list-of-clocking-records (nth-elements 1 data))
           (list-of-list-of-headings (mapcar #'(lambda (list-of-clocking-records)
                                                 (nth-elements 1 list-of-clocking-records)) list-of-list-of-clocking-records))
           (unique-headings (union-of-lists list-of-list-of-headings)))
      (insert "| | ")
      (dolist (day-record data)
        (insert (format "%s | " (substring (nth 0 day-record) 5))))
      (insert "\n|-\n")
      (dolist (heading unique-headings)
        (insert (format "| %s | " (truncate-string-to-width heading 45 nil nil t)))
        (dolist (list-of-clocking-records list-of-list-of-clocking-records)
          (dolist (clocking-record list-of-clocking-records)
            (when (string= heading (nth 1 clocking-record))
              (insert (format "%.1f" (/ (nth 4 clocking-record) 60.0)))))
          (insert " |"))
        (insert "\n"))
      (insert "|-\n")))

  ;; Entry point for the dynamic block:
  (defun org-dblock-write:my-monthly-clocking-table (my-params)
    (let* ((months-back (plist-get my-params :months-back))
           (offset (round (* months-back 4.33)))  ;; on average 4.33 weeks in a month
           (start (point)))
      (dolist (weeks-back (mapcar (lambda (x) (+ x offset)) '(0 1 2 3 4)))
        (draw-one-week-clocking-table weeks-back))
      (goto-char start)
      (org-table-align)
      ))

;;; org-clock-pivot.el --- Pivot table for org-clock reports

  (defun org-clock-pivot-from-existing-tables ()
    "Convert existing daily clock report tables into a pivot table.
Place point before the first daily table."
    (interactive)
    (let ((task-data (make-hash-table :test 'equal))
          (days-order '())
          all-tasks)

      ;; Parse existing tables
      (save-excursion
        (while (re-search-forward "^Daily report: \\[\\(.*?\\)\\]" nil t)
          (let* ((date-str (match-string 1))
                 (day-name (format-time-string "%a" (org-time-string-to-time date-str))))
            (push day-name days-order)
            (forward-line 1)
            (while (looking-at "^|")
              (when (looking-at "^|\\s-*\\([^|]+?\\)\\s-*|\\s-*\\*?\\([0-9]+:[0-9]+\\)\\*?\\s-*|")
                (let* ((task (string-trim (match-string 1)))
                       (time-str (string-trim (match-string 2))))
                  (unless (or (string-match "^\\*Total time\\*" task)
                              (string-match "^Headline" task))
                    (unless (member task all-tasks)
                      (push task all-tasks))
                    (let ((task-hash (gethash task task-data)))
                      (unless task-hash
                        (setq task-hash (make-hash-table :test 'equal))
                        (puthash task task-hash task-data))
                      (puthash day-name time-str task-hash)))))
              (forward-line 1)))))

      (setq days-order (reverse days-order))
      (setq all-tasks (reverse all-tasks))

      ;; Filter out weekend days
      (setq days-order (seq-filter (lambda (day) (not (member day '("Sat" "Sun")))) days-order))

      ;; Generate pivot table
      (insert "\n** Weekly Pivot Table\n")
      (insert "| Task |")
      (dolist (day days-order)
        (insert (format " %s |" day)))
      (insert "\n|------+")
      (dolist (day days-order)
        (insert "------+"))
      (insert "\n")

      (dolist (task all-tasks)
        (insert (format "| %s |" task))
        (let ((task-hash (gethash task task-data)))
          (dolist (day days-order)
            (let ((time-str (if task-hash (gethash day task-hash "") "")))
              (if (string= time-str "")
                  (insert "  |")
                (when (string-match "\\([0-9]+\\):\\([0-9]+\\)" time-str)
                  (let* ((hours (string-to-number (match-string 1 time-str)))
                         (mins (string-to-number (match-string 2 time-str)))
                         (decimal (+ hours (/ mins 60.0))))
                    (insert (format " %.1f |" decimal))))))))
        (insert "\n"))

      ;; Add totals row
      (insert "|------+")
      (dolist (day days-order)
        (insert "------+"))
      (insert "\n| *Total* |")
      (dolist (day days-order)
        (let ((day-total 0.0))
          (dolist (task all-tasks)
            (let* ((task-hash (gethash task task-data))
                   (time-str (if task-hash (gethash day task-hash "") "")))
              (when (string-match "\\([0-9]+\\):\\([0-9]+\\)" time-str)
                (let* ((hours (string-to-number (match-string 1 time-str)))
                       (mins (string-to-number (match-string 2 time-str)))
                       (decimal (+ hours (/ mins 60.0))))
                  (setq day-total (+ day-total decimal))))))
          (insert (format " %.1f |" day-total))))
      (insert "\n")

      (org-table-align)))

  ;; Dynamic block version
  (defun org-dblock-write:pivottable (params)
    "Generate a pivot table from daily clock reports.
This is a dynamic block that can be updated with C-c C-c."
    (let ((task-data (make-hash-table :test 'equal))
          (days-order '())
          all-tasks)

      ;; Parse existing tables
      (save-excursion
        (goto-char (point-min))
        (while (re-search-forward "^Daily report: \\[\\(.*?\\)\\]" nil t)
          (let* ((date-str (match-string 1))
                 (day-name (format-time-string "%a" (org-time-string-to-time date-str))))
            (push day-name days-order)
            (forward-line 1)
            (while (looking-at "^|")
              (when (looking-at "^|\\s-*\\([^|]+?\\)\\s-*|\\s-*\\*?\\([0-9]+:[0-9]+\\)\\*?\\s-*|")
                (let* ((task (string-trim (match-string 1)))
                       (time-str (string-trim (match-string 2))))
                  (unless (or (string-match "^\\*Total time\\*" task)
                              (string-match "^Headline" task))
                    (unless (member task all-tasks)
                      (push task all-tasks))
                    (let ((task-hash (gethash task task-data)))
                      (unless task-hash
                        (setq task-hash (make-hash-table :test 'equal))
                        (puthash task task-hash task-data))
                      (puthash day-name time-str task-hash)))))
              (forward-line 1)))))

      (setq days-order (reverse days-order))
      (setq all-tasks (reverse all-tasks))

      ;; Filter out weekend days
      (setq days-order (seq-filter (lambda (day) (not (member day '("Sat" "Sun")))) days-order))

      ;; Generate pivot table
      (insert "| Task |")
      (dolist (day days-order)
        (insert (format " %s |" day)))
      (insert "\n|------+")
      (dolist (day days-order)
        (insert "------+"))
      (insert "\n")

      (dolist (task all-tasks)
        (insert (format "| %s |" task))
        (let ((task-hash (gethash task task-data)))
          (dolist (day days-order)
            (let ((time-str (if task-hash (gethash day task-hash "") "")))
              (if (string= time-str "")
                  (insert "  |")
                (when (string-match "\\([0-9]+\\):\\([0-9]+\\)" time-str)
                  (let* ((hours (string-to-number (match-string 1 time-str)))
                         (mins (string-to-number (match-string 2 time-str)))
                         (decimal (+ hours (/ mins 60.0))))
                    (insert (format " %.1f |" decimal))))))))
        (insert "\n"))

      ;; Add totals row
      (insert "|------+")
      (dolist (day days-order)
        (insert "------+"))
      (insert "\n| *Total* |")
      (dolist (day days-order)
        (let ((day-total 0.0))
          (dolist (task all-tasks)
            (let* ((task-hash (gethash task task-data))
                   (time-str (if task-hash (gethash day task-hash "") "")))
              (when (string-match "\\([0-9]+\\):\\([0-9]+\\)" time-str)
                (let* ((hours (string-to-number (match-string 1 time-str)))
                       (mins (string-to-number (match-string 2 time-str)))
                       (decimal (+ hours (/ mins 60.0))))
                  (setq day-total (+ day-total decimal))))))
          (insert (format " %.1f |" day-total))))
      (insert "\n")))


  (provide 'org-clock-pivot)
;;; org-clock-pivot.el ends here

  ;; Add this to your dotspacemacs/user-config function in .spacemacs

  ;; Enable org-clock in modeline
  (setq org-clock-clocked-in-display 'mode-line)
  (setq org-clock-mode-line-total 'current)

  ;; Use org-clock-report mechanism to get today's total
  (defun my-org-clock-get-today-total ()
    "Get total clocked time for today using org-clock-sum."
    (let ((total 0))
      (dolist (file (org-agenda-files t))
        (when (file-exists-p file)
          (with-current-buffer (find-file-noselect file)
            (save-excursion
              (save-restriction
                (widen)
                (let* ((today (format-time-string "%Y-%m-%d"))
                       (tstart (concat today " 00:00"))
                       (tend (concat today " 23:59")))
                  ;; This is what org-clock-report uses internally
                  (setq total (+ total
                                 (org-clock-sum (org-time-string-to-seconds tstart)
                                                (org-time-string-to-seconds tend))))))))))
      total))

  (defun my-org-clock-today-string ()
    "Return formatted string with today's total."
    (let ((total (my-org-clock-get-today-total)))
      (if (> total 0)
          (format " [Today: %s]" (org-duration-from-minutes total))
        "")))

  ;; Add to modeline
  (setq-default mode-line-misc-info
                (list '(org-mode-line-string (" " org-mode-line-string))
                      '(:eval (my-org-clock-today-string))))
  ;; Force modeline to refresh
  (force-mode-line-update t)

  ;; Also try setting this more explicitly
  (setq global-mode-string
        (append global-mode-string
                '((:eval (my-org-clock-today-string)))))

  ;; Update modeline every minute so the today total refreshes
  (run-with-timer 0 60 (lambda () (force-mode-line-update t)))

  ;; If you're using doom-modeline
  (with-eval-after-load 'doom-modeline
    (setq doom-modeline-display-misc-in-all-mode-lines t))

  ;; If you're using spaceline
  (with-eval-after-load 'spaceline
    (spaceline-toggle-org-clock-on))

  ;; view agenda for current buffer only
  (defvar my-org-agenda-origin-frame nil
    "Frame from which the Org agenda was opened.")

  (defun my-org-agenda-buffer-only ()
    "Open Org agenda for current buffer in a new frame, and follow links in original frame."
    (interactive)
    (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
      (setq my-org-agenda-origin-frame (selected-frame))
      (let ((agenda-frame (make-frame)))
        (select-frame-set-input-focus agenda-frame)
        (org-agenda nil "a") ;; or use a custom command
        (delete-other-windows))))

  (defun my-org-agenda-follow-in-origin-frame ()
    "Follow the Org agenda item in the original frame."
    (interactive)
    (let* ((hd-marker (get-text-property (point) 'org-hd-marker))
           (marker (or hd-marker
                       (get-text-property (point) 'org-marker))))
      (if (and marker (markerp marker))
          (progn
            (when (and my-org-agenda-origin-frame
                       (frame-live-p my-org-agenda-origin-frame))
              (select-frame-set-input-focus my-org-agenda-origin-frame))
            (org-goto-marker-or-bmk marker))
        (message "No valid Org item on this line."))))

  ;; Optional: override the default follow behavior
  (define-key org-agenda-mode-map (kbd "F") 'my-org-agenda-follow-in-origin-frame)
  (spacemacs/declare-prefix "oa" "agenda")
  (spacemacs/set-leader-keys "oaa" 'my-org-agenda-buffer-only)

  ;; convert selection from markdown to org
  (defun my-md-to-org-region (start end)
    "Convert region from markdown to org"
    (interactive "r")
    (shell-command-on-region start end "pandoc --wrap=preserve -f markdown -t org" t t))

  (spacemacs/declare-prefix "oc" "convert")
  (spacemacs/set-leader-keys "ocm" 'my-md-to-org-region)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(org-agenda-files '("/home/dev/workspace/work.org"))
   '(org-trello-current-prefix-keybinding "C-c o")
   '(package-selected-packages
     '(a ace-jump-helm-line ace-link aggressive-indent alert all-the-icons annalist
         anzu auto-compile auto-highlight-symbol browse-at-remote centaur-tabs
         centered-cursor-mode clang-format clean-aindent-mode closql code-review
         column-enforce-mode deferred define-word devdocs diff-hl diminish
         dired-quick-sort dotenv-mode drag-stuff dumb-jump eat editorconfig
         elisp-def elisp-demos elisp-slime-nav emacsql emoji-cheat-sheet-plus
         emojify emr esh-help eshell-prompt-extras eshell-z eval-sexp-fu evil-anzu
         evil-args evil-cleverparens evil-collection evil-easymotion evil-escape
         evil-evilified-state evil-exchange evil-goggles evil-iedit-state
         evil-indent-plus evil-lion evil-lisp-state evil-matchit evil-mc
         evil-nerd-commenter evil-numbers evil-org evil-surround evil-textobj-line
         evil-tutor evil-unimpaired evil-visual-mark-mode evil-visualstar
         expand-region eyebrowse fancy-battery flx-ido flycheck-elsa
         flycheck-package forge ghub git-auto-commit-mode git-commit git-link
         git-messenger git-modes git-timemachine gitignore-templates gntp gnuplot
         golden-ratio google-translate helm-ag helm-comint helm-descbinds
         helm-git-grep helm-ls-git helm-make helm-mode-manager helm-org
         helm-org-rifle helm-projectile helm-purpose helm-swoop helm-themes
         helm-xref hide-comnt highlight-indentation highlight-numbers
         highlight-parentheses hl-todo holy-mode htmlize hungry-delete hybrid-mode
         iedit indent-guide info+ inspector link-hint list-utils log4e lorem-ipsum
         macrostep magit magit-section markdown-mode multi-line multi-term
         nameless open-junk-file org-category-capture org-cliplink org-contrib
         org-download org-mime org-pomodoro org-present org-project-capture
         org-projectile org-rich-yank org-superstar org-trello orgit overseer
         paradox paredit password-generator pcre2el popwin quickrun
         rainbow-delimiters request request-deferred restart-emacs shell-pop
         smeargle solarized-theme space-doc spaceline spacemacs-purpose-popwin
         spacemacs-whitespace-cleanup string-edit-at-point string-inflection
         symbol-overlay symon term-cursor terminal-here toc-org transient
         treemacs-evil treemacs-icons-dired treemacs-magit treemacs-persp
         treemacs-projectile treepy undo-tree uuidgen vi-tilde-fringe
         vim-powerline volatile-highlights which-key winum with-editor
         writeroom-mode ws-butler yaml))
   '(safe-local-variable-values
     '((org-download-image-dir . "./home.org.img")
       (org-download-image-dir . "./work.org.img"))))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  )

;; END
