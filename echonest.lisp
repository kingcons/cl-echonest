;; cl-echonest.lisp

(in-package :cl-echonest)

;; API Documentation:
;; http://beta.developer.echonest.com/overview.html

(defvar *base-url* "http://beta.developer.echonest.com/api/")
(defvar *id-base-url* "music://id.echonest.com/")
(defvar *api-version* "4")

(defun hyphens-to-underscores (str)
  (substitute #\_ #\- str))

(defun api-url (fn)
  (format nil "~av~a/~a" *base-url* *api-version*
          (hyphens-to-underscores (string-downcase (symbol-name fn)))))

(defmacro defechocall (name required-args &rest key-args)
  `(define-json-request ,name
       (,@required-args &key (api-key *api-key*) (format "json")
                        ,@key-args)
     ,(api-url name) :all-args-p t))

;; Former macro for XML calls. Not tested recently...
;; but you get the idea.
;; (defmacro defechocall (name item-name &rest args)
;;   `(define-xml-request ,name
;;        (&key (version *api-version*) (api-key *api-key*) ,@args)
;;      ,(api-url name) :item-name ,item-name :fields :all))
