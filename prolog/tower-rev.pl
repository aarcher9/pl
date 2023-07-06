tower(t(X, Y)) :- block(X), tower(Y), on(X, Y).
tower(X) :-block(X).
block(e).
block(d).
block(c).
block(b).
block(a).
on(d, b).
on(b, a).
