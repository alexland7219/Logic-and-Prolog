solucio(L) :-
    L = [ [1, _, _, _, _, _], [2, _, _, _, _, _], [3, _, _, _, _, _], [4, _, _, _, _, _], [5, _, _, _, _, _] ],
    % [numcasa, color, oficio, animal, bebida, pais]
    member([_, _, _, gato, _, _], L),
    member([_, _, _, _, vino, _], L),
    member([_, roja, _, _, _, peru], L),
    member([_, _, _, perro, _, francia], L),
    member([_, _, pintor, _, _, japon], L),
    member([_, _, _, _, ron, china], L),
    member([1, _, _, _, _, hungria], L),
    member([_, verde, _, _, cognac, _], L),
    verde_izq_blanca(L),
    member([_ ,_, escultor, caracoles, _, _], L),
    member([_, amarilla, actor, _, _, _], L),
    member([3, _, _, _, cava, _], L),
    lado_actor_caballo(L),
    hungaro_lado_azul(L),
    member([_, _, notario, _, whisky, _], L),
    lado_medico_ardilla(L), !.

verde_izq_blanca(L) :-
    member([X, verde, _, _, _, _], L),
    Y is X + 1,
    member([Y, blanca, _, _, _, _], L).

lado_actor_caballo(L) :- 
    member([X, _, actor, _, _, _], L),
    Y is X + 1,
    member([Y, _, _, caballo, _, _], L).

lado_actor_caballo(L) :- 
    member([X, _, actor, _, _, _], L),
    Y is X - 1,
    member([Y, _, _, caballo, _, _], L).

hungaro_lado_azul(L) :- 
    member([X, azul, _, _, _, _], L),
    Y is X + 1,
    member([Y, _, _, _, _, hungria], L).

hungaro_lado_azul(L) :- 
    member([X, azul, _, _, _, _], L),
    Y is X - 1,
    member([Y, _, _, _, _, hungria], L).

lado_medico_ardilla(L) :- 
    member([X, _, medico, _, _, _], L),
    Y is X + 1,
    member([Y, _, _, ardilla, _, _], L).

lado_medico_ardilla(L) :- 
    member([X, _, medico, _, _, _], L),
    Y is X - 1,
    member([Y, _, _, ardilla, _, _], L).
