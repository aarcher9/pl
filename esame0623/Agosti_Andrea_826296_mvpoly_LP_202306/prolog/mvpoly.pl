%%%% -*- Mode: Prolog -*-
%%%% 826296 Agosti Andrea
%%%% <>


% In caso di bisogno:
% C-x h C-M-\ usare il comando per reindentare tutto il file con Emacs.


% Il codice rispetta all'incirca la seguente struttura/architettura: ogni delimitata sezione esegue un certo passaggio della computazione richiamando UNA sola funzione dello "strato" superiore, tipicamente l'ultima definita, ovvero come se fosse il controller/tester di quella sezione. La sezione delle utilities invece raccoglie predicato di generale uso, che possono essere richiamati casualmente nel codice.


% == [ Utilities ] == %
% Shortcut per ricaricare il file con la console SWI aperta.
r :- notrace, nodebug, reconsult('mvpoly.pl').

% Procedura (predicato) di append leggermente modificata per catchare autonomamente le eccezioni. Appende ad una lista una seconda lista o una stringa, o anche atomo.
push(Element, List, New) :- append([Element], List, New).
push([H | T], List, New) :- append([H | T], List, New).

% Rimuove i '' (stringhe vuote) dalla lista.
clean_push('', L, L).
clean_push(Item, List, Out) :- push(Item, List, Out).

% == == %



% == [ PARSER ] == %
% Le cifre arrivano una per volta, verranno poi unite e convertite in tipo numero.
is_digit(Char) :- 
        atom_codes(Char, [H | _]), 
        (H >= 48, H =< 57).


% Controllo che la variabile sia una lettera latina minuscola.
is_var_symbol(Char) :- 
        atom_codes(Char, [H | _]), 
        H >= 97, H =< 122.


% Funzione delta del PDA.
initial('0').
final('digits').
final('vars').


% La delta agisce su due stack, uno che raccoglie i blocchi di monomi parsati e l'altro che raccoglie temporaneamente il monomio corrente per poi scaricarlo sul primo.

delta('0', '-', 'sign', [], [], [], ['-']).
delta('0', '+', 'sign', [], [], [], ['+']).

delta('0', X, 'digits', [], [], [], [X, '+']) :- 
        is_digit(X).

delta('0', X, 'vars', [], [['1', '+']], [], ['1', X]) :- 
        is_var_symbol(X).

delta('sign', X, 'vars', S, [['1', '-'] | S], ['-'], ['1', X]) :- 
        is_var_symbol(X).

delta('sign', X, 'vars', S, [['1', '+'] | S], ['+'], ['1', X]) :- 
        is_var_symbol(X).

delta('sign', X, 'digits', S, S, ['-'], [X, '-']) :- 
        is_digit(X).

delta('sign', X, 'digits', S, S, ['+'], [X, '+']) :- 
        is_digit(X).

delta('digits', X, 'digits', S, S, [H | Tail], [X, H | Tail]) :- 
        is_digit(X),
        is_digit(H).

delta('digits', '*', 'vars', S, [[H | Tail] | S], [H | Tail], []) :-
        is_digit(H).

% ---
% I predicati seguenti intercettano qualunque segno che non sia quello di inizio polinomio. Il carattere % indica l'inizio di un altro monomio.
delta('vars', '+', 'sign', S, ['%', [H | Tail] | S], [H | Tail], ['+']) :-
        is_digit(H).
delta('vars', '-', 'sign', S, ['%', [H | Tail] | S], [H | Tail], ['-']) :-
        is_digit(H).

delta('digits', '+', 'sign', S, ['%', [H | Tail] | S], [H | Tail], ['+']) :-
        is_digit(H).
delta('digits', '-', 'sign', S, ['%', [H | Tail] | S], [H | Tail], ['-']) :-
        is_digit(H).
% ---

delta('vars', X, 'vars', S, S, [], ['1', X]) :- 
        is_var_symbol(X).

delta('vars', '*', 'vars', S, [[H | Tail] | S], [H | Tail], []) :- 
        is_digit(H).

delta('vars', '^', 'exp', S, S, ['1' | Tail], ['1' | Tail]).

delta('exp', X, 'digits', S, S, ['1' | Tail], [X | Tail]) :-
        is_digit(X).

delta('exp', X, 'digits', S, S, [H | Tail], [X, H | Tail]) :-
        is_digit(X).



