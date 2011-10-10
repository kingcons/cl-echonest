(defsystem #:cl-echonest
  :name "cl-echonest"
  :description "A binding to the echonest.com API"
  :version "0.1"
  :license "BSD"
  :author "Brit Butler <redline6561@gmail.com>"
  :depends-on (#:drakma #:md5 #:st-json #:flexi-streams)
  :components ((:module src
                :serial t
                :components ((:file "package")
                             (:file "config")
                             (:file "errors")
                             (:file "utils"))))
  :in-order-to ((test-op (load-op cl-echonest-tests)))
  :perform (test-op :after (op c)
                    (funcall (intern "RUN!" :cl-echonest-tests))))

(defsystem #:cl-echonest-tests
  :depends-on (cl-echonest fiveam)
  :pathname "tests/"
  :serial t
  :components ((:file "package")
               (:file "tests")))

(defmethod operation-done-p ((op test-op)
                             (c (eql (find-system :cl-echonest))))
  (values nil))
