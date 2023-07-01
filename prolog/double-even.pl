double_even([], []).

double_even([F | Tail], [D | Sol]) :-
        double_even(Tail, Sol),
        0 is F mod 2, D is 2 * F.

double_even([F | Tail], [F | Sol]) :-
        double_even(Tail, Sol),
        not(0 is F mod 2).