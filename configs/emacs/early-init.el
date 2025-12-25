;; early-init.el
(setq gc-cons-threshold most-positive-fixnum)  ; Disable GC during startup
(setq package-enable-at-startup nil)           ; Disable early package loading
(setq frame-inhibit-implied-resize t)          ; Prevent frame resizing

;; Disable unnecessary UI elements immediately
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