% Parser.
% Caso generico.
pda(State, [X | Postfix], S, OS, T, OT) :-
        delta(State, X, NewState, S, NS, T, NT),
        pda(NewState, Postfix, NS, OS, NT, OT).

% Caso finale.
pda(State, [], S, NS, T, T) :- 
        final(State),
        push(T, S, NS).


% Inizia l'automa.
parser(AtomicExpr, Result) :-
        atom_chars(AtomicExpr, L),
        initial(S),
        pda(S, L, [], Result, [], _).


% Predicato high-level per il parsing.
% L'input è un COMPOUND in cui gli spazi non contano.
tokenizer(Expression, Result) :-
        term_to_atom(Expression, AtomicExpr),
        parser(AtomicExpr, Result).

% == == %


% == [ GROUPER ] == %
% Fa il reverse di una lista di tokens nestata al massimo di un livello di profondità.
mirror_tokens([], []).
mirror_tokens([H | T], Mirrored) :- 
        mirror_tokens(T, M),
        reverse(H, Temp),
        append(M, [Temp], Mirrored).


% Trova e raggruppa in monomi.
find_monomials([], T, _, S, [T | S]).
find_monomials([], [], _, S, [S]).

find_monomials([H | ['%' | Tail]], T, _, S, [[H | T] | [S | NS]]) :- 
        find_monomials(Tail, [], _, S, NS).

find_monomials([H | Tail], T, [H | T], S, NS) :- 
        find_monomials(Tail, [H | T], _, S, NS).
        

% Raggruppa in monomi.
% L'input è l'output del PARSER.
grouper(Tokens, Result) :-
        find_monomials(Tokens, [], _, [], Group),
        findall([H | T], member([H | T], Group), Clean),
        mirror_tokens(Clean, Result).

% == == %


% == [ BUILDER ] == %
% Si occupa di raggruppare i token nestati nel risulato del parser e di convertirli in numeri (utilizzando predicati come atom_number/2).


% I seguenti predicati uniscono le cifre e rispettivi segni, che al momento sono spearati in tokens appunto, in numeri.
pack_coefficient(L, [Coefficient]) :- 
        atomic_list_concat(L, Atom),
        atom_number(Atom, Coefficient).

pack_vars([], []).
pack_vars([[VarSymbol | ExpDigits] | Others], [[VarSymbol, Exp] | O]) :- 
        atomic_list_concat(ExpDigits, AtomsExp),
        atom_number(AtomsExp, Exp),
        pack_vars(Others, O).

% Gestisce le funzioni soprastanti.
pack_tokens(ML, [Coeff | Vars]) :-
        mirror_tokens(ML, [NH | NT]),
        pack_coefficient(NH, [Coeff | _ ]),
        pack_vars(NT, MirroredVars),
        mirror_tokens(MirroredVars, V),
        reverse(V, Vars).


% Data la lista calcola il grado totale e ritorna la struttura dati voluta (o almeno, simile, poiché non è ancora ordinata).
build_vars([], D, D, []).
build_vars([[Power, VarSymbol] | T], D, ND, [v(Power, VarSymbol) | O]) :-
        C is Power + D,
        build_vars(T, C, ND, O).


% Crea per ogni gruppo di token un oggetto monomio.
% L'input è l'output del GROUPER.
builder([], []).
builder([TokensGroup | T], [m(C, Deg, VarsPowers) | Result]) :-
        pack_tokens(TokensGroup, [C | Vars]),
        build_vars(Vars, 0, Deg, VarsPowers),
        builder(T, Result).

% == == %



% == [ MONOMIAL REORDERER ] == %
% Riordina i monomi secondo l'ordine richiesto. L'oggetto viene prima ordinato rispetto alla potenza (chiave: 1) poi rispetto alla variabile (chiave: 2). Dalla documentazione l'algoritmo di sorting è il merge sort, quindi stabile.
sort_vars([], []).
sort_vars([v(P, VS) | Tail], [v(Power, VarSymbol) | T]) :-
        sort(1, @=<, [v(P, VS) | Tail], [v(P2_, VS2_) | T2_]),
        sort(2, @=<, [v(P2_, VS2_) | T2_], [v(Power, VarSymbol) | T]).


% Minimizzazione del monomio (i termini simili vengono condensati). Il monomio viene preventivamente ordinato per consentire una facilità di approccio al problema.
collapse_vars([], []).
collapse_vars([H | []], [H | []]).

