;;; org-zola-auto-export-mode.el --- Minor mode for auto-exporting using ox-zola -*- lexical-binding: t; -*-
;;
;; Author:  <bonini.physics@gmail.com>
;; Created: February 09, 2025
;; Homepage: https://github.com/jrbp/ox-zola
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; This is a minor mode for enabling auto-exporting of Org files via
;; ox-zola. It is an adaptation of the analagous code for ox-hugo.
;;
;; *It is NOT a stand-alone package.*
;;
;;; Usage:
;;
;; To enable this minor mode for a "content-org" directory, add below
;; to the .dir-locals.el:
;;
;;   (("content-org/"
;;     . ((org-mode . ((eval . (org-zola-auto-export-mode)))))))

;;; Code:

(declare-function ox-zola-export-wim-to-md "ox-zola")

(defun ox-zola-export-wim-to-md-after-save ()
  "Function for `after-save-hook' to run `ox-zola-export-wim-to-md'.

The exporting happens only when Org Capture is not in progress."
  (unless (eq real-this-command 'org-capture-finalize)
    (save-excursion
      (ox-zola-export-wim-to-md))))

;;;###autoload
(define-minor-mode org-zola-auto-export-mode
  "Toggle auto exporting the Org file using `ox-zola'."
  :global nil
  :lighter ""
  (if org-zola-auto-export-mode
      ;; When the mode is enabled
      (progn
        (add-hook 'after-save-hook #'ox-zola-export-wim-to-md-after-save :append :local))
    ;; When the mode is disabled
    (remove-hook 'after-save-hook #'ox-zola-export-wim-to-md-after-save :local)))

(provide 'org-zola-auto-export-mode)
;;; org-zola-auto-export-mode.el ends here
