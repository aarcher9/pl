%%%% -*- Mode: Prolog -*-
%%%% 826296 Agosti Andrea
%%%% <>


% In caso di bisogno:
% C-x h C-M-\ usare il comando per reindentare tutto il file con Emacs.


% Il codice rispetta la seguente struttura: ogni delimitata sezione esegue un certo passaggio della computazione richiamando UNA sola funzione dello "strato" superiore, tipicamente l'ultima definita, ovvero come se fosse il controller di quella sezione. Assomiglia molto ad una divisione in "classi" di compiti in un linguaggio ad oggetti. La sezione delle utilities invece raccoglie predicato di generale uso, che possono essere richiamati casualmente nel codice.


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



% == [ PARSER ] == %
% Le cifre arrivano una per volta, verranno poi assemblate.
is_digit(Char) :- 
        atom_codes(Char, [H | _]), 
        (H >= 48, H =< 57).


% Controllo che la variabile sia una lettera latina minuscola.
is_var_symbol(Char) :- 
        atom_codes(Char, [H | _]), 
        H >= 97, H =< 122.


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
delta('sign', X, 'vars', [], [['1', '-']], ['-'], ['1', X]) :- 
        is_var_symbol(X).

delta('sign', X, 'vars', [], [['1', '+']], ['+'], ['1', X]) :- 
        is_var_symbol(X).

delta('sign', X, 'digits', [], [], T, NT) :- 
        is_digit(X),
        push(X, T, NT).

delta('digits', X, 'digits', S, S, [H | Tail], NT) :- 
        is_digit(X),
        is_digit(H),
        push(X, [H | Tail], NT).

% ---
delta('digits', ' ', 'mult', S, NS, [H | Tail], []) :-
        is_digit(H),
        push([H | Tail], S, NS).

% delta('mult', '*', 'mult', S, NS, T, T).
% delta('mult', ' ', 'vars', S, NS, T, T).

% delta('digits', X, 'vars', S, NS, [H | Tail], ['1', X]) :- 
%         is_var_symbol(X), 
%         is_digit(H),
%         push([H | Tail], S, NS).

% ----
delta('mult', '*', 'mult', S, S, T, T).
delta('mult', ' ', 'vars', S, S, T, T).

delta('vars', X, 'vars', S, S, [], ['1', X]) :- 
        is_var_symbol(X).

delta('vars', ' ', 'mult', S, NS, [H | Tail], []) :-
        is_digit(H),
        push([H | Tail], S, NS).

delta('vars', '^', 'exp', S, S, ['1' | Tail], ['1' | Tail]).

delta('exp', X, 'digits', S, S, ['1' | Tail], NT) :-
        is_digit(X),
        push(X, Tail, NT).

delta('exp', X, 'digits', S, S, [H | Tail], NT) :-
        is_digit(X),
        push(X, [H | Tail], NT).



% Parser dei monomi.
% Caso generico.
pda(State, [X | Postfix], S, OS, T, OT) :-
        delta(State, X, NewState, S, NS, T, NT),
        pda(NewState, Postfix, NS, OS, NT, OT).

% Caso finale.
pda(State, [], S, NS, T, T) :- 
        final(State),
        push(T, S, NS).


% Predicato high-level per il parsing dei monomi. Rappresenta il monomio in una struttura affine a quanto voluto dal testo dell'esame. La lista risultate rappresenta una versione specchiata dell'input per via della facile gestione della lista come uno stack usando la notazione testa-coda, mettendo quindi l'input meno recente (quello più a destra nell'input) a sinistra.
% L'input è una atomo (una sequenza di caratteri).
as_monomial_list(Expression, MonomialList) :-
        atom_chars(Expression, L),
        initial(S),
        pda(S, L, [], MonomialList, [], _).

% == == %


% == [ BUILDER ] == %
% Ora i monomi parsati hanno tutti una struttura standard comune (la stessa "interfaccia"), quella costruita dal parser PDA.
% Una volta resa come voluto implementeremo le operazioni per manipolare quella (successivamente).


