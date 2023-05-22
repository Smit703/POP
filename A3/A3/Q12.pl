combine(H,[],[],[H]) :- !.
combine(A,[H|T],Z,[A]) :- A\=H, !, Z = [H|T].
combine(H,[H|T],A,[H|B]) :- combine(H,T,A,B), !.

pack([],[]) :- !.
pack([H|T],[HA|TA]) :- combine(H,T,B,HA), pack(B,TA), !.