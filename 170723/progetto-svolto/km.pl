% De Grandis Marco    745996
% Leonetti Alessandro 746215
% Cassataro Riccardo  736424 

/* kmeans(Observations,K ): applies the kmeans algorithm to the lsit of observations given k
*/

kmeans(O,K,R):-
	rand_elements(O,K,CS),
	partitions(O,CS,Clusters),
	kmeans0(O,[],Clusters,R).

% Aggiunta
kmeansdbg(Obs, Kn, [Cs, Klus]) :-
        kmeans(Obs, Kn, [Cs, Klus]),
        nl, write('Centroids:'), nl,
        maplist(writeln, Cs), nl,
        write('Clusters:'), nl,
        maplist(writeln, Klus).


/* kmeans0(Obs,Clusters,NewClusters): iterates until a solution is found */

kmeans0(_,C,NC,NC):-
	sameClusters(C,NC),!.
kmeans0(Obs,_,NC,R):-
	recomputeCentroids(NC,NewCentroids),
	partitions(Obs,NewCentroids,Cluster2),
	kmeans0(Obs,NC,Cluster2,R).



/* vsub(V1, V2, V): substracts V1 - V2 */
vsub([], [], []):-!.
vsub([H1|T1], [H2|T2], [HS|TS]):- HS is H1-H2,
	                          vsub(T1, T2, TS).


/* innerprod(V1, V2, R): dot product between V1 and V2 */
innerprod([],[],0):-!.
innerprod([H1|T1],[H2|T2],R):-innerprod(T1,T2,R2),
			      R is R2+H1*H2.

/*  norm(V,N): computes the norm for vector v */
norm(V,N):- innerprod(V,V,N2), sqrt(N2,N).

/* dist(P1, P2, D): computes the distance from p1 to p2 */
dist(P1,P2,D):-vsub(P1,P2,S), norm(S,D).

min(A,B,A):-A<B,!.
min(_,B,B).


/* closest(X,CS,P): given a list a point x computes the element of cs closer to x */

closest(_,[P],P):-!.
closest(X,[H|T],P1):-dist(H,X,D1),
		     closest(X,T,P1),
		     dist(X,P1,D2),
		     D2 < D1, !.
closest(_,[H|_],H).


/* vsum(V1,V2,V): adds V1 and V2 */

vsum([],[],[]):-!.
vsum([H1|T1],[H2|T2],[H|T]):-H is H1+H2,
			     vsum(T1,T2,T).


/* vecByScalar(V,S,R): computes v*s (v a vector, s a scalar) */
vecByScalar([],_,[]):-!.
vecByScalar([H|T],S,[RH|RT]):-RH is H*S,
			      vecByScalar(T,S,RT).

/* vequal(V1,V2): compares V1 and V2 for equality*/

vequal([],[]):-!.
vequal([H1|T1],[H1|T2]):-vequal(T1,T2).

/* addAll(L,X): adds all the vectors in L */
addAll([X],X):-!.
addAll([H|T], X):- addAll(T,X1), vsum(H,X1,X).

/* centroid(L,C) computes the centroid of cluster l (l is a list of points) */
centroid(L,C):-addAll(L,X), length(L,S), IS is 1/S, vecByScalar(X,IS,C).

/* inList(L,V): checks if V is inside L */
inList([H|_],H):-!.
inList([_|T],X):-inList(T,X).

/* recomputeCentroids(C,C1):  recomputes the centroids of the given clusters */
recomputeCentroids([],[]):-!.
recomputeCentroids([H|T],[H2|T2]):-centroid(H,H2),recomputeCentroids(T,T2).


/* getIndexOf(L,V,IA,I): gets the index of V inside L. IA must be 0 initially */

getIndexOf([],_,_,-1):-!.
getIndexOf([H|_],H,IA,IA):-!.
getIndexOf([_|T],V,IA,I):-I2 is IA+1,
	                  getIndexOf(T,V,I2,I).

/* getIndexOf2(L,V,IA,I): gets the index of V inside L. L is a list of lists of vectors, and we are looking for the index of the second level list where V can be found. IA must be 0 initially */
getIndexOf2([],_,_,-1):-!.
getIndexOf2([H|_],V,IA,IA):-inList(H,V),!.
getIndexOf2([_|T],V,IA,I):-I2 is IA+1,
	                   getIndexOf2(T,V,I2,I).

/* n_th(L,N,E): returns in E the nth element from L and L without the nth element */

n_th([H|T],0,(H,T)):-!.
n_th([H|T],N,(E,[H|TT])):-N1 is N-1,
	              n_th(T,N1,X),
		      (E,TT)=X.


/* sameCluster(Cl1,Cl2): compares clusters Cl1 and Cl2 */

sameCluster([], []):-!.
sameCluster([H1|T1], Cl2):- getIndexOf(Cl2,H1, 0, I),
			    I \== -1,
			    n_th(Cl2, I, X),
			    (_,T)=X,
			    sameCluster(T1, T).



/* rand_elements(L,K,R): returns K random elements from L */

rand_elements(_,0,[]):-!.
rand_elements(L,K,[H|T2]):-length(L,S),
		      random(0,S,RN),
		      n_th(L,RN,X),
		      (H,T)=X,
		      K2 is K-1,
		      rand_elements(T,K2,T2).

/* sameClusters(C1,C2): returns tue if C1 and C2 are the same clusters */

sameClusters([],[]):-!.
sameClusters([[H1|T1]|T],C2):-getIndexOf2(C2,H1,0,I),
	                I \== -1,
			n_th(C2,I,X),
			(H2,T2) = X,
			sameCluster([H1|T1],H2),
			sameClusters(T,T2).

takeEqual([X],[X]):-!.
takeEqual([(Idx1,V1),(Idx1,V2)|T],[(Idx1,V1)|T2]):-
	                  takeEqual([(Idx1,V2)|T],T2),!.
takeEqual([X|_],[X]).

drop_n(L,0,L):-!.
drop_n([_|T],N,T2):-N1 is N-1,
	                drop_n(T,N1,T2).

/* partitions(Observations,CS,Result): partitions the observations in K clusters given CS centroids */

partitions(O,CS,R):-pairWithClosest(O,CS,O2),
		    sort(O2,O3),
		    partition0(O3,O4),
		    removeFst0(O4,R).

pairWithClosest([],_,[]):-!.
pairWithClosest([H|T],CS,[(X,H)|T2]):-
	closest(H,CS,X),
	pairWithClosest(T,CS,T2).

removeFst0([],[]):-!.
removeFst0([H|T],[H2|T2]):-removeFst(H,H2),removeFst0(T,T2).

removeFst([],[]):-!.
removeFst([(_,X)|T],[X|T2]):-removeFst(T,T2).


partition0([],[]):-!.
partition0(L,[Eq|P2]):-
	takeEqual(L,Eq),
	length(Eq,N),
	drop_n(L,N,R),
	partition0(R,P2).
