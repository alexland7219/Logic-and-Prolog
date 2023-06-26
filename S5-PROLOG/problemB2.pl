main:- EstadoInicial = [0,0,3,3,este], EstadoFinal = [3,3,0,0,oeste],
between(1,1000,CosteMax), % Buscamos soluci ́on de coste 0; si no, de 1, etc.
camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    CosteMax>0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente ), % En B.1 y B.2, CostePaso es 1.
    \+member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
    camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).

ok(M, _) :- M = 0.
ok(M, K) :- M > K - 1.

unPaso(1, [A, B, C, D, oeste], [E, F, G, H, este]) :- % DEL OESTE AL ESTE 
    between(0, 3, E),
    between(0, 3, G),
    G is 3 - E,
    between(0, 3, F),
    between(0, 3, H),
    F is 3 - H,
    ok(E, F),
    ok(G, H),
    M is A - E,
    K is B - F,
    M > -1, K > -1,
    S is M+K,
    between(1, 2, S),
    G is C + M,
    H is D + K.

unPaso(1, [A, B, C, D, este], [E, F, G, H, oeste]) :- % DEL ESTE AL OESTE 
    between(0, 3, E),
    between(0, 3, G),
    G is 3 - E,
    between(0, 3, F),
    between(0, 3, H),
    F is 3 - H,
    ok(E, F),
    ok(G, H),
    M is E - A,
    K is F - B,
    M > -1, K > -1,
    S is M+K,
    between(1, 2, S),
    G is C - M,
    H is D - K.
