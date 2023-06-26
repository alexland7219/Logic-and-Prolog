is_list([]).
is_list([X|XS]) :- atom(X), is_list(XS).

drop([], L, L).
drop([X|XS], [X|YS], R) :- drop(XS, YS, R).

flatten(X, [X]) :- atom(X), !.
flatten(X, X) :- is_list(X), !.
flatten([X|XS], F) :- flatten(XS, NEWF), flatten(X, Y), drop(Y, F, NEWF), is_list(F).