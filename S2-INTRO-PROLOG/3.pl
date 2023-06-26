% Intersección y unión de conjuntos
% intersec(L1, L2, L) <=> L1 ∩ L2 = L 
% union(L1, L2, L) <=> L1 U L2 = L 
% **Podemos asumir que ninguna lista contiene elementos repetidos.**

intersec([], _, []) :- !.
intersec([X|XS], L, [X|S]) :- member(X, L), intersec(XS, L, S).
intersec([X|XS], L, S) :- intersec(XS, L, S), not(member(X, L)).

union([], L, L) :- !.
union([X|XS], L, [X|S]) :- not(member(X, L)), union(XS, L, S).
union([X|XS], L, S) :- member(X, L), union(XS, L, S).