% Enter the names of ID of your group members below.
% For STUDENT ID, use your 9-digit ONECARD number.
% If you have 2 group members, leave the last entry blank.
%
%%%%%
%%%%% NAME: Parsa Kermani Pour
%%%%% STUDENT ID: 501183294
%%%%%
%%%%% NAME: Bhavdeep Arora
%%%%% STUDENT ID: 501152698
%%%%%
%%%%% NAME: Arshia Sharifi
%%%%% STUDENT ID: 501158323
%
% Add the required statements in the q4a_rules section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%

%%%%% SECTION: q1_8cust_gen_and_test_solution
%%%%% Put the different components of your delivery truck solution below

%%% Put the KB you need for this problem (not including variable domains here).
:- [q1_kb].


%%% Put the domains for your variables below
customer(c1).
customer(c2).
customer(c3).
customer(c4).
customer(c5).
customer(c6).
customer(c7).
customer(c8).


%%% Define any helper predicates (except connected which should appear above) here 

% Checks that all elements in the list are different
allDiff([]).
allDiff([H | T]) :- not member(H, T), allDiff(T).

% Checks that Time is within the customer's delivery window
within_window(Cust, Time) :- window(Cust, Start, End), Time >= Start, Time < End.

% Used for printing the output. 
% Prints the customers in a list with arrows to indiciate delivery order
printOrder([H]) :- write(H).
printOrder([H | T]) :- not T = [], write(H), write(" -> "), printOrder(T).

%%% Define solve below. Remember that solve should take in the list of
%%% variables to assign. MAKE SURE TO BRIEFLY EXPLAIN THE MEANING OF
%%% YOUR VARIABLES IN A COMMENT

% DOCUMENTATION
% Our KB defines 2 groups of predicates:
%   
%   1. travel_time(Customer1, Customer2, Time)
%   given 2 customers, Time will be set to the time it takes to travel between them in minutes
%
%   2. window(Cutomer, Time1, Time2)
%   this is used in the within_window helper predicate to check if a certain time is within
%   the customer's delivery window. It will check that the time is >=Time1 and <Time2
%
% EXPLANATION OF VARIABLES
% D1 to D8 represent the delivery order that the delivery truck will take. With D1 being
% the first delivery, D2 being the second delivery, etc..
% They will each be set to one of the cutomers c1-c8 and the result will determine the order
% to deliver to the customers


solve([D1, D2, D3, D4, D5, D6, D7, D8]) :-
    customer(D1), customer(D2), customer(D3), customer(D4),
    customer(D5), customer(D6), customer(D7), customer(D8),
    allDiff([D1, D2, D3, D4, D5, D6, D7, D8]),
    travel_time(w, D1, T1), CT1 is T1, within_window(D1, CT1),
    travel_time(D1, D2, T2), CT2 is T2 + CT1, within_window(D2, CT2),
    travel_time(D2, D3, T3), CT3 is T3 + CT2, within_window(D3, CT3),
    travel_time(D3, D4, T4), CT4 is T4 + CT3, within_window(D4, CT4),
    travel_time(D4, D5, T5), CT5 is T5 + CT4, within_window(D5, CT5),
    travel_time(D5, D6, T6), CT6 is T6 + CT5, within_window(D6, CT6),
    travel_time(D6, D7, T7), CT7 is T7 + CT6, within_window(D7, CT7),
    travel_time(D7, D8, T8), CT8 is T8 + CT7, within_window(D8, CT8).


%%% Define printSolution below. This should take in the list of variables 
%%% after they have been assigned values, and outputs the solution in a
%%% human readable form.
%%% REMEMBER TO LOG YOUR FINAL OUTPUT AND RUNTIME IN assignment3_report.pdf
printSolution(L) :-
    write("The order that the truck must deliver is:"), nl,
    printOrder(L), nl.


%%%%% SECTION: q1_8cust_gen_and_test_solve_and_print
%%%%% The following calls the solve predicate, passes the variables to
%%%%% printSolution and outputs the time needed to solve the problem.
%%%%% This is the main way we will interact with your program.
%%%%% You can test it however you want though.
%%%%% DO NOT EDIT.

solveAndPrint :- Start is cputime, solve(L), End is cputime, Time is End-Start,
    write("The problem was solved in "), write(Time), write(" seconds"), nl, nl,
    printSolution(L).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW