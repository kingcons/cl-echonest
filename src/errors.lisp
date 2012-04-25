(in-package :cl-echonest)

(define-condition echonest-error (error)
  ((message :initarg :message :reader message))
  (:report (lambda (condition stream)
             (format stream "~A" (message condition))))
  (:documentation "The base condition for all errors in ROMREADER."))

(defvar *response-codes*
  '((-1 . "Unknown Error")
    (0 . "Success")
    (1 . "Missing/ Invalid API Key")
    (2 . "This API key is not allowed to call this method")
    (3 . "Rate Limit Exceeded")
    (4 . "Missing Parameter")
    (5 . "Invalid Parameter"))
  "A list of echonest response codes. Duh.
From http://api.echonest.com/docs/v4/index.html#response-codes")

(defun response-message (respcode)
  "Retrieve the message corresponding to the number RESPCODE."
  (rest (nth (1+ respcode) *response-codes*)))
