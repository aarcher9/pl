%%%% -*- Mode: Prolog -*-


% ========== ========== ========== ========== ========== %
% Regola generale importante! Se uso _ per una variabile poi ho difficoltà a stamparne il valore, perchè le variabili anonime vengono stampate con il come  _09090. Meglio usare una variabile normale e fare in modo che non sia singleton. Inoltre la variabile normale deve essere comunqua inizializzata o produrrà un effetto simile.


push(ITEM, CURRENT_S, UPDATED_S) :- append([ITEM], CURRENT_S, UPDATED_S), !.
pop([_ | TAIL], UPDATED_S) :- UPDATED_S = TAIL, !.


rlen([_ | T], C, Count) :- C is C + 1, write(C), rlen(T, C, Count), Count = C, write(C).
len([], 0).
len([_], 1).
len(LIST, Length) :- rlen(LIST, 2, Length).


initial(i).
final(f).


% ========== ========== ========== ========== ========== %
% Descrizione logica dei fatti 'arc'.
% (nodo, carattere in input, stack attuale, nodo di arrivo, stack aggiornato, json, json aggiornato)
% BS = brackets stack
% UBS = updated brackets stack
% La regola append() aggiunge in testa; controintuitivamente la testa (top) dello stack sta a sinistra.


% Accettazione dei caratteri liberi.
% Non ho bisogno di "poppare" perchè quando 'accept' chiama 'arc' uso la notazione delle liste [Testa | Coda].
arc(N, ' ', BS, N, BS, S_, S_).
arc(N, '\n', BS, N, BS, S_, S_).
arc(N, '\t', BS, N, BS, S_, S_).
arc(N, '\r', BS, N, BS, S_, S_).


% Parentesi QUADRE
arc(i, '[', BS, s, UBS, S_, S_) :- push('[', BS, UBS).
arc(s, '[', BS, s, UBS, J, UJ) :- push('[', BS, UBS), push(['#'], J, UJ).
arc(s, ']', BS, s, UBS, S_, S_) :- pop(BS, UBS).
arc(s, [], [], f, [], S_, S_).


/* DA AGGIORNARE
% Parentesi GRAFFE
arc(i, '{', BS, c, UBS) :- push('{', BS, UBS).
arc(c, '{', BS, c, UBS) :- push('{', BS, UBS).
arc(c, '}', BS, c, UBS) :- pop(BS, UBS).
arc(c, [], [], f, []).

% Archi di passaggio
arc(c, '[', BS, s, UBS) :- push('[', BS, UBS).
arc(s, '{', BS, c, UBS) :- push('{', BS, UBS).
arc(s, '}', ['{' | TAIL], c, TAIL).
arc(c, ']', ['[' | TAIL], s, TAIL).
*/

% ========== ========== ========== ========== ========== %
% Le regole sono ordinate nel possibile senso di chiamata.

% CASO INIZIALE NULLO
% Se l'input risulta vuoto, lo stack anche è come se fossi sul nodo iniziale, quindi va tutto bene.
accept([], []).


% CASO INIZIALE GENERICO
% "Overloading" di convenienza per la regola 'accept' in modo da nascondere più dettagli possibile all'esterno di questa zona.
accept(LIST, [], T, JSON) :- 
    initial(NODE), !, 
    accept(NODE, LIST, [], T, JSON).


% Regola di accettazione.
accept(NODE, [CI | INPUT_REST], STACK, T, JSON) :-
    arc(NODE, CI, STACK, END_NODE, UPDATED_STACK, T, NT), !,
    accept(END_NODE, INPUT_REST, UPDATED_STACK, NT, JSON).


% CASO DI CONTROLLO FINALE
accept(NODE, [], [], T, JSON) :- 
    arc(NODE, [], [], END_NODE, [], T, JSON), !,
    final(END_NODE).


% ===== MAIN ===== %

% Esempi
% ACCETTA: {[][][{}{{[]}}]}{}[]
% ACCETTA: {[] [] [{} {{[    ]}}]} {} []

brackets_match(STRING) :- 
    atom_chars(STRING, LIST),
    accept(LIST, [], [], JSON), !,
    write(JSON).
