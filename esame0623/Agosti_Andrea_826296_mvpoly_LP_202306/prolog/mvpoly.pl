%%%% -*- Mode: Prolog -*-
%%%% 826296 Agosti Andrea
%%%% <>


% In caso di bisogno:
% C-x h C-M-\ usare il comando per reindentare tutto il file con Emacs.


% == [ Utilities ] == %
% Shortcut per ricaricare il file con la console SWI aperta.
rel :- notrace, nodebug, reconsult('mvpoly.pl').

% Procedura (predicato) di append leggermente modificata per catchare autonomamente le eccezioni. Appende ad una lista una seconda lista o una stringa, o anche atomo.
push(Element, List, New) :- append([Element], List, New).
push([H | T], List, New) :- append([H | T], List, New).

% Rimuove i '' (stringhe vuote) dalla lista.
clean_push('', L, L).
clean_push(Item, List, Out) :- push(Item, List, Out).

% == == %



% == [ Parsing monomi ] == %
% Si suppone che arrivi un carattere alla volta.
is_digit(Char) :- atom_codes(Char, [H | _]), H >= 48, H =< 57.
is_var_symbol(Char) :- atom_codes(Char, [H | _]), H >= 97, H =< 122.


% Fa il reverse di una lista nestata al massimo di un livello di profondità.
mirror_monomial_stack([], []).
mirror_monomial_stack([H | T], Mirrored) :- 
        mirror_monomial_stack(T, M),
        reverse(H, Temp),
        append(M, [Temp], Mirrored).


% Funzionde delta del PDA che riconosce un monomio.
initial('a').
final('c').
final('d').

% La logica è quella di creare una funzione delta che oltre a comportarsi come una delta 'ordinaria' per il PDA opera anche la traduzione in "oggetto" del monomio. L'automata ha infatti due stack (4 passati come argomento per via della struttura di prolog che non prevede modifiche dirette di oggetti come le liste), uno per conservare i token (le parti del monomio inscindibili) e l'altro per "scaricarli" e conservare l'oggetto finale.

% ===
delta('a', '+', 'c', [], [], [], []).
delta('a', '-', 'b', [], [], [], NT) :- 
        push('-', [], NT).

delta('a', D, 'c', [], [], [], NT) :- 
        is_digit(D), 
        push(D, [], NT).

% ===
delta('b', D, 'c', [], [], ['-'], NT) :- 
        is_digit(D), 
        push(D, ['-'], NT).

% ===
delta('c', D, 'c', [], [], [H | Tail], NT) :- 
        is_digit(D),
        is_digit(H),
        push(D, [H | Tail], NT).

% Scarico del token stack.
delta('c', V, 'd', S, NS, [H | Tail], NT) :- 
        is_var_symbol(V),
        is_digit(H),
        push(V, [], NT),
        push([H | Tail], S, NS).

% ===
% Scarico del token stack.
delta('d', V, 'd', S, NS, [H | Tail], NT) :- 
        is_var_symbol(V),
        is_var_symbol(H),
        push(V, [], NT),
        push([H | Tail], S, NS).

delta('d', '^', 'e', S, S, [H | Tail], [H | Tail]) :- 
        is_var_symbol(H).

% ===
delta('e', D, 'c', S, S, [H | Tail], NT) :-
        is_digit(D),
        push(D, [H | Tail], NT).


% Parser dei monomi.
% Caso generico.
pda(State, [X | Postfix], S, OS, T, OT) :-
        delta(State, X, NewState, S, NS, T, NT),
        pda(NewState, Postfix, NS, OS, NT, OT).

% Caso finale.
pda(State, [], S, NS, [H | T], [H | T]) :- 
        final(State),
        push([H | T], S, NS).

% Predicato high-level per il parsing dei monomi.
as_monomial(Expression, Monomial) :-
        atom_chars(Expression, L),
        pda('a', L, [], MM, [], _),
        mirror_monomial_stack(MM, Monomial).


% == == %

test_as_monomial(ML) :- as_monomial('-3xy^3z', ML).
% test_as_monomial(ML) :- as_monomial('-3xy^3z', ML).
% test_as_monomial(ML) :- as_monomial('-3xy^3z', ML).
% test_as_monomial(ML) :- as_monomial('-36k^67', ML).