(in-package :cl-echonest)

(defun song-search (artist &optional title)
  (let ((result (echonest-call "song" "search"
                               `(("artist" . ,artist)
                                 ,@(when title
                                     `(("title" . ,title)))))))
    (getjso* "songs" result)))
