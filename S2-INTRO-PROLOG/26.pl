% allSSSS(L) (allSquareSummingSubSequences) ===
% "Given a sequence of positive integers L, write all non-empty subsequences of L
% whose sum is a perfect square, in the following format":
% ?- allSSSS([6,3,4,5,6,9,8,5,2,3,4]).
% 9-[6,3]
% 49-[3,4,5,6,9,8,5,2,3,4]
% 4-[4]
% 9-[4,5]
% 9-[9]
% 9-[2,3,4]
% 4-[4]

subsecuencia([_|XS], L) :- subsecuencia(XS, L).
subsecuencia(X, L) :- subsecuencia2(X, L).

subsecuencia2([X|XS], [L|LS]) :- L = X, subsecuencia3(XS, LS).

subsecuencia3(_, []).
subsecuencia3([X|XS], [L|LS]) :- L = X, subsecuencia3(XS, LS).

allSSSS(L):- subsecuencia(L, SS), sum_list(SS, Sum), isperfect(Sum), write(Sum-SS).

isperfect(K) :- between(1, K, T), M is T**2, M = K.

