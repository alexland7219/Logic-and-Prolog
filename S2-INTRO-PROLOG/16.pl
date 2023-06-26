% (a) ¿Que significa el predicado p(L,P) para una lista L dada?

% Significa que P es una permutación de L

% (b) Acaba el predicado ok(P):

ok([]) :- !.
ok([f(_, X), f(X, _)]) :- !.
ok([f(_, X) | [f(X, Y) | BS]]) :- ok([f(X,Y)|BS]).  

% (c) Extiende el predicado p para que el programa tambi ́en pueda hacer cadenas girando alguna
% de las fichas de la entrada.

p([],[]).
p(L,[X|P]) :- select(X,L,R), p(R,P).
p(L,[f(X,Y)|P]) :- select(f(Y,X), L, R), p(R, P). 


dom(L) :- p(L,P), ok(P), write(P), nl.
dom( ) :- write('no hay cadena'), nl.

