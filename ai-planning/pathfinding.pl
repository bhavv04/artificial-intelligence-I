% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Parsa Kermani Pour
%%%%% NAME: Bhavdeep Arora
%%%%% NAME: Arshia Sharifi
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: pathfinding_setup
%%%%%
%%%%% These lines allow you to write statements for a predicate that are not consecutive in your program
%%%%% Doing so enables the specification of an initial state in another file
%%%%% DO NOT MODIFY THE CODE IN THIS SECTION
:- dynamic agentLoc/4.

%%%%% This line loads the generic planner code from the file "planner.pl"
%%%%% Just ensure that that the planner.pl file is in the same directory as this one
:- [planner].


%%%%% SECTION: init_pathfinding
%%%%% Loads the initial state from either pathfindingInit1.pl or pathfindingInit2.pl
%%%%% Just leave whichever one uncommented that you want to test on
%%%%% NOTE, you can only uncomment one at a time
%%%%% HINT: You can create other files with other initial states to more easily test individual actions
%%%%%       To do so, just replace the line below with one loading in the file with your initial state
%:- [pathfindingInit1].
:- [pathfindingInit2].


%%%%% SECTION: goal_states_pathfinding
%%%%% Below we define different goal states, each with a different ID
%%%%% HINT: It may be useful to define "easier" goals when starting your program or when debugging
%%%%%       You can do so by adding more goal states below
%%%%% Goal XY should be read as goal Y for problem X

%%%%% Goal states for pathfindingInit1
%% The first three should be under a second on regular mode
%% Goal 14 should take a few seconds on regular mode
%% Goal 15 may take 10-20 seconds on regular mode
%% Goal 16 may take a few minutes on regular mode
%% Goal 17 may take a few minutes even on heuristic mode

% Before running on these goal states, manually figure out what the optimal solution should be
goal_state(11, S) :- agentLoc(a1, 0, 1, S).
goal_state(12, S) :- agentLoc(a1, 0, 1, S), agentLoc(a2, 2, 2, S).
goal_state(13, S) :- agentLoc(a1, 0, 1, S), agentLoc(a2, 2, 2, S), agentLoc(a3, 2, 1, S).
goal_state(14, S) :- agentLoc(a1, 2, 2, S).
goal_state(15, S) :- agentLoc(a1, 3, 2, S).
goal_state(16, S) :- agentLoc(a1, 3, 2, S), agentLoc(a2, 2, 2, S).
goal_state(17, S) :- agentLoc(a1, 2, 2, S), agentLoc(a2, 0, 2, S).

%% Goal states for pathfindingInit2
%% Goal 21 takes 10-30 seconds on regular mode
%% Goal 22 take 5-10 minutes on regular mode
%% Goal 23 will take a minute or two on heuristic mode
goal_state(21, S) :- agentLoc(a1, 0, 1, S), agentLoc(a2, 0, 2, S), agentLoc(a3, 0, 3, S), 
                        agentLoc(a4, 0, 0, S), agentLoc(a5, 3, 4, S).
goal_state(22, S) :- agentLoc(a1, 1, 3, S), agentLoc(a2, 0, 0, S).
goal_state(23, S) :- agentLoc(a1, 2, 4, S).

%%%%% SECTION: precondition_axioms_pathfinding
%%%%% Write precondition axioms for all actions in your domain. Recall that to avoid
%%%%% potential problems with negation in Prolog, you should not start bodies of your
%%%%% rules with negated predicates. Make sure that all variables in a predicate 
%%%%% are instantiated by constants before you apply negation to the predicate that 
%%%%% mentions these variables. 

poss(move(Agent, Row1, Col1, Row2, Col2), S) :-
    agent(Agent),
    agentLoc(Agent, Row1, Col1, S),
    adjacent(Row1, Col1, Row2, Col2),
    numRows(MaxRow),
    numCols(MaxCol),
    inBounds(Row2, MaxRow),
    inBounds(Col2, MaxCol),
    not wallAt(Row2, Col2),
    not occupied(Row2, Col2, S),
    not sameLocation(Row1, Col1, Row2, Col2).

