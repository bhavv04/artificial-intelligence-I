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

%%%%% SECTION: q2_link_kb
%%%%% DO NOT EDIT.
link(6,5). link(5,6). 
link(5,3). link(3,5). 
link(3,4). link(4,3). 
link(2,3). link(3,2). 
link(2,1). link(1,2). 
link(1,out). link(out,1). 


%%%%% SECTION: q2_connected
%%%%% Put your definition of connected(Origin, Destination, Path) below
connected(Origin, Destination, Path) :-
    connectedHelper(Origin, Destination, [Origin], Path).

%%%%% SECTION: q2_network_solution
%%%%% Put the different components of your network puzzle solution below

%%% Put the domains for your variables below
computer(1).
computer(2).
computer(3).
computer(4).
computer(5).
computer(6).


%%% Define any helper predicates (except connected which should appear above) here 

% Checks that all elements in the list are different
allDiff([]).
allDiff([H | T]) :- not member(H, T), allDiff(T).

% Helper for connected rule
connectedHelper(Origin, Origin, _, [Origin]).
connectedHelper(Current, Destination, Visited, Path) :-
    link(Current, Next),
    not member(Next, Visited),
    connectedHelper(Next, Destination, [Next | Visited], SubPath),
    Path = [Current | SubPath].

% Helper for printing System Info
printSystemInfo(Sys, C, L, M, A, D, J, E, K, O, T, W, Z, B, F, N, P, S, U) :-
    write("System "), write(Sys), write(":"), nl,
    write("Admin - "),
    firstName(Sys, C, L, M, A, D, J, First),
    lastName(Sys, E, K, O, T, W, Z, Last),
    address(Sys, B, F, N, P, S, U, Addr),
    write(First), write(" "), write(Last), nl,
    write("Address - "), write(Addr), nl, nl.

% Helper for mapping first names
firstName(X, X, _, _, _, _, _, "Catarina").
firstName(X, _, X, _, _, _, _, "Lizzie").
firstName(X, _, _, X, _, _, _, "Mona").
firstName(X, _, _, _, X, _, _, "Anthony").
firstName(X, _, _, _, _, X, _, "Daniel").
firstName(X, _, _, _, _, _, X, "Jamie").

% Helper for mapping last names
lastName(X, X, _, _, _, _, _, "Elby").
lastName(X, _, X, _, _, _, _, "Kim").
lastName(X, _, _, X, _, _, _, "Osborne").
lastName(X, _, _, _, X, _, _, "Tsuji").
lastName(X, _, _, _, _, X, _, "Wolverton").
lastName(X, _, _, _, _, _, X, "Zickerman").

% Helper for mapping addresses
address(X, X, _, _, _, _, _, "bananas.com").
address(X, _, X, _, _, _, _, "firstbank.com").
address(X, _, _, X, _, _, _, "netvue.com").
address(X, _, _, _, X, _, _, "pricenet.com").
address(X, _, _, _, _, X, _, "sysworld.com").
address(X, _, _, _, _, _, X, "univmoose.edu").

%%% Define solve below. Remember that solve should take in the list of
%%% variables to assign. MAKE SURE TO BRIEFLY EXPLAIN THE MEANING OF
%%% YOUR VARIABLES IN A COMMENT

% VARIABLES EXPLANATION
% 
% These variables correspond to the first names and last names of each system admin, and also the address of each system.
% The variables will be used to apply the constraints.
% Each will take the integer value of the system they belong to. By the end, we should have 3 variables correspond to each system integer.
% Through that shared system integer, we will connect which first and last names and address correspond to which system
%
% FEMALE FIRST NAMES
%   C - Catarina
%   L - Lizzie
%   M - Mona
%
% MALE FIRST NAMES
%   A - Anothony
%   D - Daniel
%   J - Jamie
%
% LAST NAMES
%   E - Elby
%   K - Kim
%   O - Osborne
%   T - Tsuji
%   W - Wolverton
%   Z - Zickerman
%
% ADDRESSES
%   B - bananas.com
%   F - firstbank.com
%   N - netvue.com
%   P - pricenet.com
%   S - sysworld.com
%   U - univmoose.edu 

solve([C, L, M, A, D, J, E, K, O, T, W, Z, B, F, N, P, S, U]) :-
    % 1) % Lizzie and Osborne connection must pass through pricenet.com
    computer(L), computer(O), not L = O, connected(L, O, Path1), computer(P), not L = P, not O = P, member(P, Path1),
    
    % 2) Mona and Wolverton exchange directly, and one of them are netvue.com
    computer(M), link(M, W), member(N, [M, W]),
    
    % 3) Anthony and Jamie connection must pass through Elby
    computer(A), computer(J), not A = J, connected(A, J, Path2), computer(E), not A = E, not J = E, member(E, Path2),
    
    % 4) % Daniel exchange directly ONLY with sysworld.com (or outside)
    computer(D), link(D, S), not (link(D, OtherComputer1), not OtherComputer1 = S, not OtherComputer1 = out),
    
    % 5) Jamie and Ms. Tsuji (female sys admin) must pass through univmoose.edu
    computer(C), allDiff([C, L, M, A, D, J]), member(T, [C, L, M]), connected(J, T, Path3),
    computer(U), member(U, Path3), not J = U, not T = U,
    
    % 6) bananas.com belongs to a female sys admin
    member(B, [C, L, M]),
    
    % 7) Kim and out connection must pass through firstbank.com
    computer(K), connected(K, out, Path4), computer(F), not K = F, member(F, Path4),

    % 8) Zickermans system only links to Catarina or netvue.com (and possibly out, but not necessarily)
    link(Z, C), allDiff([E, K, O, T, W, Z]), link(Z, N), allDiff([B, F, N, P, S, U]),
    not (link(Z, OtherComputer2), not OtherComputer2 = C, not OtherComputer2 = N, not OtherComputer2 = out).

%%% Define printSolution below. This should take in the list of variables 
%%% after they have been assigned values, and outputs the solution in a
%%% human readable form.
%%% REMEMBER TO LOG YOUR FINAL OUTPUT AND RUNTIME IN assignment3_report.pdf

printSolution([C, L, M, A, D, J, E, K, O, T, W, Z, B, F, N, P, S, U]) :-
    printSystemInfo(1, C, L, M, A, D, J, E, K, O, T, W, Z, B, F, N, P, S, U),
    printSystemInfo(2, C, L, M, A, D, J, E, K, O, T, W, Z, B, F, N, P, S, U),
    printSystemInfo(3, C, L, M, A, D, J, E, K, O, T, W, Z, B, F, N, P, S, U),
    printSystemInfo(4, C, L, M, A, D, J, E, K, O, T, W, Z, B, F, N, P, S, U),
    printSystemInfo(5, C, L, M, A, D, J, E, K, O, T, W, Z, B, F, N, P, S, U),
    printSystemInfo(6, C, L, M, A, D, J, E, K, O, T, W, Z, B, F, N, P, S, U).

%%%%% SECTION: q2_solve_and_print
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