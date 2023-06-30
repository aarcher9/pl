appendi([], Xs, Xs).
appendi([X | Xs], Ys, [X | Zs]) :- appendi(Xs, Ys, Zs).

t1(X) :- appendi([1, 2], [[3, 4], 5], X).
t2(X) :- appendi([vediamo, se, la], [[becco]], X).
t3([X | Xs]) :- appendi([vediamo], [X | Xs], [vediamo, [se, la, becco]]).
t4(X, Y) :- appendi(X, Y, [1, 2, 3]).