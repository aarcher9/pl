# pl
Programming Languages exercises.

**For shitty emacs**
:[]

**Non interactive execution**
> $ swipl [FILE] -g 'nl' -t halt 

**Load file (preserve colors | quiet)**
> $ swipl -l [FILE]
> $ swipl -q -l [FILE]

Running 
> $ swipl 

often prompts user to type something (e.g. when findall( , , ) is not used prolog prompt will ask user what to do next); when streaming with '<' from bash this will throw an error. Remember to implement a proper way to handle user interaction.

**Run queries from file (does not print welcome message)**
> $ swipl -l db.pl -g 'true' -g 'nl' < [FILE]

**In C++**
Compile
> $ g++ [files.cpp] -o main; ./main


**LISP**
> sbcl --noinform --script main.lisp
> sbcl --script main.lisp


