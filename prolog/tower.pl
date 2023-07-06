tower(X) :-block(X).
tower(t(X, Y)) :- block(X), tower(Y), on(X, Y).
block(a).
block(b).
block(c).
block(d).
block(e).
on(b, a).
on(d, b).