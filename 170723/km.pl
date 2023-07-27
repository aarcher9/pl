%%%% -*- Mode: Prolog -*-
%%%% 826296 Agosti Andrea
%%%% <>

%%% --- Gestione errori & casi limite


%%% --- Supporto
%%% L'intervallo generato di interi è [0, Up]
randnum(Max, Num) :- Up is (Max - 1), random(0, Up, Num).

randlist(1, Max, [Num]) :- randnum(Max, Num).
randlist(N, Max, [H | T]) :- 
        randnum(Max, H),
        NN is N - 1,
        randlist(NN, Max, T).

randlist_clear(N, Max, L, S) :-
        (list_to_set(L, L), S = L) ; 
        (randlist(N, Max, NL), randlist_clear(N, Max, NL, S)).

%%% Quando N == Max, va in loop infinito, devo gestire correttamente il caso
randset(N, N, R) :- N1 is N + 1, randset(N, N1, R).
randset(N, Max, Rs) :- randlist(N, Max, Init), randlist_clear(N, Max, Init, Rs).


%%% --- Operazioni fra vettori
%%% *
%%% Ne inserisco uno di esempio per evitare di ricevere errori se volessi interrogare la base di dati prima di aver chiamato new_vector/2
vector(v0, [0, 0, 0]).

%%% *
new_vector(Name, Value) :- assert(vector(Name, Value)).

%%% *
scalarprod(_, [], []).
scalarprod(L, [X | Tx], [H | T]) :- H is L * X, scalarprod(L, Tx, T).

%%% *
vplus([], [], []).
vplus([X | Tx], [Y | Ty], [H | T]) :- H is X + Y, vplus(Tx, Ty, T).

%%% *
vminus(X, Y, R) :- scalarprod(-1, Y, Ny), vplus(X, Ny, R).

%%% *
innerprod([], [], 0).
innerprod([X | Tx], [Y | Ty], R) :- innerprod(Tx, Ty, Out), R is (X * Y + Out).

%%% *
norm(X, R) :- innerprod(X, X, Out), R is Out ** 0.5.

distance(X, Y, R) :- vminus(X, Y, Out), norm(Out, R).

vsum([X], X).
vsum([X | T], R) :- vsum(T, Out), vplus(X, Out, R).  

vmean(VS, R) :- length(VS, L), Q is 1 / L, vsum(VS, Sum), scalarprod(Q, Sum, R).


%%% --- Algoritmo k-means
nearest(_, [], Curr, Curr).
nearest(O, [C | Cs], Curr, Min) :- 
        distance(C, O, D1), distance(Curr, O, D2),
        (D1 < D2, nearest(O, Cs, C, Min)) ; nearest(O, Cs, Curr, Min).

assign(_, [], _).
assign(O, [C | Cs], Min) :- nearest(O, [C | Cs], C, Min).

%%% Accoppia ciascuna osservazione con il suo centroide più vicino
assignall([], _, []).
assignall([O | Os], Cs, [[O, Min] | T]) :- 
        assign(O, Cs, Min), 
        assignall(Os, Cs, T).

group([], _, []).
group([[O, C] | Ass], C, [O | T]) :- group(Ass, C, T).
group([[_, _] | Ass], C, T) :- group(Ass, C, T).

groupall(_, [], []).
groupall(Ass, [C | Cs], [G | Gs]) :- group(Ass, C, G), groupall(Ass, Cs, Gs).

%%% Crea length(<lista di centroidi>, K) K clusters attorno ai centroidi sulle osservazioni
partition(Obs, [C | Cs], Klus) :- 
        assignall(Obs, [C | Cs], Ass),
        groupall(Ass, [C | Cs], Klus).

%%% *
centroid(Observations, C) :- vmean(Observations, C).

centroids([], []).
centroids([K | Klus], [C | T]) :- centroid(K, C), centroids(Klus, T).

%%% Il core del programma, ricomputa clusters e ricalcola i centroidi fino a che la condizione di terminazione non sia raggiunta
repart(_, Cs, Klus, [Cs, Klus]) :- centroids(Klus, Cs).
repart(Obs, _, Klus, R) :- 
        centroids(Klus, NCs),
        partition(Obs, NCs, NKlus),
        repart(Obs, NCs, NKlus, R).

lloydkmeans(Obs, Cs, R) :- partition(Obs, Cs, Klus), repart(Obs, Cs, Klus, R).

%%% Estrae i k centroidi dalle osservazioni pseudo-casualmente
initialize(_, [], []).
initialize(Obs, [Rn | Rs], [C | Cs]) :- 
        nth0(Rn, Obs, C),
        initialize(Obs, Rs, Cs).

%%% *
kmeans(Observations, K, [Cs, Klus]) :-
        length(Observations, MaxRand),
        randset(K, MaxRand, Rs),
        initialize(Observations, Rs, ICs),
        lloydkmeans(Observations, ICs, [Cs, Klus]).

kmeansdbg(Obs, Kn, [Cs, Klus]) :-
        kmeans(Obs, Kn, [Cs, Klus]),
        nl, write('Centroids:'), nl,
        maplist(writeln, Cs), nl,
        write('Clusters:'), nl,
        maplist(writeln, Klus).