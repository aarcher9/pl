rule(append([], X, X)).
rule(append([X | Xs], Ys, [X | Zs]), [append(Xs, Ys, Zs)]).


solve(Goal) :- solve(Goal, []).

solve([], []).

solve([], [G | Goals]) :-
        solve(G, Goals).

solve([A | B], Goals) :-
        append(B, Goals, BGoals),
        solve(A, BGoals).

solve(A, Goals) :-
        rule(A),
        solve(Goals, []).

solve(A, Goals) :-
        rule(A, B),
        solve(B, Goals).