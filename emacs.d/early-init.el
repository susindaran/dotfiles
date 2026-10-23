;;; early-init.el --- Early startup settings -*- lexical-binding: t; -*-

;; Work around the bundled native compiler's macOS version detection.
(when (eq system-type 'darwin)
  (setenv "MACOSX_DEPLOYMENT_TARGET" "14.0"))

;;; early-init.el ends here
