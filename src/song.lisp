;; song.lisp

(in-package :cl-echonest)

;; LOTS OF DOCS NEEDED HERE
(defechocall song/search ()
  title artist combined description artist-id results
  max-tempo min-tempo max-duration min-duration
  max-loudness min-loudness max-familiarity min-familiarity
  max-hotttnesss min-hotttnesss max-longitude min-longitude
  min-latitude max-latitude mode key bucket sort limit)

;; ID can have multiple values here.
(defechocall song/profile (id)
  bucket limit)

(defechocall song/identify (id)
  query code artist title release
  duration genre bucket)
