%%%% -*- Mode: Prolog -*-
%%%% 826296 Agosti Andrea
%%%% <>


% In caso di bisogno:
% C-x h C-M-\ usare il comando per reindentare tutto il file con Emacs.


% == [ Utilities ] == %
% Shortcut per ricaricare il file con la console SWI aperta.
rel :- notrace, nodebug, reconsult("mvpoly.pl").

% Procedura (predicato) di append leggermente modificata per catchare autonomamente le eccezioni. Appende ad una lista una seconda lista o una stringa, o anche atomo.
push(Element, List, New) :- append([Element], List, New).
push([H | T], List, New) :- append([H | T], List, New).

% Rimuove i "" (stringhe vuote) dalla lista.
clean_push("", L, L).
clean_push(Item, List, Out) :- push(Item, List, Out).

% == == %


/*

% == [ Divisione in stringhe di monomi ] == %
% Divide la stringa in input in monomi. Se splitto lasciando "" nel 3 parametro i segni '-' doppi non vengono considerati come uno solo. Questo dovrebbe fare in modo che il programma torni false se il polinomio inserito non è correttamente scritto.
split_polynomial(Expression, MonomialsList) :-
        split_string(Expression, "-", "-", [H | T]),
        reinsert_minus(T, Tail),
        push(H, Tail, PolynomialList),
        strip_pluses(PolynomialList, Nested),
        flatten(Nested, Dirty),
        remove_empty_items(Dirty, MonomialsList).


% Fa in modo che la lista venga pulita da eventuali "" avanzati.
remove_empty_items([], []).
remove_empty_items([H | T], Out) :-
        remove_empty_items(T, Tail),
        clean_push(H, Tail, Out).


% Splitta l'espressione basandosi sui segni '-'.
clean_minuses([], []).
clean_minuses([H | T], Out) :- 
        split_string(H, "-", "-", A),
        clean_minuses(T, B),
        push(A, B, Out).

strip_minuses(Expression, Out) :- 
        split_string(Expression, "-", "-", O),
        clean_minuses(O, Out).


% Rimuove i segni "+" dalla lista di polinomi una lista di monomi.
strip_pluses([], []).
strip_pluses([H | T], Out) :- 
        split_string(H, "+", "+", A),
        strip_pluses(T, B),
        push(A, B, Out).

% strip_pluses([], []).
% strip_pluses([H | T], Out) :- clean_pluses([H | T], Out).


% Accorpa i '-' rimossi dallo split dove andrebbero messi. I '+' sono neutri (1 o 100 non cambia il senso del monomio). Fa in modo che se nel polinomio passato a split_polynomial ci sono catene di '-' vengano eliminati tutti meno uno, quello del monomio.
reinsert_minus([], []).

reinsert_minus([H | T], Out) :-
        reinsert_minus(T, Tail),
        atom_concat("-", H, Head),
        push(Head, Tail, Out).

% == == %

*/

% == [ Parsing monomi ] == %
% Si suppone che arrivi un carattere alla volta.
is_digit(Char) :- atom_codes(Char, [H | _]), H >= 48, H =< 57.
is_var_symbol(Char) :- atom_codes(Char, [H | _]), H >= 97, H =< 122.

% Per uno stack l'append fa eseguito "al contrario" in modo che usando la notazione [Head | Tail] lo stack top sia sempre la Head.
% stack_push(Item, Stack, New) :- push(Stack, [Item], New).


% Funzionde delta del PDA che riconosce un monomio.
delta("a", "+", "b", [], []).
delta("a", "-", "b", [], NS) :- push("-", [], NS).

delta("b", D, "c", [], NS) :- is_digit(D), push(D, [], NS).
delta("b", D, "c", ["-"], NS) :- is_digit(D), push(D, ["-"], NS).

delta("c", D, "c", [H | Tail], NS) :- is_digit(D), push(D, [H | Tail], NS).


% Parser dei monomi.
% as_monomial(Expression, Monomial) :-
%         atom_chars(Espression, L).


% == == %

test_as_monomial(ML) :- as_monomial("-3xy^3", ML).