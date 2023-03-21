%%%% -*- Mode: Prolog -*-

% Eseguire con: '$ swipl -q -s stack_automata.pl'


% ARCHI
/*

Modello:
arc(p, a, _, q, a).
arc(q, b, a, q, b).
arc(q, b, b, q, b).
arc(q, a, a, f, a).
arc(q, a, b, f, a).

*/

arc(p, a, _, q, A).
arc(q, b, A, q, B).
arc(q, b, B, q, B).
arc(q, a, A, f, A).
arc(q, a, B, f, A).


final(I) :- arc(_, I, _, f, _), !.


accept(Start, [Input | InputTail], [SH | ST]) :-
    arc(Start, Input, SH, End, Z),
    !,
    append([Z], [SH | ST], UpdatedStack),
    (length(InputTail, 0) ->
	 final(Input) ; accept(End, InputTail, UpdatedStack)).



% Supponiamo che la dimensione della lista qui sia corretta, almeno 2 elementi. Il più piccolo input possibile è [a, a].

% ES:
% recognize([a, a]).
% > true.

% recognize([a, b, ...b, a]).
% > true.

% Ogni altro input ritorna falso.

recognize(Y) :- accept(p, Y, [_]).
