% diccionario(A,N) "dado un alfabeto A de s ́ımbolos y un natural N, escriba todas las palabras de N s ́ımbolos, por orden alfabetico"

mydict(A,1,X) :- member(X, A).
mydict(A,N,X) :- N > 1, member(R, A), M is N - 1, mydict(A, M, Q), concat(R, Q, X). 


diccionario(A,N) :- mydict(A,N,X), write(X).