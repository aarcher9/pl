%%%% -*- Mode: Prolog -*-

initial(i).
final(f).

% Descrizione logica dei fatti 'arc'
% arc(nodo, carattere in input, stack attuale, nodo di arrivo, stack aggornato)
arc(i, "{", [], a, STACK) :- append(["{"], [], STACK),
arc(a, "[", "{", b, "[").
arc(a, "{", "{", a, "{").
arc(a, "}", "{", c, ""). % Caso: pop()


arc(i, "[", "", b, "[").
arc(b, "{", "[", a, "{").
arc(b, "[", "[", b, "[").
arc(b, "]", "[", c, ""). % Caso: pop()


arc(c, "", "{", a, ""). % Caso: lascio invariato lo stack
arc(c, "", "[", b, ""). % Caso: lascio invariato lo stack
arc(c, "", "", f, ""). % Caso: lo stack è vuoto e lo lascio tale



% CASO INIZIALE NULLO
% Se l'input risulta vuoto, lo stack anche è come se fossi sul nodo iniziale, quindi va tutto bene.
accept([], []).

% CASO INIZIALE
% "Overloading" di convenienza per la regola 'accept' in modo da nascondere più dettagli possibile all'esterno di questa zona.
accept(LIST, []) :- 
    initial(NODE), !, 
    accept(NODE, LIST, []).

% CASO FINALE
% Se l'input risulta vuoto e lo stack anche, sono arrivato alla fine con successo IFF il noto su cui mi trovo è quello finale.
accept(NODE, [], []) :- final(NODE).


% Regola di accettazione generica.
% TODO: bisogna considerare il pop dallo stack
accept(NODE, [I | INPUT_REST], STACK) :-
    arc(NODE, I, STACK, END_NODE, UPDATED_STACK), !,
    accept(END_NODE, INPUT_REST, UPDATED_STACK).



% ===== MAIN ===== %
brackets_match(STRING) :- atom_chars(STRING, INPUT), accept(INPUT, []).