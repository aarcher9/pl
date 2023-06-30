# pl


Programming Languages exercises.



### Prolog

**Non interactive execution**

> $ swipl [FILE] -g 'nl' -t halt


**Load file**

> $ swipl -l [FILE]

> $ swipl -q -l [FILE]


**Run queries from file (does not print welcome message)**

> $ swipl -l db.pl -g 'true' -g 'nl' < [FILE]


### C++

**Compile**

> $ g++ [files.cpp] -o main; ./main


### LISP

**Docs**

[https://lispcookbook.github.io/cl-cookbook]
[http://www.lispworks.com/documentation]


**Run**

> sbcl --script main.lisp


