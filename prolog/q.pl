%%%% -*- Mode: Prolog -*-
%% === Questo file prolog non è eseguibile === %%



% FINDALL ==========
% "Trovami tutti gli X tali che cat(X) e mettimeli in Result"


% Questo riempie Result come previsto.
findall(X, cat(X), Cats).


% Questo ritorna lista "libera" ovviamente.
findall(Y, cat(X), Free).


% Esempio più complesso; a seconda di cosa imposto come template ottengo genitori o figli.
findall(X, child(X, Y), Res). % Figli
findall(Y, child(X, Y), Res). % Genitori



% BAGOF ==========
% "Simile a FINDALL"


% I risultati sono forniti premendo ; | n | r | space | TAB.
?- bagof(Y, child(X, Y), Res).

% Gli stessi risultati ma è come se stessi usando FINDALL, perchè non usa il backtracking (sostituisce in automatico direttamente).
?- bagof(Y, X^child(X, Y), Res).


% '^' locka la variabile Y in Goal solo se non appare in Template. In questo caso Y è presente in entrambi quindi Y^Goal è inutile. Fa quindi lo stesso di sopra.
?- bagof(Y, Y^child(X, Y), Res).



% CALL ==========

% Chiama semplicemente (tipo eval() per javascript).
call(cat(X)).



% READ / WRITE ==========

% Come lo 
read(What), write('I just read: '), write(What).
% |: miao.
% I just read: miao.
% What = miao.



% OPEN / CLOSE ==========
% Sono abbastanza autoesplicativi.


open(’here.txt’, write, Out),
write(Out, foo(bar)), put(Out, 0’.), nl(Out),
close(Out).


open(’here.txt’, read, In),
read(In, What) ,
close(In).



% RULE ==========

% Verifica una regola?
% "true se nel DB ho meows(boot)."
rule(meows(X), meows(boot)).



