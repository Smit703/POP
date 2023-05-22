factors(1, [], _) :- !.
factors(N, [H|T], H) :- K is div(N, H), N is K*H,!, factors(K, T, H).
factors(N, T, H) :- M is H + 1, factors(N, T, M).

prime_factors(N, L) :- factors(N,L,2).