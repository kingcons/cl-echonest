(in-package :cl-echonest)

(defun format-md5 (byte-vector)
  "Given a BYTE-VECTOR, coerce it to a list and print it in hexadecimal."
  (format nil "~(~{~2,'0X~}~)" (coerce byte-vector 'list)))

(defgeneric md5sum (object)
  (:documentation "Creates an MD5 byte-array of OBJECT and prints it as lower-case hexadecimal."))

(defmethod md5sum ((string string))
  (let ((string (string-to-octets string :external-format :utf-8)))
    (format-md5 (md5:md5sum-sequence string))))

(defmethod md5sum ((file pathname))
  (format-md5 (md5:md5sum-file file)))

(defun echonest-call (type name params &key (method :get) (format "json"))
  (let ((url (format nil "~a/~a/~a" *api-url* type name)))
    (multiple-value-bind (response status headers)
        (drakma:http-request url :method method :content-length t
                             :parameters (append `(("format" . ,format)
                                                   ("api_key" . ,*api-key*))
                                                 params))
      (if (and (= status 200) (search "\"code\": 0" response))
          (st-json:getjso "response" (st-json:read-json response))
          (error 'echonest-error :message response)))))

;; Lovingly stolen from hunchentoot
(defun %url-decode (string)
  "Decodes a URL-encoded STRING"
  (when (zerop (length string))
    (return-from %url-decode ""))
  (let ((vector (make-array (length string) :element-type 'octet :fill-pointer 0))
        (i 0)
        unicodep)
    (loop
      (unless (< i (length string))
        (return))
      (let ((char (aref string i)))
        (labels ((decode-hex (length)
                   (prog1
                       (parse-integer string :start i :end (+ i length) :radix 16)
                     (incf i length)))
                 (push-integer (integer)
                   (vector-push integer vector))
                 (peek ()
                   (aref string i))
                 (advance ()
                   (setq char (peek))
                   (incf i)))
          (cond
            ((char= #\% char)
             (advance)
             (cond
               ((char= #\u (peek))
                (unless unicodep
                  (setq unicodep t)
                  (upgrade-vector vector '(integer 0 65535)))
                (advance)
                (push-integer (decode-hex 4)))
               (t
                (push-integer (decode-hex 2)))))
            (t
             (push-integer (char-code (case char
                                        ((#\+) #\Space)
                                        (otherwise char))))
             (advance))))))
    (cond (unicodep
           (upgrade-vector vector 'character :converter #'code-char))
          (t (flexi-streams:octets-to-string vector)))))
