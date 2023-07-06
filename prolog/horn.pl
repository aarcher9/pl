check_pos_lit([], _).

check_pos_lit([_ | T], 1) :- fail.

check_pos_lit([_ | T], 0) :- 
        check_pos_lit(T, 1).

check_pos_lit([not(_) | T], Any) :- 
        check_pos_lit(T, Any).


check_or(or(Pred)) :- 
        check_pos_lit(Pred, 0).


check_disjunctions([]).
check_disjunctions([or(Pred) | T]) :- 
        check_or(or(Pred)),
        check_disjunctions(T).

horn(and([])).
horn(and(Disj)) :- check_disjunctions(Disj).


% Test
t1 :- horn(and([or(p)])).
t2 :- horn(and([])).
t3 :- horn(and([or([not(p)])])).
t4 :- horn(and([or([q(X), not(p)])])).
t5 :- horn(and([or([q(X), not(p(X)), w(X, Y)])])).