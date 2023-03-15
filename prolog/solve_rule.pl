%%%% -*- Mode: Prolog -*-

solve(Goal) :- solve(Goal, []).
solve([], []).

solve([], [G | Goals]) :-
    solve(G, Goals).

solve([A | B], Goals) :-
    append(B, Goals, BGoals),
    solve(A, BGoals).

solve(A, Goals) :-
    rule(A, A),
    solve(Goals, []).

solve(A, Goals) :-
    rule(A, B),
    solve(B, Goals).
