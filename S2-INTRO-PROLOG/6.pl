% dados(P,N,L) "la lista L expresa una manera de sumar P puntos lanzando N dados."

dados(0, 0, []) :- !.
dados(P, N, [X|XS]) :- P > 0, N > 0, member(X, [1,2,3,4,5,6]), N1 is N - 1, Q is P - X, dados(Q, N1, XS).
