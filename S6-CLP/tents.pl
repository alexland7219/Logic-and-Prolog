% A matrix which contains zeroes and ones gets "x-rayed" vertically and
% horizontally, giving the total number of ones in each row and column.
% The problem is to reconstruct the contents of the matrix from this
% information. Sample run:
%
%	?- p.
%	    0 0 7 1 6 3 4 5 2 7 0 0
%	 0                         
%	 0                         
%	 8      * * * * * * * *    
%	 2      *             *    
%	 6      *   * * * *   *    
%	 4      *   *     *   *    
%	 5      *   *   * *   *    
%	 3      *   *         *    
%	 7      *   * * * * * *    
%	 0                         
%	 0                         
%	

:- use_module(library(clpfd)).

ejemplo1( [0,0,8,2,6,4,5,3,7,0,0], [0,0,7,1,6,3,4,5,2,7,0,0] ).
ejemplo2( [10,4,8,5,6], [5,3,4,0,5,0,5,2,2,0,1,5,1] ).
ejemplo3( [11,5,4], [3,2,3,1,1,1,1,2,3,2,1] ).
ejemplo4( [2, 1, 1, 0, 2, 2, 1], [2, 1, 2, 1, 1, 1, 1], [2, 2 ,2, 4, 5, 6, 7, 8, 8], [2, 3, 3, 3, 5, 5, 6, 6, 8]).


p:-	ejemplo4(RowSums, ColSums, TreeRows, TreeCols),
	length(RowSums, NumRows),
	NR is NumRows + 2,
	length(ColSums, NumCols),
	NC is NumCols + 2,
	NVars is NR*NC,
	length(L,NVars), 
	append( [0|RowSums], [0], RS),
	append( [0|ColSums], [0], CS),
	print(RS), nl,
	print(L), nl,
%1. Domain
	L ins 0..1,
	matrixByRows(L,NC,MatrixByRows),
	print(MatrixByRows),
	transpose(MatrixByRows, MatrixByCols),
%2. Constraints
	equalsSums(MatrixByRows, RowSums),
	equalsSums(MatrixByCols, ColSums),
	everyTreeOneNeighbour(TreeRows, TreeCols, MatrixByRows, MatrixByCols),
%3. labeling
	label(L),
	pretty_print(RowSums,ColSums,MatrixByRows).


pretty_print(_,ColSums,_):- write('     '), member(S,ColSums), writef('%2r ',[S]), fail.
pretty_print(RowSums,_,M):- nl,nth1(N,M,Row), nth1(N,RowSums,S), nl, writef('%3r   ',[S]), member(B,Row), wbit(B), fail.
pretty_print(_,_,_):- nl.
wbit(1):- write('*  '),!.
wbit(0):- write('   '),!.
    
everyTreeOneNeighbour([], [], _, _).
everyTreeOneNeighbour( [R|OtherR], [C|OtherC], MR, MC ) :-
	codifyTree(R, C, MR, MC),
	everyTreeOneNeighbour( OtherR, OtherC, MR, MC).

codifyTree(R, C, MR, MC) :-
	nth1(R, MR, X),
	nth1(C, X, V),
	V #= 0,
	RM is R - 1,
	RP is R + 1,
	CM is C - 1,
	CP is C + 1,
	nth1( RM, MR, A),
	nth1( C, A, B),  % B
	nth1( R, MR, D),
	nth1( CM, D, E), % E
	nth1( CP, D, F), % F
	nth1( RP, MR, G),
	nth1( C, G, KK), % KK
	B #= 1 #\/ E #= 1 #\/ F #= 1 #\/ KK #= 1.

matrixByRows([], _, []).
matrixByRows(L, N, [R|RS]) :- 
	append(R, L1, L),
	length(R, N),
	matrixByRows(L1, N, RS).

equalsSums([], []) :- !.
equalsSums([R|RS], [S|SS]) :-
	exprSuma(R, Expr),
	Expr #= S,
	equalsSums(RS, SS).

exprSuma([], 0) :- !.
exprSuma([X|XS], X + Expr) :- exprSuma(XS, Expr).