% Fa il reverse di una lista nestata al massimo di un livello di profondità, una lista con la struttura definita dal parser (MonomialList).
mirror_monomial_list([], []).
mirror_monomial_list([H | T], Mirrored) :- 
        mirror_monomial_list(T, M),
        reverse(H, Temp),
        append(M, [Temp], Mirrored).


% Rendo l'oggetto più fedele alla realtà, unendo le cifre e rispettivi segni, che al momento sono spearati, in veri e propri numeri.
pack_coefficient(L, [Coefficient]) :- 
        atomic_list_concat(L, Atom),
        atom_number(Atom, Coefficient).

pack_vars([], []).
pack_vars([[VarSymbol | ExpDigits] | Others], [[VarSymbol, Exp] | O]) :- 
        atomic_list_concat(ExpDigits, AtomsExp),
        atom_number(AtomsExp, Exp),
        pack_vars(Others, O).

pack_monomial(ML, [Coeff | Vars]) :-
        mirror_monomial_list(ML, [NH | NT]),
        pack_coefficient(NH, [Coeff | _ ]),
        pack_vars(NT, MirroredVars),
        mirror_monomial_list(MirroredVars, V),
        reverse(V, Vars).


% Data la lista di variabili calcola il grado totale e ritorna la struttura dati voluta (o almeno, simile, poiché non è ancora ordinata).
build_vars([], D, D, []).
build_vars([[Power, VarSymbol] | T], D, ND, [v(Power, VarSymbol) | O]) :-
        C is Power + D,
        build_vars(T, C, ND, O).


% Costruiamo una struttura dati simile a quella voluta. L'input è una lista contenente liste che rappresentano  con in numeri "impacchettati" piuttosto che come sequenze di caratteri.
as_non_standard_monomial(Expression, m(Coeff, TotalDegree, VarsPowers)) :-
        as_monomial_list(Expression, MonomialList),
        pack_monomial(MonomialList, [Coeff | Vars]),
        build_vars(Vars, 0, TotalDegree, VarsPowers).

% == == %



% == [ SORTER & COLLAPSER ] == %
% Riordina i monomi secondo l'ordine richiesto. Non è responsabile dell'unione di termini simili. Viene chiaramente prima ordinato rispetto alla potenza (chiave: 1) poi rispetto alla variabile (chiave: 2). Dalla documentazione l'algoritmo di sorting è il merge sort, quindi stabile, per questo motivo è possibile ottenere l'output desiderato. Il predicato si può usare sia su degli oggetti senza i duplicati per variabile sia che su oggetti con.
sort_vars([v(P, VS) | Tail], [v(Power, VarSymbol) | T]) :-
        sort(1, @=<, [v(P, VS) | Tail], [v(P2_, VS2_) | T2_]),
        sort(2, @=<, [v(P2_, VS2_) | T2_], [v(Power, VarSymbol) | T]).


% TODO
% Minimizzazione del monomio (i termini simili vengono condensati). Il monomio viene preventivamente ordinato per consentire una facilità di approccio al problema.
collapse_vars([v(P1_, VarSymbol) | [v(P2_, VarSymbol) | T]], [v(P, VarSymbol) | T]) :-
        P is P1_ + P2_.


% collapse_monomial(Expression, m(C, Deg, [v(Power, VarSymbol) | T])) :-
%         as_non_standard_monomial(Expression),
%         sort_vars(Expression, m(C, Deg, [v(P1, VS1) | [v(NP1, NVS1) | T]])),
%         collapse_vars().

% == == %








% == [ TEST ] == %
% Test per il parser.
test_parser() :-
        test_A(['3 * x', '-3 * x', '-x', '+x', 'x', '+3', '-3', '3', '-36 * k^68', '-3 * x * y^35 * z', '0', '-0']).

test_A([]).
test_A([H | T]) :-
        as_monomial_list(H, A), write(A), nl, nl, !,
        test_A(T).


% Test per il builder.
test_builder() :-
        test_B(['-3xy^35z', '-36k^68', '-3', '0']).

test_B([]).
test_B([H | T]) :-
        as_non_standard_monomial(H, NSM), write(NSM), nl, nl, !,
        test_B(T).