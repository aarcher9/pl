%%%% -*- Mode: Prolog -*-
%%%% 826296 Agosti Andrea
%%%% <>

%% --- Supporto
randnum(Lim, Num) :- Up is Lim - 1, random(0, Up, Num).

randlist(1, Lim, [Num]) :- randnum(Lim, Num).
randlist(N, Lim, [H | T]) :- 
        randnum(Lim, H),
        NN is N - 1,
        randlist(NN, Lim, T).

randlist_clear(N, Lim, L, S) :-
        (list_to_set(L, L), S = L) ; 
        (randlist(N, Lim, NL), randlist_clear(N, Lim, NL, S)).

randset(N, Lim, Rs) :- randlist(N, Lim, Init), randlist_clear(N, Lim, Init, Rs).


%% --- Operazioni fra vettori
%% *
scalarprod(_, [], []).
scalarprod(L, [X | Tx], [H | T]) :- H is L * X, scalarprod(L, Tx, T).

%% *
vplus([], [], []).
vplus([X | Tx], [Y | Ty], [H | T]) :- H is X + Y, vplus(Tx, Ty, T).

%% *
vminus(X, Y, R) :- scalarprod(-1, Y, IY), vplus(X, IY, R).

%% *
innerprod([], [], 0).
innerprod([X | Tx], [Y | Ty], R) :- innerprod(Tx, Ty, Out), R is (X * Y + Out).

%% *
norm(X, R) :- innerprod(X, X, Out), R is Out ** 0.5.

distance(X, Y, R) :- vminus(X, Y, Out), norm(Out, R).

vsum([X], X).
vsum([X | T], R) :- vsum(T, Out), vplus(X, Out, R).  

vmean(VL, R) :- length(VL, L), Q is 1 / L, vsum(VL, Sum), scalarprod(Q, Sum, R).


%% --- Algoritmo k-means

