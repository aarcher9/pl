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

rlc(N, Lim, L, S) :-
        (list_to_set(L, L), S = L) ; (randlist(N, Lim, NL), rlc(N, Lim, NL, S)).

randset(N, Lim, Rs) :- randlist(N, Lim, Init), rlc(N, Lim, Init, Rs).

%% --- Operazioni fra vettori

%% --- Algoritmo k-means

