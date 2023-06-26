% card(L) "Escribe la lista que, para cada elemento de L, dice cuántas veces aparece éste en L."

% count(LIST, ELEMENT, INT) "how many times an element appears in a list"
count([], _, 0) :- !.
count([X|XS], L, Y) :- not(L is X), count(XS, L, Y).
count([X|XS], L, Y) :- L is X, count(XS, L, M), Y is M + 1.

% remove(LIST, ELEMENT, LIST) "resulting list from deleting all instances of an element"
remove([], _, []) :- !.
remove([X|XS], K, [Y|YS]) :- X is K, remove(XS, K, [Y|YS]).
remove([X|XS], K, [Y|YS]) :- not(X is K), Y is X, remove(XS, K, YS).

% mycard(LIST, LIST) "auxiliary predicate for card(L). Generates the resulting list."
mycard([], []) :- !.
mycard([X|XS], [[A, B]|YS]) :- count([X|XS], X, K), A is X, B is K, remove(XS, X, P), mycard(P, YS).


card(L) :- mycard(L, R), write(R).