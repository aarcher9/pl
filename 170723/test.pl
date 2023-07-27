:- include('km.pl').
:- set_prolog_flag(answer_write_options,[max_depth(0)]).

ri :- reconsult('test.pl').

%%% --- Parametri per il testing
obs([   [3.0, 7.0], [0.5, 1.0], [0.8, 0.5], 
        [1.0, 8.0], [1.8, 1.2], [6.0, 4.0], 
        [7.0, 5.5], [4.0, 9.0], [9.0, 4.0]]).

real_tcs_k3([[2.6666666666666665,8], [7.333333333333333, 0.9], [7.333333333333333, 4.5]]).

tcs_k3([[2.666, 8], [1.033, 0.9], [7.333, 4.5]]).

exp_clus_k3([   
        [3.0, 7.0], [1.0, 8.0], [4.0, 9.0],
        [0.5, 1.0], [0.8, 0.5], [1.8, 1.2],
        [6.0, 4.0], [7.0, 5.5], [9.0, 4.0]]).


%%% --- Supporto

%%% --- Vettori
test_vectors :-
        scalarprod(10, [1, 2], [10, 20]),
        scalarprod(10, [], _),

        vplus([1, 2], [2, 3], [3, 5]),
        \+ vplus([1], [2, 3], _),
        \+ vplus([2, 3], [1], _),
        vplus([], [], []),

        vminus([1, 2], [2, 3], [-1, -1]),

        innerprod([1, 2], [2, 3], 8),
        \+ innerprod([1], [2, 3], _),
        \+ innerprod([2, 3], [1], _),
        innerprod([], [], 0),

        norm([3, 4], 5.0),
        norm([0], 0),
        norm([], 0),

        distance([-2, -3], [-1, -2], 1.4142135623730951),
        vsum([[1, 1], [2, 3], [1, 2]], [4, 6]),
        vmean([[1, 2], [3, 4]], [2.0, 3.0]).

%%% --- Algoritmo k-means
%%% Casi normali, input corretto
test_base :-
        obs(Obs),
        kmeansdbg(Obs, 3, _), !, 
        kmeansdbg(Obs, 8, _), !, 
        kmeansdbg(Obs, 5, _), !, 
        kmeansdbg(Obs, 1, _), !. 