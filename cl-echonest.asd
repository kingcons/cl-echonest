(defsystem :cl-echonest
  :name "cl-echonest"
  :description "A Common Lisp binding to the echonest.com API"
  :version "0.0.1"
  :author "Brit Butler <redline6561@gmail.com>"
  :license "BSD"
  :depends-on (:cl-web-utils)
  :serial t
  :components ((:module src
		:components ((:file "packages")
			     (:file "config")
			     (:file "echonest")
			     (:file "artist")
			     (:file "song")))))
