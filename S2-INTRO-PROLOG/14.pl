%     S E N D 
%   + M O R E 
%   M O N E Y 

% "returns the first or second number"
sum4(A, B, C, D, K) :- K is 1000*A + 100*B + 10*C + D.

% "returns the last number"
sum5(A, B, C, D, E, K) :- K is 10000*A + 1000*B + 100*C + 10*D + E.

% Generates permutations of (S,E,N,D,M,O,R,Y) (distinct digits) and checks that the sum is correct. 
main(S,E,N,D,M,O,R,Y) :- permutation(L, [0,1,2,3,4,5,6,7,8,9]), L = [_, _, S,E,N,D,M,O,R,Y], sum4(S,E,N,D,N1), sum4(M,O,R,E,N2), T is N1+N2, sum5(M,O,N,E,Y,T).