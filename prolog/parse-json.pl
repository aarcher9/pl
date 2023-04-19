%%%% -*- Mode: Prolog -*-

% # R1:
% Se uso _ per una variabile poi non riesco a stampare il valore delle variabili che compaiono insieme ad essa (ottengo il nome della variabile e.g.: _03113, invece che il suo valore). Meglio usare una variabile con nome inizializzata (ripeto, inizializzata). Se non lo sarà produrrà un effetto identico.


% ========== ========== ========== ========== ========== %

pushl(Item, L, NL) :- append(L, [Item], NL), !.
push(Item, L, NL) :- append([Item], L, NL), !.
pop([_ | T], T).

len([], 0).
len([_ | T], Length) :- len(T, L), Length is L + 1.


% @@@ %
% il simbolo ; 'OR' è lazy, se la prima parte risulta vera la seconda non viene eseguita
% per il simbolo ,'AND' se la prima parte risulta falsa la seconda non viene eseguita


findld(Sym, [H | T], Found, Substitute) :- 
    ( findld(Sym, T, Found, Substitute); ( 
        ( findld(Sym, H, Found, Substitute)); ( 
                pushl(Sym, H, Substitute), !, Found = H
            )
        ), !
    ), !.


unpack([], Old, Old).
unpack([H | T], Old, N) :- 
    ( unpack(H, Old, New); ( pushl(H, Old, New); true ) ),
    ( unpack(T, New, N) ), !.


duplicate([H | T], Result) :- 
    ( duplicate(H, Result); true ),
    ( duplicate(T, Result); true ), 
    push(H, T, Result).


% Left Right Node
lrn([H | T]) :- 
    ( lrn(H); ( write(H), nl ) ),
    ( lrn(T); ( write(T), nl, false ) ).

visit_lrn([H | T]) :- lrn([H | T]); true.


% replace method for lists without nesting. Works pretty well
simple_replace([], _, _, Temp, Temp).
simple_replace([H | T], This, WithThis, Temp, After) :-
    ( 
        ( 
            ( H == This, pushl(WithThis, Temp, B) );
            ( H \= This, pushl(H, Temp, B) )
        ), 
        ( simple_replace(T, This, WithThis, B, After) )
    ), !.


replace([], _, _, []).
replace(H, H, WithThis, WithThis) :- atom(H), !.
replace(H, _, _, H) :- atom(H), !.

replace([H | T], This, WithThis, Sol) :-
    (
        [H | T] == This,
        Sol = WithThis
    );
    (
        replace(H, This, WithThis, SH),
        replace(T, This, WithThis, ST),
        push(SH, ST, Sol)
    ), !.


% @@@ %


% ========== ========== ========== ========== ========== %

% Descrizione logica dei fatti 'arc'.
% (nodo, carattere in input, stack attuale, nodo di arrivo, stack aggiornato, json, json aggiornato)
% BS = brackets stack
% UBS = updated brackets stack
% La regola append() aggiunge in testa; controintuitivamente la testa (top) dello stack sta a sinistra.

initial(i).
final(f).

% Accettazione dei caratteri liberi.
arc(Node, ' ', BS, Node, BS, JSON, JSON).
arc(Node, '\n', BS, Node, BS, JSON, JSON).
arc(Node, '\t', BS, Node, BS, JSON, JSON).
arc(Node, '\r', BS, Node, BS, JSON, JSON).


% Parentesi QUADRE
arc(i, '[', BS, s, UBS, JSON, JSON) :- push('[', BS, UBS).

arc(s, '[', BS, s, UBS, J, J) :- 
    push('[', BS, UBS).

arc(s, ']', BS, s, UBS, JSON, JSON) :- pop(BS, UBS).
arc(s, [], [], f, [], JSON, JSON).

% Stringhe
% arc(s, '"', BS, k0, BS, V, PV)


% ========== ========== ========== ========== ========== %
% Le regole sono ordinate nel possibile senso di chiamata.

% CASO INIZIALE NULLO
% Se l'input risulta vuoto e lo stack anche è come se fossi sul nodo iniziale, quindi va tutto bene.
accept([], []).


% CASO INIZIALE GENERICO
% "Overloading" di convenienza per la regola 'accept' in modo da nascondere più dettagli possibile all'esterno di questa zona.
accept(LIST, [], T, JSON) :- 
    initial(NODE), !, 
    accept(NODE, LIST, [], T, JSON).


% Regola di accettazione.
accept(NODE, [CI | INPUT_REST], STACK, T, JSON) :-
    arc(NODE, CI, STACK, END_NODE, UPDATED_STACK, T, NT), !,
    accept(END_NODE, INPUT_REST, UPDATED_STACK, NT, JSON).


% CASO DI CONTROLLO FINALE
accept(NODE, [], [], T, JSON) :- 
    arc(NODE, [], [], END_NODE, [], T, JSON), !,
    final(END_NODE).


% ===== JSON Parse ===== %

json_parse(STRING) :- 
    atom_chars(STRING, LIST),
    accept(LIST, [], [], JSON), !,
    write(JSON).

% ===== Run ===== %

sr :- reconsult('parse-json.pl').
sep :- nl, write('===== + ====='), nl.
app :- 
    visitlnr([a, b, [d], [l, j]], Result), sep, write(Result).
    % replaceld([[a, [d], [l, j]]], Result),
    % sep, write(Result).
% app :- findld('#', [[a, [d], [l, j]]], Found, Substitute), sep, write(Found), nl, write(Substitute).


run :- sr, app.
runtrace :- sr, trace, app, notrace, nodebug.
