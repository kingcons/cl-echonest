;; artist.lisp

(in-package :cl-echonest)

;; The License keyword can be one or several of:
;; echo-source, all-rights-reserved, public-domain, unknown
;; cc-by-sa, cc-by-nc, cc-by-nc-nd, cc-by-nc-sa, cc-by-nd, cc-by

;; The Bucket keyword can be one or several of:
;; audio, biographies, blogs, familiarity, hotttnesss
;; images, news, reviews, urls, video, or id:musicbrainz

;; The Limit keyword can be one of: true, false
;; If limit is true, one idspace must be provided in bucket.

(defechocall artist/audio (id)
  (results 5) (start 0))

(defechocall artist/biographies (id)
  (results 5) (start 0) license)

(defechocall artist/blogs (id)
  (results 5) (start 0))

(defechocall artist/familiarity (id))
(defechocall artist/hotttnesss (id))

(defechocall artist/images (id)
  (results 5) (start 0) license)

(defechocall artist/news (id)
  (results 5) (start 0))

(defechocall artist/profile (id)
  bucket)

(defechocall artist/reviews (id)
  (results 5) (start 0))

;; The sounds-like and exact keywords can be one of: true, false
;; The type keyword can be one of: name, description
(defechocall artist/search (query)
  (results 5) bucket limit exact sounds-like type)

(defechocall artist/similar (id)
  (results 5) (start 0) bucket limit)

(defechocall artist/songs (id)
  name results start)

(defechocall artist/terms (id)
  name sort)

(defechocall artist/top_hottt ()
  (results 5) (start 0) bucket limit)

(defechocall artist/top_terms () results)

(defechocall artist/urls (id))

(defechocall artist/video (id)
  (results 5) (start 0))
