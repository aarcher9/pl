sostituisci(_, _, [], []).

sostituisci(X, Y, [X | T], [Y | Out]) :-
        sostituisci(X, Y, T, Out).

sostituisci(X, Y, [H | T], [H | Out]) :-
        sostituisci(X, Y, T, Out).