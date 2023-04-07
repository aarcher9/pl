%%%% -*- Mode: Prolog -*-

push(I, CURRENT_S, UPDATED_S) :- append([I], CURRENT_S, UPDATED_S), !.
pop([_ | TAIL], UPDATED_S) :- UPDATED_S = TAIL, !.

initial(i).
final(f).


% Descrizione logica dei fatti 'arc'.
%  ==> arc(nodo, carattere in input, stack attuale, nodo di arrivo, stack aggiornato)
% La regola append() aggiunge in testa; controintuitivamente la testa (top) dello stack sta a sinistra.
% Forse è necessario fare controlli sullo stack attuale per vedere cosa ci sia in testa (per capire se effettivamente mi trovo sul nodo dell'automa corretto), ma tecnicamente se le definizioni stesse degli archi sono giuste non dovrebbe servire, perchè verrei già indirzzato correttamente.


% Parentesi GRAFFE
arc(i, '{', CURR, a, UPDATED) :- push('{', CURR, UPDATED).
arc(a, '{', CURR, a, UPDATED) :- push('{', CURR, UPDATED).
arc(a, '}', CURR, c, UPDATED) :- pop(CURR, UPDATED).
arc(a, '}', ['{'], c, _).
% arc(c, _, [H | _], a, _) :- H == '{'.
% arc(a, [], [], c, []).
arc(c, [], [], f, []).


% Parentesi QUADRE
% arc(i, '[', CURR, b, UPDATED) :- push('[', CURR, UPDATED).
% arc(b, '{', CURR, a, UPDATED) :- push('{', CURR, UPDATED).
% arc(b, '[', CURR, b, UPDATED) :- push('[', CURR, UPDATED).
% arc(b, ']', CURR, c, UPDATED) :- pop(CURR, UPDATED).
% arc(b, [], [], c, []).
% arc(c, _, [HEAD | _], b, _) :- HEAD == '['.


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

% ===== MAIN ===== %
brackets_match(STRING) :- atom_chars(STRING, INPUT), accept(INPUT, []).