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


% Funzionde delta del PDA che riconosce un monomio.
initial('a').
final('c').
final('d').

delta('a', '+', 'b', [], []).
delta('a', '-', 'b', [], NS) :- push('-', [], NS).

delta('a', D, 'c', [], NS) :- is_digit(D), push(D, [], NS).

delta('b', D, 'c', [], NS) :- is_digit(D), push(D, [], NS).
delta('b', D, 'c', ['-'], NS) :- is_digit(D), push(D, ['-'], NS).

delta('c', D, 'c', [H | Tail], NS) :- 
        is_digit(D),
        is_digit(H),
        push(D, [H | Tail], NS).

delta('c', V, 'd', [H | Tail], NS) :- 
        is_var_symbol(V),
        is_digit(H),
        push(V, [H | Tail], NS).

delta('d', V, 'd', [H | Tail], NS) :- 
        is_var_symbol(V),
        is_var_symbol(H),
        push(V, [H | Tail], NS).

delta('d', '^', 'e', [H | Tail], NS) :- 
        is_var_symbol(H),
        push('^', [H | Tail], NS).

delta('e', D, 'c', [H | Tail], NS) :-
        is_digit(D),
        H == '^',
        push(D, [H | Tail], NS).


% Parser dei monomi.
% Caso generico.
pda(State, [X | Postfix], S, Out) :-
        delta(State, X, NewState, S, NS),
        pda(NewState, Postfix, NS, Out).

% Caso finale.
pda(State, [], [H | T], [H | T]) :- 
        final(State),
        (is_var_symbol(H) ; is_digit(H)).

% Predicato high-level per il parsing dei monomi.
as_monomial(Expression, Monomial) :-
        atom_chars(Expression, L),
        pda('a', L, [], Specular),
        reverse(Specular, Monomial).


% == == %

test_as_monomial(ML) :- as_monomial('-3xy^3', ML).