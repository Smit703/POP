append([],S,S,0) :- !.
append([H|P],S,[H|T],N) :- M is N-1, append(P,S,T,M).

len([],0).
len([_|T], N) :- len(T,M), N is M+1.

merge(L,[],L) :- !.
merge([],L,L) :- !.
merge([H1|T1],[H2|T2],[H1|T3]) :- len(H1,M1), len(H2,M2), M1=<M2 , !, merge(T1,[H2|T2],T3).
merge([H1|T1],[H2|T2],[H2|T3]) :- merge([H1|T1],T2,T3).

partition([],[],[]) :- !.
partition([H],[H],[]) :- !.
partition(L, P, S) :- len(L, N), M is div(N, 2), append(P,S,L,M).

mergesort([],[]) :- !.
mergesort([H],[H]) :- !.
mergesort(L,SL) :- partition(L,X,Y), mergesort(X,Xs), mergesort(Y,Ys), merge(Xs,Ys,SL).

lsort(L,Ans) :- mergesort(L,Ans).