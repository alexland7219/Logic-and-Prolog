:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

%Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
word( [w,r,a,p] ).

num(X,N):- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).

main:-
    maplist(same_length([_, _, _, _, _, _]), [D1, D2, D3, D4]),
    append([D1, D2, D3, D4], D),
    D ins 1..24,
    all_distinct(D),
    findall(I-J, (word(W), member(I, W), member(J, W), I \= J, num(I, N), num(J, M), N < M), Pairs),
    genConstraints(D1, Pairs),
    genConstraints(D2, Pairs),
    genConstraints(D3, Pairs),
    genConstraints(D4, Pairs),
    sorted(D1),
    sorted(D2),
    sorted(D3),
    sorted(D4),
    labeling([min], D),
    writeN(D1), 
    writeN(D2), 
    writeN(D3), 
    writeN(D4), halt.
    
writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.

sorted([_]).
sorted([A,B|C]) :- A #=< B, sorted([B|C]).

genConstraints(_, []).
genConstraints(D, [P|Pairs]) :- writeConstraints(D, P), genConstraints(D, Pairs). 

writeConstraints([], _).
writeConstraints([F|Faces], I-J) :- writeSecondConstraints(F, Faces, I-J), writeConstraints(Faces, I-J).

writeSecondConstraints(_, [], _).
writeSecondConstraints(F, [F2|Faces], I-J) :- num(I, N), num(J, M), N#\= F #\/ M#\= F2, N #\= F2 #\/ M #\= F, writeSecondConstraints(F, Faces, I-J).