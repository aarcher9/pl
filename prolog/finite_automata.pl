%%%% -*- Mode: Prolog -*-


% NODI
initial(p1).
final(p6).

node(p1).
node(p2).
node(p3).
node(p4).
node(p5).
node(p6).


% ARCHI
arc(p1, a, p2).
arc(p3, b, p6).
arc(p1, c, p6).
arc(p4, d, p5).
arc(p3, e, p5).
arc(p5, f, p4).
arc(p2, g, p3).
arc(p3, h, p2).
arc(p4, i, p3).

