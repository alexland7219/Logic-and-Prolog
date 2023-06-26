% EXERCICI 1
%
% Escribe un predicado "pescalar(L1, L2 ,P)" que signifique:
% "P es el producto escalar de los vectores L1 y L2"

pescalar([], [], 0) :- !.
pescalar([X|XS], [Y|YS], P) :- pescalar(XS, YS, K), P is K + X*Y.