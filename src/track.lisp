(in-package :cl-echonest)

;; TODO: Make this not suck.
;; Track methods on pathnames should return track instances.

(defclass track ()
  ;; Define some helpers, get-file, get-analysis
  ((filepath)
   (echonest-id)
   (analysis)))

(defun get-analysis (track-json)
  (let* ((url (getjso* "audio_summary.analysis_url" track-json))
         (params-idx (position #\? url))
         ;; KLUDGE: drakma::dissect-query and hunchentoot::url-decode are
         ;; needed just to pass the signature correctly :-/ WTF
         (params (mapcar (lambda (pair)
                           (cons (car pair) (%url-decode (cdr pair))))
                         (drakma::dissect-query (subseq url (1+ params-idx))))))
    (st-json:read-json (drakma:http-request (subseq url 0 params-idx)
                                            :parameters params))))

(defmethod analyze ((file pathname))
  (let ((result (echonest-call "track" "analyze"
                               `(("md5" . ,(md5sum file))
                                 ("bucket" . "audio_summary"))
                               :method :post)))
    (getjso* "track" result)))

(defmethod analyze ((id string))
  (let ((result (echonest-call "track" "analyze"
                               `(("id" . ,id)
                                 ("bucket" . "audio_summary"))
                               :method :post)))
    (getjso* "track" result)))

(defmethod profile ((file pathname))
  (let ((result (echonest-call "track" "profile"
                               `(("md5" . ,(md5sum file))
                                 ("bucket" . "audio_summary")))))
    (getjso* "track" result)))

(defmethod profile ((id string))
  (let ((result (echonest-call "track" "profile"
                               `(("id" . ,id)
                                 ("bucket" . "audio_summary")))))
    (getjso* "track" result)))

(defmethod upload ((file pathname) &optional (wait "false"))
  (let ((result (echonest-call "track" "upload"
                               `(("track" . ,file)
                                 ("filetype" . ,(pathname-type file))
                                  ("wait" . ,wait)
                                 ,@(when (string= wait "true")
                                     `(("bucket" . "audio_summary"))))
                               :method :post)))
    (getjso* "track" result)))
