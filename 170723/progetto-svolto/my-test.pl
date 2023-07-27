:- include('km.pl').
:- set_prolog_flag(answer_write_options,[max_depth(0)]).

ri :- reconsult('my-test.pl').

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


%% --- Algoritmo k-means
test_kmeans(Klus) :-
        obs(Obs),
        kmeans(Obs, 3, Klus), !. 