%%%% -*- Mode: Prolog -*-

% Scrittura di un programma che effettua il parsing di una stringa in un numero float.
% RIFIUTA:
% 



is_sign(Char) :- Char == '+', ! ; Char == '-', !.
is_digit(Char) :- char_type(Char, digit).
is_float_sym(Char) :- Char == '.', !.

arc(p, I, _, q, I) :- is_sign(I), !.
arc(p, I, _, s, I) :- is_digit(I), !.
arc(q, I, Old, s, I) :- is_sign(Old), !, is_digit(I), !.
arc(s, I, Old, s, I) :- is_digit(I), !, is_digit(Old), !.
arc(s, I, Old, r, I) :- is_float_sym(I), !, is_digit(Old), !.

arc(r, I, Old, r, I) :-
    (is_digit(Old) ; is_float_sym(Old)), !,
    is_digit(I), !.

arc(s, I, Old, f, _) :- is_digit(Old), !, is_digit(I), !.
arc(r, I, Old, f, _) :- is_digit(Old), !, is_digit(I), !.


final(I) :- arc(_, I, _, f, _), !.


accept(Start, [Input | InputTail], [SH | ST]) :-
    arc(Start, Input, SH, End, Z),
    !,
    append([Z], [SH | ST], UpdatedStack),
    (length(InputTail, 0) ->
	 final(Input) ; accept(End, InputTail, UpdatedStack)).


recognize(Y) :- accept(p, Y, [_]).
