(in-package :cl-echonest)

(defun format-md5 (byte-vector)
  "Given a BYTE-VECTOR, coerce it to a list and print it in hexadecimal."
  (format nil "~(~{~2,'0X~}~)" (coerce byte-vector 'list)))

(defmethod md5sum ((string string))
  "Creates an MD5 byte-array of STRING and prints it as lower-case hexadecimal."
  (let ((string (string-to-octets string :external-format :utf-8)))
    (format-md5 (md5:md5sum-sequence string))))

(defmethod md5sum ((file pathname))
  "Creates an MD5 byte-array of FILE and prints it as lower-case hexadecimal."
  (format-md5 (md5:md5sum-file file)))

(defun echonest-call (type name params &key (method :get) (format "json"))
  (let ((url (format nil "~a/~a/~a" *api-url* type name)))
    (multiple-value-bind (response status headers)
        (drakma:http-request url :method method
                             :parameters (append `(("format" . ,format)
                                                   ("api_key" . ,*api-key*))
                                                 params))
      (if (= status 200)
          response
          (error 'echonest-error :message response)))))
