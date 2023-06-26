% esta_ordenada(L) "L está ordenada ascendentemente"

esta_ordenada([]) :- !.
esta_ordenada([X|XS]) :- ordenada_aux(X, XS).

ordenada_aux(_, []) :- !.
ordenada_aux(X,[Y|YS]) :- X < Y + 1, ordenada_aux(Y, YS). 