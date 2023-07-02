% find(void, _, CD, CD).
find(Node, Node, CD, CD).
find(node(_, _, L, R), Node, D, ND) :- 
        CD is D + 1, 
        (find(L, Node, CD, ND) ; find(R, Node, CD, ND)).