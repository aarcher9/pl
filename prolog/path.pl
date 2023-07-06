path(X, Z) :- arc(X, Y), path(Y, Z).
path(X, X).
arc(d, c).