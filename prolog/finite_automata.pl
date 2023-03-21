%%%% -*- Mode: Prolog -*-


% ARCHI
arc(p1, a, p2).
arc(p3, b, p6).
arc(p1, c, p6).
arc(p4, d, p5).
arc(p3, e, p5).
arc(p5, f, p4).
arc(p2, g, p3).
arc(p3, h, p2).
arc(p4, i, p3).
arc(p1, j, p1).
arc(p6, k, p2).


% Logica esecutiva

% Se non usassi il 'cut', il prompt mi chiederebbe ogni volta conferma della scelta. Non ne ho bisogno poichè ho definito ogni etichetta come unica nell' automa. Quindi una volta trovati Start e End che stanno ai capi dell'arco Label posso interrompere il backtracking perchè non esisteranno alternative.

arc(Label) :- arc(Start, Label, End), !.


% NODI iniziali e finali

initial(Label) :- arc(Start, Label, End), !, Start == p1.
final(Label) :- arc(Start, Label, End), !, End == p6.



accept([L | T]) :-
    arc(L),
    !,
    (length(T, 0) -> final(L) ; accept(T)).

recognize([I | T]) :-
    initial(I),
    (length(T, 0) -> final(I) ; accept(T)).

