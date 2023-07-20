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

randset()

%% --- Operazioni fra vettori

%% --- Algoritmo k-means

