(in-package #:cl-echonest)

;; All queryparams should be utf-8 encoded.
(setf drakma:*drakma-default-external-format* :utf-8)
;; tell Drakma to handle JSON as strings
(pushnew '("application" . "json") drakma:*text-content-types*
         :test (lambda (x y)
                 (and (equalp (car x) (car y))
                      (equalp (cdr x) (cdr y)))))

;;;; Echonest API Configuration
(defvar *api-version* "4"
  "The supported echonest API version.")

(defvar *api-url*
  (format nil "http://developer.echonest.com/api/v~d" *api-version*)
  "The URL for echonest API calls.")

(defparameter *api-key* ""
  "A valid echonest API key.")

;; non-commercial users should expect a rate limit of 120 calls per minute
