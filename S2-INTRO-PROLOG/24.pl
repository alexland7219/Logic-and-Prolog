%%==== Example: ========================================================
numVertices(10).
minCliqueSize(4).
vertices(Vs):- numVertices(N), findall(I,between(1,N,I),Vs).
vertex(V):- vertices(Vs), member(V,Vs).
edge(U,V):- edge1(U,V).
edge(U,V):- edge1(V,U).
edge1(9,8).
edge1(8,2).
edge1(7,4).
edge1(5,7).
edge1(4,2).
edge1(5,2).
edge1(2,7).
edge1(7,9).
edge1(2,9).
edge1(4,8).
edge1(4,9).
edge1(9,5).
edge1(4,5).

% R es subconjunto de L
subconjunto([], []).
subconjunto([_|XS], R) :- subconjunto(XS, R).
subconjunto([X|XS], [R|RS]) :- R = X, subconjunto(XS, RS).

% El tamaño de la lista S debe ser como minimo K
minsize(_, 0).
minsize([_|XS], M) :- M1 is M - 1, minsize(XS, M1).

%%==========================================================
main:- minCliqueSize(H), vertices(Vs), subconjunto( Vs, S), minsize(S, H), isClique(S, S), write(S), nl, fail.
main:- halt.

adjacentToAll(_, []).
adjacentToAll(V, [T|TS]) :- V = T, adjacentToAll(V, TS).
adjacentToAll(V, [T|TS]) :- edge(V, T), adjacentToAll(V, TS).

isClique(_, []).
isClique(T, [V | VS]) :-
    adjacentToAll(V, T),
    isClique(T, VS).