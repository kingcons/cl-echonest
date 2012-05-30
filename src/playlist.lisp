(in-package :cl-echonest)

;; Totally busted.
(defun playlist-basic (&key (type "song-radio") (results 15) artists song-ids)
  (let ((result (echonest-call "playlist" "basic"
                               `(("type" . ,type)
                                 ("results" . ,(princ-to-string results))
                                 ;; TODO: List handling is totally F-in broken
                                 ,@(when artists
                                     `(("artist" . ,artists)))
                                 ,@(when song-ids
                                     `(("song_id" . ,song-ids)))))))
    (st-json:getjso* "songs" result)))

;; Bobby Tank - Circles: TRAHHWP136F598034A
;; Bondax - Just Us: TRVURQT136F05FEEF8
;; Montgomery Clunk - Heat: TROEYCX136F056A215
;; Bobby Tank - Needin Me: 3999c0e7710e057cf64c4dcf63ed4eb4
;; OL - IWM: TRRBVKJ136F59E016A
;; Mono/Poly - Glow: SOENCZV1315CD513E9
;; Bibio - Fire Ant: SOQFJVS131677157D0
;; Star Slinger - Mornin: SOAZZOT1338A5D6187
;; Alex B - Standing on Me:
