% palindromos(L) "escribe todas las permutaciones de L que son palindromos"

inverse([], []) :- !.
inverse([X|XS], R) :- inverse(XS, T), append(T, [X], R).

iguales([], []) :- !.
iguales([X|XS], [Y|YS]) :- X = Y, iguales(XS, YS).

capicua(L) :- inverse(L, R), iguales(L, R).

palindromos(L) :- permutation(L, R), capicua(R), write(R).