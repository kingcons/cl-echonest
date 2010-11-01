(in-package :cl-echonest)

(defechocall catalog/create (name type))

(defechocall catalog/update (id data)
  data-type)

(defechocall catalog/status (ticket))

(defechocall catalog/profile (id)
  name)

(defechocall catalog/read (id)
  bucket results start)

(defechocall catalog/delete (id))

(defechocall catalog/list ()
  results start)
