of_int(0,0) :- !.
of_int(A,s(B)) :- N is A-1, of_int(N,B).

to_int(0,0) :- !.
to_int(s(A),B) :- to_int(A,N), B is N+1.

sub(A,0,A) :- !.
sub(s(A),s(B),Z) :-sub(A,B,Z).