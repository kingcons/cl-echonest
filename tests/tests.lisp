(in-package :cl-echonest-tests)

(def-suite :cl-echonest-private)
(in-suite :cl-echonest-private)

(test response-message-test
      (is (string= "Success" (cl-echonest::response-message 0))))

(test format-md5-test
      (flet ((hex-p (char)
               (let ((int (char-code char)))
                 (or (and (> int 47) (< int 58))
                     (and (> int 96) (< int 103))))))
        (let ((result (cl-echonest::format-md5 (loop for i from 0 to 255
                                                     collecting i))))
          (is (stringp result))
          (is (every #'hex-p result)))))

; TODO: md5sum-utf8-test, echonest-call-test

(def-suite :cl-echonest-public)
(def-suite :cl-echonest-public)

; TODO: track methods
