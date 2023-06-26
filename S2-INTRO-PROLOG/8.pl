% suma ants(L) = " existe algun x de L tal que es igual a la suma de los anteriores a él."

suma_aux(X, [X|_]) :- !.
suma_aux(X, [Y|L]) :- K is Y + X, suma_aux(K, L).

suma_ants(L) :- suma_aux(0, L).
