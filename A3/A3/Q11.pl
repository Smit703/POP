my_append([],Q,Q).
my_append([H | P], Q, [H | R]) :- my_append(P, Q, R).

my_flatten([],[]) :- !.
my_flatten(A,[A]) :- not(is_list(A)).
my_flatten([H|T],Ans) :- my_flatten(H,B), my_flatten(T,C), my_append(B,C,Ans).