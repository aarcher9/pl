#!/bin/bash
cp km.lisp deploy/km-c.lisp
cp test.lisp deploy/test.lisp
cp test-lisp.sh deploy/test-lisp.sh

cp km.pl deploy/km-c.pl
cp test.pl deploy/test.pl
cp test-prolog.sh deploy/test-prolog.sh

echo "Copy done. When km-c.* files are indented press return."
read $v
cut -c 1-80 deploy/km-c.lisp > deploy/km.lisp
cut -c 1-80 deploy/km-c.pl > deploy/km.pl

rm deploy/km-c.lisp
rm deploy/km-c.pl
