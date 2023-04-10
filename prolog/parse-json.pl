%%%% -*- Mode: Prolog -*-

push(ITEM, CURRENT_S, UPDATED_S) :- append([ITEM], CURRENT_S, UPDATED_S), !.
pop([_ | TAIL], UPDATED_S) :- UPDATED_S = TAIL, !.

initial(i).
final(f).


% Descrizione logica dei fatti 'arc'.
%  ==> arc(nodo, carattere in input, stack attuale, nodo di arrivo, stack aggiornato)
% BS = brackets stack
% UBS = updated brackets stack
% La regola append() aggiunge in testa; controintuitivamente la testa (top) dello stack sta a sinistra.
% Forse è necessario fare controlli sullo stack attuale per vedere cosa ci sia in testa (per capire se effettivamente mi trovo sul nodo dell'automa corretto), ma tecnicamente se le definizioni stesse degli archi sono giuste non dovrebbe servire, perchè verrei già indirzzato correttamente.

/* DA AGGIORNARE
% Accettazione dei caratteri liberi.
% Non ho bisogno di "poppare" perchè quando 'accept' chiama 'arc' uso la notazione delle liste [Testa | Coda].
arc(N, ' ', BS, N, BS).
arc(N, '\n', BS, N, BS).
arc(N, '\t', BS, N, BS).
arc(N, '\r', BS, N, BS).

% Parentesi GRAFFE
arc(i, '{', BS, c, UBS) :- push('{', BS, UBS).
arc(c, '{', BS, c, UBS) :- push('{', BS, UBS).
arc(c, '}', BS, c, UBS) :- pop(BS, UBS).
arc(c, [], [], f, []).

% Archi di passaggio
arc(c, '[', BS, s, UBS) :- push('[', BS, UBS).
arc(s, '{', BS, c, UBS) :- push('{', BS, UBS).
arc(s, '}', ['{' | TAIL], c, TAIL).
arc(c, ']', ['[' | TAIL], s, TAIL).
*/

% Parentesi QUADRE
arc(i, '[', BS, s, UBS, _, _) :- push('[', BS, UBS).
arc(s, '[', BS, s, UBS, J, UJ) :- push('[', BS, UBS), push('ciao', J, UJ).
arc(s, ']', BS, s, UBS, _, _) :- pop(BS, UBS).
arc(s, [], [], f, [], _, _).



% Le regole sono ordinate in senso di chiamata.

% CASO INIZIALE NULLO
% Se l'input risulta vuoto, lo stack anche è come se fossi sul nodo iniziale, quindi va tutto bene.
accept([], []).


% CASO INIZIALE GENERICO
% "Overloading" di convenienza per la regola 'accept' in modo da nascondere più dettagli possibile all'esterno di questa zona.
accept(LIST, []) :- 
    initial(NODE), !, 
    accept(NODE, LIST, [], []).


% CASO DI CONTROLLO FINALE
accept(NODE, [], [], JSON) :- 
    arc(NODE, [], [], END_NODE, [], JSON, UPDATED_JSON), !,
    final(END_NODE).


% Regola di accettazione generica.
accept(NODE, [CI | INPUT_REST], STACK, JSON) :-
    arc(NODE, CI, STACK, END_NODE, UPDATED_STACK, JSON, UPDATED_JSON), !,
    write(UPDATED_JSON),
    accept(END_NODE, INPUT_REST, UPDATED_STACK, UPDATED_JSON).


% ===== MAIN ===== %

% Esempi
% ACCETTA: {[][][{}{{[]}}]}{}[]
% ACCETTA: {[] [] [{} {{[    ]}}]} {} []


brackets_match(STRING) :- 
    atom_chars(STRING, LIST),
    accept(LIST, []).
