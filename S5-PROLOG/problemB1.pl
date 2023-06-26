main:- EstadoInicial = [0,0], EstadoFinal = [0,4],
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

unPaso(1, [X, _], [X, 0]). % Vaciar cubos
unPaso(1, [_, X], [0, X]). 
unPaso(1, [X, _], [X, 8]). % Rellenar cubos
unPaso(1, [_, X], [5, X]). 
unPaso(1, [X, Y], [0, B]) :- % del primero al segundo hasta vaciar el primero 
    B is X + Y,
    between(0,8,B).
unPaso(1, [X, Y], [A, 0]) :- % del segundo al primero hasta vaciar el segundo
    A is X + Y,
    between(0,5,A).
unPaso(1, [X, Y], [A, 8]) :- % del primero al segundo hasta llenar el segundo 
    A is X + Y - 8.
unPaso(1, [X, Y], [5, B]) :- % del segundo al primero hasta llenar el primero
    B is X + Y - 5.
    