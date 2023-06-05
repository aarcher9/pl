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
% Le cifre arrivano una per volta, verranno poi assemblate.
is_digit(Char) :- 
        atom_codes(Char, [H | _]), 
        (H >= 48, H =< 57).


% Controllo che la variabile sia una lettera latina minuscola.
is_var_symbol(Char) :- 
        atom_codes(Char, [H | _]), 
        H >= 97, H =< 122.


% Fa il reverse di una lista nestata al massimo di un livello di profondità.
mirror_monomial_list([], []).
mirror_monomial_list([H | T], Mirrored) :- 
        mirror_monomial_list(T, M),
        reverse(H, Temp),
        append(M, [Temp], Mirrored).


% Funzionde delta del PDA che riconosce un monomio.
initial('0').
final('digits').
final('vars').

% La logica è quella di creare una funzione delta che oltre a comportarsi come una delta 'ordinaria' per il PDA opera anche la traduzione in "oggetto" del monomio. L'automata ha infatti due stack (4 passati come argomento per via della struttura di prolog che non prevede modifiche dirette di oggetti come le liste), uno per conservare i token (le parti del monomio inscindibili) e l'altro per "scaricarli" e conservare l'oggetto finale.

delta('0', '+', 'sign', [], [], [], ['+']).
delta('0', '-', 'sign', [], [], [], ['-']).

delta('0', X, 'digits', [], [], [], [X, '+']) :- 
        is_digit(X).

% Coefficiente 1 implicito.
delta('0', X, 'vars', [], [['1', '+']], [], [X]) :- 
        is_var_symbol(X).

% Coefficiente -1 implicito.
delta('sign', X, 'vars', [], [['1', '-']], ['-'], [X]) :- 
        is_var_symbol(X).

delta('sign', X, 'vars', [], [['1', '+']], ['+'], [X]) :- 
        is_var_symbol(X).

delta('sign', X, 'digits', [], [], T, NT) :- 
        is_digit(X),
        push(X, T, NT).

delta('digits', X, 'digits', S, S, [H | Tail], NT) :- 
        is_digit(X),
        is_digit(H),
        push(X, [H | Tail], NT).

delta('digits', V, 'vars', S, NS, [H | Tail], NT) :- 
        is_var_symbol(V),
        is_digit(H),
        push(V, [], NT),
        push([H | Tail], S, NS).

delta('vars', V, 'vars', S, NS, [H | Tail], NT) :- 
        is_var_symbol(V),
        is_var_symbol(H),
        push(V, [], NT),
        push([H | Tail], S, NS).

delta('vars', '^', 'exp', S, S, [H | Tail], [H | Tail]) :- 
        is_var_symbol(H).

delta('exp', X, 'digits', S, S, [H | Tail], NT) :-
        is_digit(X),
        push(X, [H | Tail], NT).



% Parser dei monomi.
% Caso generico.
pda(State, [X | Postfix], S, OS, T, OT) :-
        delta(State, X, NewState, S, NS, T, NT),
        pda(NewState, Postfix, NS, OS, NT, OT).

% Caso finale.
pda(State, [], S, NS, [H | T], [H | T]) :- 
        final(State),
        push([H | T], S, NS).

% Predicato high-level per il parsing dei monomi. Rappresenta il monomio in una struttura affine a quanto voluto dal testo dell'esame. La lista risultate rappresenta una versione specchiata dell'input per via della facile gestione della lista come uno stack usando la notazione testa-coda, mettendo quindi l'input meno recente (quello più a destra nell'input) a sinistra.
monomial_list(Expression, MonomialList) :-
        atom_chars(Expression, L),
        initial(S),
        pda(S, L, [], MonomialList, [], _).


% Alcuni test di controllo.
test_all_monomial_list() :-
        monomial_list('3x', A), write(A), nl, !,
        monomial_list('-3x', B), write(B), nl, !, 
        monomial_list('-x()', C), write(C), nl, !,
        monomial_list('+x', D), write(D), nl, !,
        monomial_list('+3', E), write(E), nl, !,
        monomial_list('-3', E1), write(E1), nl, !,
        monomial_list('3', E2), write(E2), nl, !,
        monomial_list('-3x', F), write(F), nl, !,
        monomial_list('-36k^68', G), write(G), nl, !,
        monomial_list('-3xy^3z', H), write(H), nl, !.

% == == %


% == [ Costruzione struttura dati adatta monomi ] == %

% == == %