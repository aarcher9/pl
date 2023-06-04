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



test_split_polynomials(ML) :- split_polynomial("-3x++----++-4++6y-8-12+3z", ML).
% test_cleanout(E) :- remove_empty_items(["", "d", "", "ci", ""], E).

% as_monomial(Expression, Monomial).
% as_polynomial(Expression, Polynomial) :- 
%         atom_chars(Expression, Buffer).