%%%%% SECTION: successor_state_axioms_pathfinding
%%%%% Write successor-state axioms that characterize how the truth value of all 
%%%%% fluents change from the current situation S to the next situation [A | S]. 
%%%%% You will need two types of rules for each fluent: 
%%%%% 	(a) rules that characterize when a fluent becomes true in the next situation 
%%%%%	as a result of the last action, and
%%%%%	(b) rules that characterize when a fluent remains true in the next situation,
%%%%%	unless the most recent action changes it to false.
%%%%% When you write successor state axioms, you can sometimes start bodies of rules 
%%%%% with negation of a predicate, e.g., with negation of equality. This can help 
%%%%% to make them a bit more efficient.
%%%%%
%%%%% Write your successor state rules here: you have to write brief comments %

% Successor-state axiom for agentLoc(Agent, Row, Col, S)
% Case 1: Agent is at (Row, Col) because it just moved there
agentLoc(Agent, Row2, Col2, [move(Agent, Row1, Col1, Row2, Col2) | S]).

% Case 2: Agent remains at (Row, Col) if it didn't move (persistence)
agentLoc(Agent, Row, Col, [A | S]) :-
    agentLoc(Agent, Row, Col, S),
    not A = move(Agent, Row, Col, _, _).


%%%%% SECTION: declarative_heuristics_pathfinding
%%%%% write your rules implementing the predicate  useless(Action,History) here. %

% Heuristic 1: Don't immediately reverse a move (moving back to where we just came from)
useless(move(Agent, R1, C1, R2, C2), [move(Agent, R2, C2, R1, C1) | _]).

% Heuristic 2: Don't move an agent to a location it was at 2 moves ago (oscillating)
useless(move(Agent, R1, C1, R2, C2), [_, move(Agent, R2, C2, R1, C1) | _]).

% Heuristic 3: Don't move an agent that's already been moved 3+ times consecutively
useless(move(Agent, _, _, _, _), [move(Agent, _, _, _, _), move(Agent, _, _, _, _), move(Agent, _, _, _, _) | _]).

% ALL HELPER PREDICATES GO AFTER ALL useless/2 RULES

% Helper: checks if two locations are adjacent or the same
adjacentOrSame(R1, C1, R2, C2) :-
    sameLocation(R1, C1, R2, C2).
adjacentOrSame(R1, C1, R2, C2) :-
    adjacent(R1, C1, R2, C2).

% Helper: checks if a location is a corner
isCorner(0, 0, _, _).
isCorner(0, C, _, MaxC) :- C is MaxC - 1.
isCorner(R, 0, MaxR, _) :- R is MaxR - 1.
isCorner(R, C, MaxR, MaxC) :- R is MaxR - 1, C is MaxC - 1.

% Helper: checks if agent was recently at a corner (within last 2 moves)
recentlyAtCorner(Agent, [move(Agent, _, _, R, C) | _]) :-
    numRows(MaxRow),
    numCols(MaxCol),
    isCorner(R, C, MaxRow, MaxCol).
recentlyAtCorner(Agent, [_ | Rest]) :-
    recentlyAtCorner(Agent, Rest).
    
% Helper: checks if two cells are adjacent (one step up/down/left/right)
adjacent(Row1, Col1, Row2, Col2) :-
    Row2 is Row1 - 1, Col2 = Col1.  % Move up
adjacent(Row1, Col1, Row2, Col2) :-
    Row2 is Row1 + 1, Col2 = Col1.  % Move down
adjacent(Row1, Col1, Row2, Col2) :-
    Row2 = Row1, Col2 is Col1 - 1.  % Move left
adjacent(Row1, Col1, Row2, Col2) :-
    Row2 = Row1, Col2 is Col1 + 1.  % Move right

% Helper: checks if a value is within bounds [0, Max)
% Uses difference to check: if Coord - 0 >= 0 and Max - Coord > 0
inBounds(Coord, Max) :-
    Diff1 is Coord - 0,
    Diff2 is Max - Coord,
    isNonNegative(Diff1),
    isPositive(Diff2).

% Helper: checks if a number is non-negative (>= 0)
% A number X >= 0 if abs(X) = X
isNonNegative(X) :-
    AbsX is abs(X),
    X = AbsX.

% Helper: checks if a number is positive (> 0)
% A number X > 0 if X is non-negative and X is not 0
isPositive(X) :-
    isNonNegative(X),
    not X = 0.

% Helper: checks if a location is occupied by any agent
occupied(Row, Col, S) :-
    agent(A),
    agentLoc(A, Row, Col, S).

% Helper: checks if two locations are the same
sameLocation(Row1, Col1, Row2, Col2) :-
    Row1 = Row2, Col1 = Col2.