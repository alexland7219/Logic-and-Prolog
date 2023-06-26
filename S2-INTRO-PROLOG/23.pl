%% Example:
numbers([2,5,7,-2,2,9,3,4,1]).
maxSum(6).
%% subsetWithRest(L, Subset, Rest) holds
%% if Subset is a subset of L and Rest is the rest of the elements.
subsetWithRest([], [], []).

subsetWithRest([X|XS], [Y|YS], R) :- X = Y, subsetWithRest(XS, YS, R).
subsetWithRest([X|XS], L, [R|RS]) :- X = R, subsetWithRest(XS, L, RS).

%% maxSubset(K, L, Sm) holds
%% if Sm is a subset of numbers of L such that
%% it sums at most K
%% and if we try to add any other element, the sum exceeds K.
maxSubset(K, L, Sm):-
subsetWithRest(L, Sm, Rest), sum_list(Sm, P), P - 1 < K, all_exceed(P, K, Rest).

% Any element from L added to S will exceed K 
all_exceed(_, _, []).
all_exceed(S, K, [X|XS]) :- S + X > K, all_exceed(S, K, XS).

main :-
numbers(L), maxSum(K),
maxSubset(K, L, Sm),
write(Sm), nl, fail.
main:- halt.