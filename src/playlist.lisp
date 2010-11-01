(in-package :cl-echonest)

(defechocall playlist/static ()
  type artist-pick variety artist-id
  artist artist-seed-catalog song-id
  description results max-tempo
  min-tempo max-duration min-duration
  max-loudness min-loudness max-danceability
  min-danceability max-energy min-energy
  artist-max-familiarity artist-min-familiarity
  artist-max-hotttnesss artist-min-hotttnesss
  song-max-hotttnesss song-min-hotttnesss
  min-longitude max-longitude min-latitude max-latitude
  mode key bucket sort limit)

(defechocall playlist/dynamic ()
  session-id dmca rating chain-xspf)
