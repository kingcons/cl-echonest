(in-package :cl-echonest)

(defvar *error-codes*
  '((-1 . "Unknown Error")
    (0 . "Success")
    (1 . "Missing/Invalid API Key")
    (2 . "This API Key is not allowed to call this method")
    (3 . "Rate Limit Exceeded")
    (4 . "Missing Parameter")
    (5 . "Invalid Parameter")))

(defun error-message (errcode)
  (rest (nth errcode *error-codes*)))
