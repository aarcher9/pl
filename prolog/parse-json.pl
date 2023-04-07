%%%% -*- Mode: Prolog -*-

push(I, CURRENT_S, UPDATED_S) :- append([I], CURRENT_S, UPDATED_S), !.
pop([_ | TAIL], UPDATED_S) :- UPDATED_S = TAIL, !.

initial(i).
final(f).
final(c).


% Descrizione logica dei fatti 'arc'.
% La regola append() aggiunge in testa; controintuitivamente la testa (top) dello stack sta a sinistra.
% Forse è necessario fare controlli sullo stack attuale per vedere cosa ci sia in testa (per capire se effettivamente mi trovo sul nodo dell'automa corretto), ma tecnicamente se le definizioni stesse degli archi sono giuste non dovrebbe servire, perchè verrei già indirzzato correttamente.

% arc(nodo, carattere in input, stack attuale, nodo di arrivo, stack aggornato)


% Parentesi GRAFFE
arc(i, '{', CURR, a, UPDATED) :- push('{', CURR, UPDATED).
arc(a, '[', CURR, b, UPDATED) :- push('[', CURR, UPDATED).
arc(a, '{', CURR, a, UPDATED) :- push('{', CURR, UPDATED).

% Caso: pop()
arc(a, '}', CURR, c, UPDATED) :- pop(CURR, UPDATED).


% Parentesi QUADRE
arc(i, '[', CURR, b, UPDATED) :- push('[', CURR, UPDATED).
arc(b, '{', CURR, a, UPDATED) :- push('{', CURR, UPDATED).
arc(b, '[', CURR, b, UPDATED) :- push('[', CURR, UPDATED).

% Caso: pop()
arc(b, ']', CURR, c, UPDATED) :- pop(CURR, UPDATED). 


% Se qui volessi fare controlli (di cui al commento sopra) al posto del primo _ dovrei usare una variabile, come sopra, ad esempio CURR.
arc(c, '{', _, a, _). 
arc(c, '[', _, b, _). 
arc(c, '', [], f, []).



% Le regole sono ordinate in senso logico; la funzione principale chiama accept/2, se nullo esegue il fatto qui sotto. Se non nullo esegue il caso accept/2 non generico. Se va tutto bene questo chiama accept/3 e alla fine sempre se va tutto bene chiama accept/3 caso finale.

% CASO INIZIALE NULLO
% Se l'input risulta vuoto, lo stack anche è come se fossi sul nodo iniziale, quindi va tutto bene.
accept([], []).

% CASO INIZIALE GENERICO
% "Overloading" di convenienza per la regola 'accept' in modo da nascondere più dettagli possibile all'esterno di questa zona.
accept(LIST, []) :- 
    initial(NODE), !, 
    accept(NODE, LIST, []).

% Regola di accettazione generica.
accept(NODE, [I | INPUT_REST], STACK) :-
    arc(NODE, I, STACK, END_NODE, UPDATED_STACK), !,
    accept(END_NODE, INPUT_REST, UPDATED_STACK).

% CASO FINALE
% Se l'input risulta vuoto e lo stack anche, sono arrivato alla fine con successo se solo se il nodo su cui mi trovo è quello finale (se nulla è andato storto dovrebbe essere proprio così).
accept(NODE, [], []) :- final(NODE).

% ===== MAIN ===== %
brackets_match(STRING) :- atom_chars(STRING, INPUT), accept(INPUT, []).