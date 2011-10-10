#!/bin/sh
sbcl --eval "(ql:quickload '(cl-echonest sb-introspect cl-api))" \
     --eval "(cl-api:api-gen :cl-echonest \"docs/index.html\")" \
     --eval "(progn (terpri) (sb-ext:quit))"
