maq(L, C, M) :- between(0, C, NC), maq2(L, C, M, NC), !. % Buscarà des del 0 fins al C per al valor minim de NC

maq2([], 0, [], 0) :- !.
maq2([L|LS], C, [M|MS], NC) :- between(0, NC, M), NEWnc is NC - M, NEWchange is C - M*L, maq2(LS, NEWchange, MS, NEWnc). 