
programa(P) :- append([begin|X], [end], P), instrucciones(X).

instrucciones(X) :- append(A, [;|Rest], X), not(member(;, A)), instruccion(A), instrucciones(Rest), !.
instrucciones(X) :- instruccion(X).

instruccion([A, =, B, +, C]) :- variable(A), variable(B), variable(C), !.
instruccion([if|X]) :- append([U], [=|A], X), variable(U), append([V], [then|B], A), variable(V),
                       append(I1, [else|C], B), instrucciones(I1), append(I2, [endif], C), instrucciones(I2), !.

variable(x) :- !.
variable(y) :- !.
variable(z).