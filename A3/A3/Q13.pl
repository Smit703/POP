combine(H,[],[],[H]) :- !.
combine(A,[H|T],Z,[A]) :- A\=H, !, Z = [H|T].
combine(H,[H|T],A,[H|B]) :- combine(H,T,A,B), !.

len([],0).
len([_|T], N) :- len(T,M), N is M+1.

pack([],[]) :- !.
pack([H|T],[HA|TA]) :- combine(H,T,B,HA), pack(B,TA), !.

count([],[]) :- !.
count([[H|T]|Ts],[A|Z]) :- len([H|T],N), A = [N,H], count(Ts,Z).

encode(L,Ans) :- pack(L,LT), count(LT,Ans).