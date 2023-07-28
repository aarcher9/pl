#!/bin/bash
cp ../km.lisp ./km.lisp
cp ../km.pl ./km.pl

cut -c 1-80 km.lisp > km-cut.lisp
sbcl --script km-cut.lisp 

cut -c 1-80 km.pl > km-cut.pl
swipl -q -l km-cut.pl
