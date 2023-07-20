:- include('km.pl').

%% --- Parametri per il testing
obs([   [3.0, 7.0], [0.5, 1.0], [0.8, 0.5], 
        [1.0, 8.0], [1.8, 1.2], [6.0, 4.0], 
        [7.0, 5.5], [4.0, 9.0], [9.0, 4.0]]).

real_tcs_k3([[2.6666667, 8], [1.0333333, 0.9], [7.3333335, 4.5]]).

tcs_k3([[2.666, 8], [1.033, 0.9], [7.333, 4.5]]).

exp_clus_k3 ([   
        [3.0, 7.0], [1.0, 8.0], [4.0, 9.0]
        [0.5, 1.0], [0.8, 0.5], [1.8, 1.2]
        [6.0, 4.0], [7.0, 5.5], [9.0, 4.0]]).


%% --- Supporto

%% --- Vettori

%% --- Algoritmo k-means