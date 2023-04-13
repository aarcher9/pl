%%%% -*- Mode: Prolog -*-

% # R1:
% Se uso _ per una variabile poi non riesco a stampare il valore delle variabili che compaiono insieme ad essa (ottengo il nome della variabile e.g.: _03113, invece che il suo valore). Meglio usare una variabile con nome inizializzata (ripeto, inizializzata). Se non lo sarà produrrà un effetto identico.


% ========== ========== ========== ========== ========== %

pushl(Item, L, NL) :- append(L, [Item], NL), !.
push(ITEM, CURRENT_S, UPDATED_S) :- append([ITEM], CURRENT_S, UPDATED_S), !.
pop([_ | TAIL], TAIL).

len([], 0).
len([_ | T], Length) :- len(T, L), Length is L + 1.


% @@@ %

% sink_in(Sym, 0, L, NL) :- pushl(Sym, L, NL), !.
% sink_in(Sym, Depth, L, NL) :- 
%     D is Depth - 1, 
%     sink_in(Sym, D, L, P), !, 
%     NL = P, !.

% pushld(Sym, [L], NL) :- pushl(Sym, L, NL), !.
% pushld(Sym, [H | T], NL) :- 
%     (pushld(Sym, T, Last) ; pushld(Sym, H, Last)), !, 
%     push(H, Last, NL).

pushld(Sym, [H | T], UL) :- 
    ( pushld(Sym, T, UL) ; 
        ( pushld(Sym, H, UL) ; 0 = 0 ),
        ( pushl(Sym, H, UL), ! ; 0 = 0 ) 
    ), !,
    write(T), nl.

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


% ===== MAIN ===== %

json_parse(STRING) :- 
    atom_chars(STRING, LIST),
    accept(LIST, [], [], JSON), !,
    write(JSON).

sr :- reconsult('parse-json.pl').