log(B,N,L) :- between(0, N, L), B**L < N, L1 is L + 1, B**L1  > N.
log(B,N,L) :- between(0, N, L), B**L is N, L1 is L+1, B**L1 > N.