collapse_vars([v(A, Var) | T], [v(P, Var) | Tail]) :-
        collapse_vars(T, [v(B, Var) | Tail]),
        P is A + B.

collapse_vars([v(A, X) | T], [v(A, X) | [v(B, Y) | Tail]]) :-
        collapse_vars(T, [v(B, Y) | Tail]).


% Opera l'effettivo sorting e collassamento delle variabili uguali.
% L'input è l'output del BUILDER.
reorderer([], []).
reorderer([m(C, Deg, VP) | T], [m(C, Deg, Collapsed) | Result]) :-
        sort_vars(VP, Sorted),
        collapse_vars(Sorted, Collapsed),
        reorderer(T, Result).

% == == %



% == [ POLYNOMIAL REORDERER ] == %

% == == %


% == [ Predicati High-Level (richiesti dal testo) ] == %


%
is_monomial(m(_C, TD, VPs)) :-
        integer(TD),
        TD >= 0,
        is_list(VPs).


%
is_varpower(v(Power, VarSymbol)) :-
        integer(Power),
        Power >= 0,
        atom(VarSymbol).


%
is_polynomial(poly(Monomials)) :-
        is_list(Monomials),
        foreach(member(M, Monomials), is_monomial(M)).


% TODO type checking?
coefficients([], []).
coefficients([m(C, _, _) | T], [C | Coefficients]) :-
        coefficients(T, Coefficients).


%
find_variables([], []).

find_variables([v(_, VS) | VT], [VS | Variables]) :-
        find_variables(VT, Variables).

find_variables([m(_, _, Vars) | MT], [V | M]) :-
        find_variables(Vars, V),
        find_variables(MT, M).

% A causa della lista in lista dovuta ai predicati la spacchettiamo prima di sortarla.
variables(Poly, Variables) :-
        is_polynomial(Poly),
        find_variables(Poly, [Raw | []]),
        sort(0, @<, Raw, Variables).


% TODO ordinare la lista come dovrebbe essere per il polinomio.
monomials(Poly, Poly) :-
        is_polynomial(Poly).


%
max_degree(Poly, Degree) :-
        is_polynomial(Poly),


% Dal momento che il PDA è unico per monomi e polinomi, normalmente il risultato sarebbe una lista di monomi, se mi aspetto di parsare un monomio mi basta prendere il primo elemento.
as_monomial(Expression, Monomial) :-
        tokenizer(Expression, Tokens),
        grouper(Tokens, Grouped),
        builder(Grouped, Build),
        reorderer(Build, [Monomial | _]).

% TODO ordinare il polinomio.
as_polynomial(Expression, Polynomial) :-
        tokenizer(Expression, Tokens),
        grouper(Tokens, Grouped),
        builder(Grouped, Build),
        reorderer(Build, Polynomial).

% == == %














% == [ TEST ] == %
% Dal momento che alcuni predicati, se non tutti si basano sul backtracking usare il cut ! nei test potrebbe farli fallire anche quando non dovrebbero. Prestare attenzione! Inoltre alcune volte per qualche problema con le iterazioni forse, alcuni input falliscono il test, ma lo passano se testati singolarmente.
% Esempio per interrogare un test da CLI: 
% ?- p4(P), test__as_polynomial(P).

% Alcune prove.
p1([3*x, -3*x, -x, +x, x, +3, -3, 3, -36*k^68, -3*x*y^35*z, 0, -0, -3*x*x^3*y*a^2*a*y^8, -3*x*a*y^35*z]).
p2([-3*x*y^35*z, 3*x + 4*r, -3*x*a*y^35*z]).
p3([3*x + 4*r]).
p4([-3*x*a*y^35*z, 3*x]).


test__as_polynomial([]).
test__as_polynomial([H | T]) :-
        as_polynomial(H, Polynomial), write(Polynomial), nl,
        test__as_polynomial(T).


test__coefficients([]).
test__coefficients([H | T]) :-
        as_polynomial(H, Polynomial),
        coefficients(Polynomial, Coefficients), write(Coefficients), nl,
        test__coefficients(T).


test__variables([]).
test__variables([H | T]) :-
        as_polynomial(H, Polynomial),
        variables(Polynomial, Variables), write(Variables), nl,
        test__variables(T).