% EXERCICI 1
%
% Escribe un predicado "prod(L,P)" que signifique:
% "P es el producto de los elementos de la lista de enteros L"

prod([], 1) :- !.
prod([X|L], P) :- prod(L, Q), P is Q*X.