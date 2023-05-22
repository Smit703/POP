append([],S,S,0) :- !.
append([H|P],S,[H|T],N) :- M is N-1, append(P,S,T,M).

len([],0).
len([_|T], N) :- len(T,M), N is M+1.

partition([],[],[]) :- !.
partition([H],[H],[]) :- !.
partition(L, P, S) :- len(L, N), M is div(N, 2), append(P,S,L,M).