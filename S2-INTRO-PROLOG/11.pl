% ord(L1,L2) "L2 es la lista de enteros L1 ordenada de menor a mayor (creciente)"

esta_ordenada([]) :- !.
esta_ordenada([X|XS]) :- ordenada_aux(X, XS).

ordenada_aux(_, []) :- !.
ordenada_aux(X,[Y|YS]) :- X < Y + 1, ordenada_aux(Y, YS). 

ord(L1, L2) :- permutation(L1, L2), esta_ordenada(L2).