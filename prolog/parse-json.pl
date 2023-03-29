%%%% -*- Mode: Prolog -*-



% @CN (current node) 
    % nodo di inizio dell'arco
% @EN (end node) 
    % nodo di arrivo secondo l'arco
% @X () 
    % nuovo elemento da stackare
% @NS (new stack) 
    % stack con X stackato
% @[I (input) | IR (input rest)] 
    % I input corrente, IR il resto degli input
% @[CST (current stack top) | SR (stack rest)] 
    % CST cima dello stack, SR il resto dello stack 

accept(CN, [], _) :- final(CN).
accept(CN, [I | IR], [CST | SR]) :-
    arc(CN, I, CST, EN, X), !,
    append([X], [CST | SR], NS),
    accept(EN, IR, NS).

    (length(IR, 0) ->
	 final(I) ; accept(EN, IR, NS)).


brackets_match(""). 
brackets_match(Y) :- atom_chars(Y, L), accept(p, L, [_]).