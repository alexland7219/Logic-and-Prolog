% 22. Supongamos que N estudiantes (identificados por un n ́umero entre 1 y N) se quieren matricular
% de LI, pero s ́olo hay espacio para M, con M < N. Adem ́as nos dan una lista L de pares de estos
% estudiantes que son incompatibles entre s ́ı (por ejemplo, porque siempre se copian). Queremos
% obtener un programa Prolog li(N,M,L,S) que, para N, M y L dados, genere un subconjunto S
% con M de los N estudiantes tal que si [x, y] in L entonces {x, y} not in S. Por ejemplo, una soluci ́on de
% li( 20, 16, [[8,11],[8,15],[11,6],[4,9],[18,13],[7,9],[16,8],[18,10],[6,17],[8,20]], S )
% es [20,19,17,16,15,14,13,12,11,10,7,5,4,3,2,1] .
% Escribe una versi ́on lo m ́as sencilla que puedas, aunque sea ineficiente, del estilo “generar una
% soluci ́on (total) y despu ́es comprobar si es correcta”.

genlist(X, X, [X]).
genlist(L, U, [X|XS]) :- U > L, X is L, L1 is L+1, genlist(L1, U, XS).  

li(N, M, L, S) :- genlist(1, N, P), subconjunto(S, P, M), ok(S, L), write(S).

ok(_, []).
ok(S, [[A, _] | REST]) :- not(member(A, S)), ok(S, REST).
ok(S, [[_, B] | REST]) :- not(member(B, S)), ok(S, REST).

subconjunto([], _, 0).
subconjunto([X|XS], [Y|YS], M) :- X = Y, M1 is M - 1, subconjunto(XS, YS, M1).
subconjunto(XS, [_|YS], M) :- subconjunto(XS, YS, M).

