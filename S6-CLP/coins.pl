:- use_module(library(clpfd)).

ejemplo(0,   26, [1,2,5,10] ).  % Solution: [1,0,1,2]
ejemplo(1,  361, [1,2,5,13,17,35,157]).

main:- 
    ejemplo(1,Amount,Coins),
    nl, write('Paying amount '), write(Amount), write(' using the minimal number of coins of values '), write(Coins), nl,nl,
    length(Coins,N), 
    length(Vars,N), % get list of N prolog vars    
%1.Dominio
    Vars ins 0..Amount,
%2.Constraints
    expr( Vars, Coins, Expr),
    Expr #= Amount,
    exprSuma(Vars, ExprSuma),
%3. labeling
    labeling( [min(ExprSuma)], Vars),

    nl, write(Vars), nl,nl, halt.


expr([], [], 0).
expr([X|Vars], [K|Coins], X * K + Expr) :- expr(Vars, Coins, Expr).

exprSuma([], 0).
exprSuma([X|Vars], X + Expr) :- exprSuma(Vars, Expr).