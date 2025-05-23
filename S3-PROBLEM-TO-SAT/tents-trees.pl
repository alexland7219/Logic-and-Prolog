
symbolicOutput(0).  % set to 1 for DEBUGGING: to see symbolic output only; 0 otherwise.

% INPUT
gridSize(9).
colQuant([2, 1, 2, 1, 3, 1, 3, 0, 3]).
rowQuant([3, 2, 2, 0, 4, 1, 0, 2, 2]).

tree(1, 4).
tree(1, 6).
tree(1, 8).

tree(2, 2).
tree(2, 4).

tree(3, 6).

tree(4, 1).
tree(4, 3).
tree(4, 5).

tree(5, 6).
tree(6, 9).
tree(7, 5).

tree(8, 1).
tree(8, 4).
tree(8, 9).

tree(9, 6).
% DEFINITIONS

coord(I):- gridSize(N), between(1,N,I).

% Tests if (I, J) and (A, B) are orthogonally adjacent
orthoAdjacent(I, J, A, B) :- coord(I), coord(J), coord(A), coord(B), 
                             AM is A - 1, AP is A + 1, between(AM, AP, I), B is J, 
                             ( I \= A ; J \= B ).

orthoAdjacent(I, J, A, B) :- coord(I), coord(J), coord(A), coord(B), 
                             BM is B - 1, BP is B + 1, between(BM, BP, J), A is I, 
                             ( I \= A ; J \= B ).

% Test if (I, J) and (A, B) are adjacent (incl. diagonally -- king move)
adjacent(I, J, A, B) :- coord(I), coord(J), coord(A), coord(B), 
                        AM is A - 1, AP is A + 1, between(AM, AP, I), 
                        BM is B - 1, BP is B + 1, between(BM, BP, J), 
                        ( I \= A ; J \= B ).

% SAT VARIABLES

% tent(I, J) means "square (i, j) contains a tent"
satVariable( tent(I, J) ):- coord(I), coord(J).

% desig(I, J, A, B) means "designated tent of tree (I, J) is (A, B)"
satVariable( desig(I, J, A, B) ):- tree(I, J), coord(A), coord(B).

% CLAUSE GENERATION

writeClauses :- 
    matchColumnReq,
    matchRowReq,
    cannotOccupyTree,
    eachTreeOneTent,
    linkDesigAndTents,
    eachTentOneAssign,
    tentsCannotTouch,
    true,!.
writeClauses :- told, nl, write('writeClauses failed!'), nl,nl, halt.

matchColumnReq :- colQuant(Cols), nth1(J, Cols, K), findall( tent(I, J), coord(I), Lits), exactly(K, Lits), fail.
matchColumnReq.

matchRowReq :- rowQuant(Rows), nth1(I, Rows, K), findall( tent(I, J), coord(J), Lits), exactly(K, Lits), fail.
matchRowReq.

cannotOccupyTree :- tree(I, J), writeOneClause([ -tent(I, J) ]), fail.
cannotOccupyTree.

eachTreeOneTent :- tree(I, J), findall(desig(I, J, A, B), orthoAdjacent(I, J, A, B), Lits), exactly(1, Lits), fail.
eachTreeOneTent.

linkDesigAndTents :- tree(I, J), orthoAdjacent(I, J, A, B), writeOneClause([ -desig(I, J, A, B), tent(A, B)]), fail.
linkDesigAndTents.

eachTentOneAssign :- coord(A), coord(B), findall(desig(I, J, A, B), tree(I, J), Lits), exactly(1, Lits), fail.
eachTentOneAssign.

tentsCannotTouch :- coord(I), coord(J), adjacent(I, J, A, B), writeOneClause([ -tent(I, J), -tent(A, B)]), fail.
tentsCannotTouch.

% DISPLAY SOLUTION

displaySol(M) :- nl, write(' '), drawHeader, nl, coord(I), drawRow(M, I), fail.
displaySol(_).

drawHeader :- colQuant(C), member(X, C), write(X), write(' '), fail.
drawHeader.

drawRow(M, I) :- rowQuant(R), nth1(I, R, X), write(X), coord(J), displaySquare(I, J, M), fail.
drawRow(_, _) :- nl.

displaySquare(I, J, M) :- member(tent(I, J), M), write('T '), !.
displaySquare(I, J, _) :- tree(I, J), write('B '), !.
displaySquare(_, _, _) :- write('  '), fail.

%%%%%%% Cardinality constraints on arbitrary sets of literals Lits: ===========================

exactly(K,Lits):- symbolicOutput(1), write( exactly(K,Lits) ), nl, !.
exactly(K,Lits):- atLeast(K,Lits), atMost(K,Lits),!.

atMost(K,Lits):- symbolicOutput(1), write( atMost(K,Lits) ), nl, !.
atMost(K,Lits):-   % l1+...+ln <= k:  in all subsets of size k+1, at least one is false:
      negateAll(Lits,NLits),
      K1 is K+1,    subsetOfSize(K1,NLits,Clause), writeOneClause(Clause),fail.
atMost(_,_).

atLeast(K,Lits):- symbolicOutput(1), write( atLeast(K,Lits) ), nl, !.
atLeast(K,Lits):-  % l1+...+ln >= k: in all subsets of size n-k+1, at least one is true:
      length(Lits,N),
      K1 is N-K+1,  subsetOfSize(K1, Lits,Clause), writeOneClause(Clause),fail.
atLeast(_,_).

