rev_acc([],L,L).
rev_acc([H|T],L,Acc) :- rev_acc(T,L,[H|Acc]).

reverse(L,RevL) :- rev_acc(L,RevL,[]).