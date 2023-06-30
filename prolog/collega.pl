collega(a, b).
collega(c, b).
collega(X, Z) :- collega(X, Y), collega(Y, Z).
collega(X, Y) :- collega(Y, X).
