main:- EstadoInicial = [[alex, bob, charlie, dave], [], izq], EstadoFinal = [[], [alex, bob, charlie, dave], der],
between(1,1000,CosteMax), % Buscamos soluci ́on de coste 0; si no, de 1, etc.
camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino(0, [A, B, X], [P, Q, X], C, C) :- permutation(A, P), permutation(B, Q). % Permutacion del estado
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    CosteMax>0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente ), % En B.1 y B.2, CostePaso es 1.
    \+member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
    camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).

tiempo(alex, 1).
tiempo(bob, 2).
tiempo(charlie, 5).
tiempo(dave, 8).


unPaso(I, [Z, D, izq], [ZP, DP, der]) :- % De izquierda a derecha, solo cruza uno 
    select(P, Z, ZP),
    tiempo(P, I),
    union(D, [P], DP).

unPaso(I, [Z, D, der], [ZP, DP, izq]) :- % De derecha a izquierda, solo cruza uno 
    select(P, D, DP),
    tiempo(P, I),
    union(Z, [P], ZP).

unPaso(I, [Z, D, izq], [ZP, DP, der]) :- % De izquierda a derecha, cruzan dos
    select(P, Z, Resta),
    select(Q, Resta, ZP),
    tiempo(P, IP),
    tiempo(Q, IQ),
    I is max(IP, IQ),
    union(D, [P, Q], DP).

unPaso(I, [Z, D, izq], [ZP, DP, der]) :- % De derecha a izquierda, cruzan dos
    select(P, D, Resta),
    select(Q, Resta, DP),
    tiempo(P, IP),
    tiempo(Q, IQ),
    I is max(IP, IQ),
    union(Z, [P, Q], ZP).


