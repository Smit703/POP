plus(A,s(0),s(A)) :- !.
plus(A,0,A) :- !.
plus(A,s(B),s(Ans)) :- plus(A,B,Ans).