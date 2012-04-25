(in-package :cl-echonest)

;; TODO: Make this not suck.
;; Track methods on pathnames should return track instances.

(defclass track ()
  ;; Define some helpers, get-file, get-analysis
  ((filepath)
   (id-or-md5)
   (analysis)))

(defun get-analysis (track-json)
  (let* ((url (getjso* "audio_summary.analysis_url" track-json))
         (params-idx (position #\? url))
         ;; KLUDGE: drakma::dissect-query and hunchentoot::url-decode are
         ;; needed just to pass the signature correctly :-/ WTF
         (params (mapcar (lambda (pair)
                           (cons (car pair) (url-decode (cdr pair))))
                         (drakma::dissect-query (subseq url (1+ params-idx))))))
    (st-json:read-json (drakma:http-request (subseq url 0 params-idx)
                                            :parameters params))))

(defmethod analyze ((file pathname))
  (let ((result (echonest-call "track" "analyze"
                               `(("md5" . ,(md5sum file))
                                 ("bucket" . "audio_summary"))
                               :method :post)))
    (getjso* "track" result)))

(defmethod profile ((file pathname))
  (let ((result (echonest-call "track" "profile"
                               `(("md5" . ,(md5sum file))
                                 ("bucket" . "audio_summary")))))
    (getjso* "track" result)))

;; TODO: Why does this die mid-upload? Am I doing something wrong to get dropped?
(defmethod upload ((file pathname) &optional (wait "false"))
  (let ((result (echonest-call "track" "upload"
                               `(("wait" . ,wait)
                                 ,@(when (string= "true" wait)
                                     '(("bucket" . "audio_summary")))
                                 ("url" . ,(pathname-name file))
                                 ("filetype" . ,(pathname-type file))
                                 ("track" . ,file))
                               :method :post :form-data t)))
    (getjso* "track" result)))