negateAll( [], [] ).
negateAll( [Lit|Lits], [NLit|NLits] ):- negate(Lit,NLit), negateAll( Lits, NLits ),!.

negate( -Var,  Var):-!.
negate(  Var, -Var):-!.

subsetOfSize(0,_,[]):-!.
subsetOfSize(N,[X|L],[X|S]):- N1 is N-1, length(L,Leng), Leng>=N1, subsetOfSize(N1,L,S).
subsetOfSize(N,[_|L],   S ):-            length(L,Leng), Leng>=N,  subsetOfSize( N,L,S).


%%%%%%% Express equivalence between a variable and a disjunction or conjunction of literals ===

% Express that Var is equivalent to the disjunction of Lits:
expressOr( Var, Lits ):- symbolicOutput(1), write( Var ), write(' <--> or('), write(Lits), write(')'), nl, !.
expressOr( Var, Lits ):- member(Lit,Lits), negate(Lit,NLit), writeOneClause([ NLit, Var ]), fail.
expressOr( Var, Lits ):- negate(Var,NVar), writeOneClause([ NVar | Lits ]),!.

%% expressOr(a,[x,y]) generates 3 clauses
%% a == x v y
%% x -> a       -x v a
%% y -> a       -y v a
%% a -> x v y   -a v x v y

% Express that Var is equivalent to the conjunction of Lits:
expressAnd( Var, Lits) :- symbolicOutput(1), write( Var ), write(' <--> and('), write(Lits), write(')'), nl, !.
expressAnd( Var, Lits):- member(Lit,Lits), negate(Var,NVar), writeOneClause([ NVar, Lit ]), fail.
expressAnd( Var, Lits):- findall(NLit, (member(Lit,Lits), negate(Lit,NLit)), NLits), writeOneClause([ Var | NLits]), !.


%%%%%%% main: =================================================================================

main:-  symbolicOutput(1), !, writeClauses, halt.   % print the clauses in symbolic form and halt Prolog
main:-  initClauseGeneration,
        tell(clauses), writeClauses, told,          % generate the (numeric) SAT clauses and call the solver
        tell(header),  writeHeader,  told,
        numVars(N), numClauses(C),
        write('Generated '), write(C), write(' clauses over '), write(N), write(' variables. '),nl,
        shell('cat header clauses > infile.cnf',_),
        write('Calling solver....'), nl,
        shell('kissat -v infile.cnf > model', Result),  % if sat: Result=10; if unsat: Result=20.
        treatResult(Result),!.

treatResult(20):- write('Unsatisfiable'), nl, halt.
treatResult(10):- write('Solution found: '), nl, see(model), symbolicModel(M), seen, displaySol(M), nl,nl,halt.
treatResult( _):- write('cnf input error. Wrote anything strange in your cnf?'), nl,nl, halt.


initClauseGeneration:-  %initialize all info about variables and clauses:
        retractall(numClauses(   _)),
        retractall(numVars(      _)),
        retractall(varNumber(_,_,_)),
        assert(numClauses( 0 )),
        assert(numVars(    0 )),     !.

writeOneClause([]):- symbolicOutput(1),!, nl.
writeOneClause([]):- countClause, write(0), nl.
writeOneClause([Lit|C]):- w(Lit), writeOneClause(C),!.
w(-Var):- symbolicOutput(1), satVariable(Var), write(-Var), write(' '),!.
w( Var):- symbolicOutput(1), satVariable(Var), write( Var), write(' '),!.
w(-Var):- satVariable(Var),  var2num(Var,N),   write(-), write(N), write(' '),!.
w( Var):- satVariable(Var),  var2num(Var,N),             write(N), write(' '),!.
w( Lit):- told, write('ERROR: generating clause with undeclared variable in literal '), write(Lit), nl,nl, halt.


% given the symbolic variable V, find its variable number N in the SAT solver:
:-dynamic(varNumber / 3).
var2num(V,N):- hash_term(V,Key), existsOrCreate(V,Key,N),!.
existsOrCreate(V,Key,N):- varNumber(Key,V,N),!.                            % V already existed with num N
existsOrCreate(V,Key,N):- newVarNumber(N), assert(varNumber(Key,V,N)), !.  % otherwise, introduce new N for V

writeHeader:- numVars(N),numClauses(C), write('p cnf '),write(N), write(' '),write(C),nl.

countClause:-     retract( numClauses(N0) ), N is N0+1, assert( numClauses(N) ),!.
newVarNumber(N):- retract( numVars(   N0) ), N is N0+1, assert(    numVars(N) ),!.

% Getting the symbolic model M from the output file:
symbolicModel(M):- get_code(Char), readWord(Char,W), symbolicModel(M1), addIfPositiveInt(W,M1,M),!.
symbolicModel([]).
addIfPositiveInt(W,L,[Var|L]):- W = [C|_], between(48,57,C), number_codes(N,W), N>0, varNumber(_,Var,N),!.
addIfPositiveInt(_,L,L).
readWord( 99,W):- repeat, get_code(Ch), member(Ch,[-1,10]), !, get_code(Ch1), readWord(Ch1,W),!. % skip line starting w/ c
readWord(115,W):- repeat, get_code(Ch), member(Ch,[-1,10]), !, get_code(Ch1), readWord(Ch1,W),!. % skip line starting w/ s
readWord(-1,_):-!, fail. %end of file
readWord(C,[]):- member(C,[10,32]), !. % newline or white space marks end of word
readWord(Char,[Char|W]):- get_code(Char1), readWord(Char1,W), !.

%%%%%%% =======================================================================================
