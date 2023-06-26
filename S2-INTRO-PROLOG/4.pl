% Usando "append", define "lastone(L, X)" (X es el último elemento de L) y "inverse(L, R)" (R es el reverso de L)


lastone(L, X) :- append(_, [X], L).

inverse([], []) :- !.
inverse([X|XS], R) :- inverse(XS, T), append(T, [X], R).