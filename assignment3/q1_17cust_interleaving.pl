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

%%%%% SECTION: q1_17cust_interleaving_solution
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
customer(c9).
customer(c10).
customer(c11).
customer(c12).
customer(c13).
customer(c14).
customer(c15).
customer(c16).
customer(c17).


%%% Define any helper predicates (except connected which should appear above) here 

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

solve([D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14, D15, D16, D17]) :-
    customer(D1), travel_time(w, D1, T1), CT1 is T1, within_window(D1, CT1),
    customer(D2), not member(D2, [D1]), travel_time(D1, D2, T2), CT2 is T2 + CT1, within_window(D2, CT2),
    customer(D3), not member(D3, [D1, D2]), travel_time(D2, D3, T3), CT3 is T3 + CT2, within_window(D3, CT3),
    customer(D4), not member(D4, [D1, D2, D3]), travel_time(D3, D4, T4), CT4 is T4 + CT3, within_window(D4, CT4),
    customer(D5), not member(D5, [D1, D2, D3, D4]), travel_time(D4, D5, T5), CT5 is T5 + CT4, within_window(D5, CT5),
    customer(D6), not member(D6, [D1, D2, D3, D4, D5]), travel_time(D5, D6, T6), CT6 is T6 + CT5, within_window(D6, CT6),
    customer(D7), not member(D7, [D1, D2, D3, D4, D5, D6]), travel_time(D6, D7, T7), CT7 is T7 + CT6, within_window(D7, CT7),
    customer(D8), not member(D8, [D1, D2, D3, D4, D5, D6, D7]), travel_time(D7, D8, T8), CT8 is T8 + CT7, within_window(D8, CT8),
    customer(D9), not member(D9, [D1, D2, D3, D4, D5, D6, D7, D8]), travel_time(D8, D9, T9), CT9 is T9 + CT8, within_window(D9, CT9),
    customer(D10), not member(D10, [D1, D2, D3, D4, D5, D6, D7, D8, D9]), travel_time(D9, D10, T10), CT10 is T10 + CT9, within_window(D10, CT10),
    customer(D11), not member(D11, [D1, D2, D3, D4, D5, D6, D7, D8, D9, D10]), travel_time(D10, D11, T11), CT11 is T11 + CT10, within_window(D11, CT11),
    customer(D12), not member(D12, [D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11]), travel_time(D11, D12, T12), CT12 is T12 + CT11, within_window(D12, CT12),
    customer(D13), not member(D13, [D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12]), travel_time(D12, D13, T13), CT13 is T13 + CT12, within_window(D13, CT13),
    customer(D14), not member(D14, [D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13]), travel_time(D13, D14, T14), CT14 is T14 + CT13, within_window(D14, CT14),
    customer(D15), not member(D15, [D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14]), travel_time(D14, D15, T15), CT15 is T15 + CT14, within_window(D15, CT15),
    customer(D16), not member(D16, [D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14, D15]), travel_time(D15, D16, T16), CT16 is T16 + CT15, within_window(D16, CT16),
    customer(D17), not member(D17, [D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14, D15, D16]), travel_time(D16, D17, T17), CT17 is T17 + CT16, within_window(D17, CT17).


%%% Define printSolution below. This should take in the list of variables 
%%% after they have been assigned values, and outputs the solution in a
%%% human readable form.
%%% REMEMBER TO LOG YOUR FINAL OUTPUT AND RUNTIME IN assignment3_report.pdf

printSolution(L) :-
    write("The order that the truck must deliver is:"), nl,
    printOrder(L), nl.

%%%%% SECTION: q1_17cust_interleaving_solve_and_print
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