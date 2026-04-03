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

%%%%% SECTION: q3_kenken_solution
%%%%% Put the different components of your KenKen solution below

%%% Put the domains for your variables below


%%% Define any helper predicates here

% nth1 implementation (1-indexed list access)
nth1(1, [H|_], H).
nth1(N, [_|T], Elem) :-
    N > 1,
    N1 is N - 1,
    nth1(N1, T, Elem).

% Get cell at position (Row, Col) from the variable list
get_cell(Vars, Row, Col, Cell) :-
    Index is (Row - 1) * 4 + Col,
    nth1(Index, Vars, Cell).

% Check if value is not already used in the row (left of current position)
row_unique(_, _, 1, _).
row_unique(Vars, Row, Col, Val) :-
    Col > 1,
    PrevCol is Col - 1,
    get_cell(Vars, Row, PrevCol, PrevVal),
    not(PrevVal = Val),
    row_unique(Vars, Row, PrevCol, Val).

% Check if value is not already used in the column (above current position)
col_unique(_, 1, _, _).
col_unique(Vars, Row, Col, Val) :-
    Row > 1,
    PrevRow is Row - 1,
    get_cell(Vars, PrevRow, Col, PrevVal),
    not(PrevVal = Val),
    col_unique(Vars, PrevRow, Col, Val).

% Helper for difference (order-independent)
diff_constraint(A, B, Target) :-
    diff_calc(A, B, Diff),
    Diff = Target.

diff_calc(A, B, Diff) :-
    A > B,
    Diff is A - B.
diff_calc(A, B, Diff) :-
    not(A > B),
    Diff is B - A.

% Helper for division (order-independent, integer division)
div_constraint(A, B, Target) :-
    div_check(A, B, Target).
div_constraint(A, B, Target) :-
    div_check(B, A, Target).

div_check(A, B, Target) :-
    not(B = 0),
    Rem is A mod B,
    Rem = 0,
    Quot is A // B,
    Quot = Target.

% Cage constraint checkers (called when all cells in cage are assigned)
check_cage_3minus(Vars) :-
    get_cell(Vars, 1, 1, A),
    get_cell(Vars, 2, 1, B),
    diff_constraint(A, B, 3).

check_cage_2div_top(Vars) :-
    get_cell(Vars, 1, 2, A),
    get_cell(Vars, 1, 3, B),
    div_constraint(A, B, 2).

check_cage_6plus(Vars) :-
    get_cell(Vars, 1, 4, A),
    get_cell(Vars, 2, 4, B),
    get_cell(Vars, 2, 3, C),
    Sum is A + B + C,
    6 = Sum.

check_cage_7plus(Vars) :-
    get_cell(Vars, 2, 2, A),
    get_cell(Vars, 3, 2, B),
    Sum is A + B,
    7 = Sum.

check_cage_1minus(Vars) :-
    get_cell(Vars, 3, 1, A),
    get_cell(Vars, 4, 1, B),
    diff_constraint(A, B, 1).

check_cage_3times(Vars) :-
    get_cell(Vars, 3, 3, A),
    get_cell(Vars, 4, 3, B),
    get_cell(Vars, 4, 2, C),
    Prod is A * B * C,
    3 = Prod.

check_cage_2div_right(Vars) :-
    get_cell(Vars, 3, 4, A),
    get_cell(Vars, 4, 4, B),
    div_constraint(A, B, 2).

% Check all cage constraints  
check_all_cages(Vars) :-
    check_cage_3minus(Vars),
    check_cage_2div_top(Vars),
    check_cage_6plus(Vars),
    check_cage_7plus(Vars),
    check_cage_1minus(Vars),
    check_cage_3times(Vars),
    check_cage_2div_right(Vars).


%%% Define solve below. Remember that solve should take in the list of
%%% variables to assign. MAKE SURE TO BRIEFLY EXPLAIN THE MEANING OF
%%% YOUR VARIABLES IN A COMMENT

% solve(-Vars): Assigns values to 16 variables representing the 4x4 KenKen grid.
% Uses interleaving: checks row/column constraints during assignment.
% Variables are in row-major order: [R1C1, R1C2, ..., R4C4]
solve(Vars) :-
    length(Vars, 16),
    assign_cells(Vars, 1, 1),
    check_all_cages(Vars).

% assign_cells(+Vars, +Row, +Col): Recursively assign values with interleaving
assign_cells(_, 5, 1).
assign_cells(Vars, Row, 5) :-
    NextRow is Row + 1,
    assign_cells(Vars, NextRow, 1).
assign_cells(Vars, Row, Col) :-
    Col =< 4,
    get_cell(Vars, Row, Col, Cell),
    member(Cell, [1, 2, 3, 4]),
    row_unique(Vars, Row, Col, Cell),
    col_unique(Vars, Row, Col, Cell),
    NextCol is Col + 1,
    assign_cells(Vars, Row, NextCol).


%%% Define printSolution below. This should take in the list of variables 
%%% after they have been assigned values, and outputs the solution in a
%%% human readable form.
%%% REMEMBER TO LOG YOUR FINAL OUTPUT AND RUNTIME IN assignment3_report.pdf

printSolution(Vars) :-
    get_cell(Vars, 1, 1, R1C1), get_cell(Vars, 1, 2, R1C2), get_cell(Vars, 1, 3, R1C3), get_cell(Vars, 1, 4, R1C4),
    get_cell(Vars, 2, 1, R2C1), get_cell(Vars, 2, 2, R2C2), get_cell(Vars, 2, 3, R2C3), get_cell(Vars, 2, 4, R2C4),
    get_cell(Vars, 3, 1, R3C1), get_cell(Vars, 3, 2, R3C2), get_cell(Vars, 3, 3, R3C3), get_cell(Vars, 3, 4, R3C4),
    get_cell(Vars, 4, 1, R4C1), get_cell(Vars, 4, 2, R4C2), get_cell(Vars, 4, 3, R4C3), get_cell(Vars, 4, 4, R4C4),
    write('KenKen Solution:'), nl,
    write('  '), write(R1C1), write('  '), write(R1C2), write('  '), write(R1C3), write('  '), write(R1C4), nl,
    write('  '), write(R2C1), write('  '), write(R2C2), write('  '), write(R2C3), write('  '), write(R2C4), nl,
    write('  '), write(R3C1), write('  '), write(R3C2), write('  '), write(R3C3), write('  '), write(R3C4), nl,
    write('  '), write(R4C1), write('  '), write(R4C2), write('  '), write(R4C3), write('  '), write(R4C4), nl.



%%%%% SECTION: q3_solve_and_print
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
