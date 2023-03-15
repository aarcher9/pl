%%%% -*- Mode: Prolog -*-


cat(tom).
cat(boot).
cat(jerry).
meows(boot).
mouse(jerry).
chimera(X) :- cat(X), mouse(X).


% Il primo è figlio del secondo
child(mattia, roman).
child(mattia, gian).
child(marco, ada).
child(gigi, marco).
child(gigi, mina).
child(mario, mina).
