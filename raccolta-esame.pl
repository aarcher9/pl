% Probabile, anzi quasi matematico che ci siano codici giá presenti nella repo, sono stati messi qui per comodità di accesso.


%% ===== deepest node ===== %%
find(Node, Node, CD, CD).
find(node(_, _, L, R), Node, D, ND) :- 
        CD is D + 1, 
        (find(L, Node, CD, ND) ; find(R, Node, CD, ND)).

deepest_node(Node, DN, D) :- 
        find(Node, DN, 0, D).

t_10(DN, D) :- 
        deepest_node(node(42, the_answer, nil, nil), DN, D).


%% ===== assoc_if ===== %%
is_three(3).

% Scrivendolo in questo modo appena lo trova ritorna e non cerca oltre. Importante l'ordine delle regole visto che Prolog usa la tecnica left-most.
assoc_if(_, [], []).
assoc_if(Pred, [[K, V] | _], [K, V]) :- 
        call(Pred, K).

assoc_if(Pred, [_ | Tail], Res) :- 
        assoc_if(Pred, Tail, Res).

% Singolo
t_20(R) :- 
        assoc_if(is_three, [[2, two], [3, three], [3, three_again]], R).

% Multiplo (per come implementato il predicato mi tocca usare bagof)
t_21(R, Bag) :- 
        bagof(R, assoc_if(is_three, [[2, two], [3, three], [3, three_again]], R), Bag).


%% ===== suffisso ===== %%
% S è suffisso di L
suffisso(S, S).
suffisso(S, [_ | Tail]) :-
        suffisso(S, Tail).

t_30(S) :- 
        suffisso(S, [a, s, foo(bar), 42]).

t_31 :- 
        suffisso([foo(bar)], [a, s, foo(bar), 42]).
% > false.

t_31 :- 
        suffisso([foo(bar), 42], [a, s, foo(bar), 42]).
% > true.


%% ===== double_item ===== %%
double_item([], []).
double_item([I | Tail], [I, I | Res]) :-
        double_item(Tail, Res).

t_40(Ds) :-
        double_item([a, b, c], Ds).

t_41 :-
        double_item([a, b, b, c], [a, a, b, b, b, b, c, c]).


%% ===== appendi ===== %%
appendi([], Xs, Xs).
appendi([X | Xs], Ys, [X | Zs]) :- 
        appendi(Xs, Ys, Zs).

t_50(X) :- 
        appendi([1, 2], [[3, 4], 5], X).

t_51(X) :- 
        appendi([vediamo, se, la], [[becco]], X).

t_52([X | Xs]) :- 
        appendi([vediamo], [X | Xs], [vediamo, [se, la, becco]]).

t_53(X, Y) :- 
        appendi(X, Y, [1, 2, 3]).


%% ===== double_even ===== %%
double_even([], []).

double_even([F | Tail], [D | Sol]) :-
        double_even(Tail, Sol),
        0 is F mod 2, D is 2 * F.

double_even([F | Tail], [F | Sol]) :-
        double_even(Tail, Sol),
        not(0 is F mod 2).

t_60(R) :-
        double_even([2, 6, 7, 8, 7, 7, 3], R).


%% ===== sostituisci ===== %%
sostituisci(_, _, [], []).

sostituisci(X, Y, [X | T], [Y | Out]) :-
        sostituisci(X, Y, T, Out).

sostituisci(X, Y, [H | T], [H | Out]) :-
        sostituisci(X, Y, T, Out).

t_70(R) :-
        sostituisci(7, ciao, [2, 6, 7, 8, 7, 7, 3], R).