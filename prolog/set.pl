%%%% -*- Mode: Prolog -*-


% Il primo è figlio del secondo
child(mattia, roman).
child(mattia, gian).
child(marco, ada).
child(gigi, marco).
child(gigi, mina).
child(mario, mina).

% Scelgo X, trovo Y, cambio X, ritrovo tutti gli altri Y,... 
freeAll(X, Y, Res) :- bagof(Y, child(X, Y), Res).

% X non conta per il backtracking, quindi ritormno tutti i valori di Y che appaiono nella relazione
lockX(X, Y, Res) :- bagof(Y, X^child(X, Y), Res).

% 
lockY(X, Y, Res) :- bagof(Y, Y^child(X, Y), Res).