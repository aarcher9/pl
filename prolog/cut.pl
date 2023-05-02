%%%% -*- Mode: Prolog -*-

predicato1(X, Res) :- regola1(X, Res), !, regola2(X).
predicato1(X, Res) :- regola3(X, Res).

regola1(X, 'Maggiore di 0') :- X > 0.
regola1(X, 'Maggiore di 5') :- X < 0.

regola2(X) :- X < 10.

regola3(X, 'Uguale a 0').

% Esempi
sr :- reconsult('cut.pl').

es1(Res) :- 
    write('Esempio 1: '), 
    write('Passando X = 10, regola1 ritorna subito vero, quidi le scelte fatte sulle variabili vengono lockate. Mi aspetto Res == \'Maggiore di 0\''),
    predicato1(9, Res).

es2(Res) :- 
    write('Esempio 2: '), 
    write('Passando X = -1, regola1 fallisce ma poi ha successo, quindi non cambia sostanzialmente nulla. Mi aspetto Res == \'Maggiore di 5\''),
    predicato1(-1, Res).

es3(Res) :- 
    write('Esempio 3: '), 
    write('Passando X = 0, regola1 fallisce sempre. Viene eseguita subito regola3. Mi aspetto Res == \'Uguale a 0\''),
    predicato1(0, Res).