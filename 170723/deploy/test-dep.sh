#!/bin/bash
cp ../km.lisp km-c.lisp
cp ../test.lisp test.lisp
cp ../km.pl km-c.pl
cp ../test.pl test.pl

echo "Copy done. When km-c.* files are indented press return."
read $v
cut -c 1-80 km-c.lisp > km.lisp
cut -c 1-80 km-c.pl > km.pl

rm km-c.lisp
rm km-c.pl
