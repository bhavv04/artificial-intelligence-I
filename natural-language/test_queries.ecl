% Test script to run all queries and log output
:- [movie_q_and_a_system].

test_all :-
    write('%%%%%% QUERY 1 OUTPUT'), nl,
    write('% Test: Simple proper noun (movie name)'), nl,
    write('?- what([parasite], X).'), nl,
    what([parasite], X1),
    write('X = '), write(X1), nl, nl,
    
    write('%%%%%% QUERY 2 OUTPUT'), nl,
    write('% Test: Article + common noun (finding all movies)'), nl,
    write('?- what([the, movie], X).'), nl,
    (what([the, movie], X2), write('X = '), write(X2), nl, fail ; true), nl,
    
    write('%%%%%% QUERY 3 OUTPUT'), nl,
    write('% Test: Article + adjective + common noun (horror movies)'), nl,
    write('?- what([a, horror, movie], X).'), nl,
    (what([a, horror, movie], X3), write('X = '), write(X3), nl, fail ; true), nl,
    
    write('%%%%%% QUERY 4 OUTPUT'), nl,
    write('% Test: Noun phrase with prepositional phrase (by director)'), nl,
    write('?- what([the, movie, by, jordan_peele], X).'), nl,
    (what([the, movie, by, jordan_peele], X4), write('X = '), write(X4), nl, fail ; true), nl,
    
    write('%%%%%% QUERY 5 OUTPUT'), nl,
    write('% Test: Noun phrase with prepositional phrase (from year)'), nl,
    write('?- what([a, movie, from, 2022], X).'), nl,
    (what([a, movie, from, 2022], X5), write('X = '), write(X5), nl, fail ; true), nl,
    
    write('%%%%%% QUERY 6 OUTPUT'), nl,
    write('% Test: Multiple adjectives (scifi action movies)'), nl,
    write('?- what([the, scifi, action, movie], X).'), nl,
    (what([the, scifi, action, movie], X6), write('X = '), write(X6), nl, fail ; true), nl,
    
    write('%%%%%% QUERY 7 OUTPUT'), nl,
    write('% Test: Actor with prepositional phrase'), nl,
    write('?- what([the, actor, in, parasite], X).'), nl,
    (what([the, actor, in, parasite], X7), write('X = '), write(X7), nl, fail ; true), nl,
    
    write('%%%%%% QUERY 8 OUTPUT'), nl,
    write('% Test: Movie with actor prepositional phrase'), nl,
    write('?- what([a, movie, with, daniel_kaluuya], X).'), nl,
    (what([a, movie, with, daniel_kaluuya], X8), write('X = '), write(X8), nl, fail ; true), nl,
    
    write('%%%%%% QUERY 9 OUTPUT'), nl,
    write('% Test: Genre director adjective'), nl,
    write('?- what([a, horror, director], X).'), nl,
    (what([a, horror, director], X9), write('X = '), write(X9), nl, fail ; true), nl,
    
    write('%%%%%% QUERY 10 OUTPUT'), nl,
    write('% Test: New director adjective'), nl,
    write('?- what([a, new, director], X).'), nl,
    (what([a, new, director], X10), write('X = '), write(X10), nl, fail ; true), nl.
