:- [q1_kb].


customer(c1).
customer(c2).
customer(c3).
customer(c4).
customer(c5).
customer(c6).
customer(c7).
customer(c8).
customer(c9).


within_window(Cust, Time) :- window(Cust, Start, End), Time >= Start, Time < End.

printOrder([H]) :- write(H).
printOrder([H | T]) :- not T = [], write(H), write(" -> "), printOrder(T).



solve([D1, D2, D3, D4, D5, D6, D7, D8, D9]) :-
    customer(D1), travel_time(w, D1, T1), CT1 is T1, within_window(D1, CT1),
    customer(D2), not member(D2, [D1]), travel_time(D1, D2, T2), CT2 is T2 + CT1, within_window(D2, CT2),
    customer(D3), not member(D3, [D1, D2]), travel_time(D2, D3, T3), CT3 is T3 + CT2, within_window(D3, CT3),
    customer(D4), not member(D4, [D1, D2, D3]), travel_time(D3, D4, T4), CT4 is T4 + CT3, within_window(D4, CT4),
    customer(D5), not member(D5, [D1, D2, D3, D4]), travel_time(D4, D5, T5), CT5 is T5 + CT4, within_window(D5, CT5),
    customer(D6), not member(D6, [D1, D2, D3, D4, D5]), travel_time(D5, D6, T6), CT6 is T6 + CT5, within_window(D6, CT6),
    customer(D7), not member(D7, [D1, D2, D3, D4, D5, D6]), travel_time(D6, D7, T7), CT7 is T7 + CT6, within_window(D7, CT7),
    customer(D8), not member(D8, [D1, D2, D3, D4, D5, D6, D7]), travel_time(D7, D8, T8), CT8 is T8 + CT7, within_window(D8, CT8),
    customer(D9), not member(D9, [D1, D2, D3, D4, D5, D6, D7, D8]), travel_time(D8, D9, T9), CT9 is T9 + CT8, within_window(D9, CT9).


printSolution(L) :-
    write("The order that the truck must deliver is:"), nl,
    printOrder(L), nl.


solveAndPrint :- Start is cputime, solve(L), End is cputime, Time is End-Start,
    write("The problem was solved in "), write(Time), write(" seconds"), nl, nl,
    printSolution(L).
