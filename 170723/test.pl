:- include('km.pl').
:- set_prolog_flag(answer_write_options,[max_depth(0)]).

ri :- reconsult('test.pl').

%% --- Parametri per il testing
obs([   [3.0, 7.0], [0.5, 1.0], [0.8, 0.5], 
        [1.0, 8.0], [1.8, 1.2], [6.0, 4.0], 
        [7.0, 5.5], [4.0, 9.0], [9.0, 4.0]]).

real_tcs_k3([[2.6666666666666665,8], [7.333333333333333, 0.9], [7.333333333333333, 4.5]]).

tcs_k3([[2.666, 8], [1.033, 0.9], [7.333, 4.5]]).

exp_clus_k3([   
        [3.0, 7.0], [1.0, 8.0], [4.0, 9.0],
        [0.5, 1.0], [0.8, 0.5], [1.8, 1.2],
        [6.0, 4.0], [7.0, 5.5], [9.0, 4.0]]).


%% --- Supporto

%% --- Vettori
test_vectors_op :-
        innerprod([1, 2], [2, 3], 8),
        scalarprod(10, [1, 2], [10, 20]),
        vplus([1, 2], [2, 3], [3, 5]),
        vminus([1, 2], [2, 3], [-1, -1]),
        distance([-2, -3], [-1, -2], 1.4142135623730951),
        vsum([[1, 1], [2, 3], [1, 2]], [4, 6]),
        vmean([[1, 2], [3, 4]], [2.0, 3.0]),
        norm([3, 4], 5.0).

%% --- Algoritmo k-means
test_partition(Clss) :- 
        obs(Os), real_tcs_k3(Cs), partition(Os, Cs, Clss).

test_initialize(Cs) :-
        obs(Obs), 
        randset(3, 9, Rs),
        initialize(Obs, Rs, Cs).

test_kmeansdbg :-
        obs(Obs),
        kmeansdbg(Obs, 0, _), !. 