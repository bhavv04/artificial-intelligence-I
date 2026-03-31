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

%%%%% SECTION: dishwashing_setup
%%%%%
%%%%% These lines allow you to write statements for a predicate that are not consecutive in your program
%%%%% Doing so enables the specification of an initial state in another file
%%%%% DO NOT MODIFY THE CODE IN THIS SECTION
:- dynamic holding/2.
:- dynamic numHolding/2.
:- dynamic faucetOn/1.
:- dynamic loc/3.
:- dynamic wet/2.
:- dynamic dirty/2.
:- dynamic soapy/2.
:- dynamic plate/1.
:- dynamic glassware/1.

%%%%% This line loads the generic planner code from the file "planner.pl"
%%%%% Just ensure that that the planner.pl file is in the same directory as this one
:- [planner].

%%%%% SECTION: init_dishwashing
%%%%% Loads the initial state from either dishwashingInit1.pl or dishwashingInit2.pl
%%%%% Just leave whichever one uncommented that you want to test on
%%%%% NOTE, you can only uncomment one at a time
%%%%% HINT: You can create other files with other initial states to more easily test individual actions
%%%%%       To do so, just replace the line below with one loading in the file with your initial state
:- [dishwashingInit1].
%:- [dishwashingInit2].
%:- [dishwashingInit3].

%%%%% SECTION: goal_states_dishwashing
%%%%% Below we define different goal states, each with a different ID
%%%%% HINT: It may be useful to define "easier" goals when starting your program or when debugging
%%%%%       You can do so by adding more goal states below

%% Goal states for dishwashingInit1
goal_state(11, S) :- holding(brush, S), soapy(brush, S).
goal_state(12, S) :- loc(brush, dish_rack, S), loc(sponge, counter, S).
goal_state(13, S) :- not dirty(g1, S), not soapy(g1, S).
goal_state(14, S) :- not dirty(g1, S), not soapy(g1, S), loc(g1, dish_rack, S), not faucetOn(S). 
goal_state(15, S) :- not dirty(g1, S), not soapy(g1, S), loc(g1, dish_rack, S), not soapy(brush, S),
                        loc(brush, dish_rack, S), not faucetOn(S). 

%% Goal states for dishwashingInit2
goal_state(21, S) :- not dirty(p1, S), not soapy(p1, S). 
goal_state(22, S) :- not dirty(p1, S), not soapy(p1, S), loc(p1, dish_rack, S), 
                        not dirty(p2, S), not soapy(p2, S), loc(p2, dish_rack, S).  

%% Goal states for dishwashingInit3
goal_state(31, S) :- not dirty(p1, S), not soapy(p1, S), not dirty(g1, S), not soapy(g1, S),
                        loc(p1, dish_rack, S), loc(g1, dish_rack, S).

%%%%% SECTION: aux_dishwashing
%%%%% Add any additional helpers here, including any additional rules needed for the auxiliary predicates
%%%%% DO NOT MODIFY THE CODE IN THIS SECTION
place(counter).
place(dish_rack).

scrubber(sponge).
scrubber(brush).

dish(X) :- glassware(X).
dish(X) :- plate(X).

item(X) :- glassware(X).
item(X) :- plate(X).
item(X) :- scrubber(X).

%%%%% SECTION: precondition_axioms_dishwashing
%%%%% Write precondition axioms for all actions in your domain. Recall that to avoid
%%%%% potential problems with negation in Prolog, you should not start bodies of your
%%%%% rules with negated predicates. Make sure that all variables in a predicate 
%%%%% are instantiated by constants before you apply negation to the predicate that 
%%%%% mentions these variables. 

% Pickup item X from place P. Robot must have a free hand.
poss(pickUp(X, P), S) :- item(X), place(P),
    loc(X, P, S),
    numHolding(N, S),
    N < 2,
    not holding(X, S).

% Put down item X on place P. Robot must be holding this item.
poss(putDown(X, P), S) :- item(X), place(P),
    holding(X, S).

% Turn on the faucet. Faucet must already be off and robot must have a free hand.
poss(turnOnFaucet, S) :-
    numHolding(N, S),
    N < 2,
    not faucetOn(S).

% Turn off the faucet. Faucet must already be on and robot must have a free hand.
poss(turnOffFaucet, S) :-
    numHolding(N, S),
    N < 2,
    faucetOn(S).

% Add soap to a scrubber X. Robot must have a free hand.
poss(addSoap(X), S) :- scrubber(X),
    holding(X, S),
    numHolding(N, S),
    N < 2.

% Scrub dish X with scrubber Y. Robot must be holding X and Y to scrub.
% If X is glasswear, Y must be the brush.
poss(scrub(X, Y), S) :- glassware(X), Y = brush,
    holding(X, S),
    holding(Y, S).
% If X is a plate, Y must be the sponge.
poss(scrub(X, Y), S) :- plate(X), Y = sponge,
    holding(X, S),
    holding(Y, S).

% Rinse item X. Robot must be holding X and the faucet must be turned on.
poss(rinse(X), S) :- item(X),
    holding(X, S),
    faucetOn(S).

%%%%% SECTION: successor_state_axioms_dishwashing
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

% holding(X, S)
% Robot just picked up item X
holding(X, [pickUp(X, P) | S]).
% Robot hasn't put down item X
holding(X, [A | S]) :- not A = putDown(X, P), not A = pickUp(X, P), holding(X, S).

% numHolding(C, S)
% Adjusts C based on number of pickups and putdowns
numHolding(C, [pickUp(X, P) | S]) :- numHolding(C1, S), C is C1 + 1.
numHolding(C, [putDown(X, P) | S]) :- numHolding(C1, S), C is C1 - 1.
numHolding(C, [A | S]) :- not A = pickUp(X, P), not A = putDown(X, P), numHolding(C, S).

% faucetOn(S)
% Robot just turned on the faucet
faucetOn([turnOnFaucet | S]).
% Robot never turns off the faucet
faucetOn([A | S]) :- not A = turnOffFaucet, not A = turnOnFaucet, faucetOn(S).

% loc(X, P, S) 
% Robot just placed item X on place P
loc(X, P, [putDown(X, P) | S]).
% Robot never picks up item X from place P
loc(X, P, [A | S]) :- not A = pickUp(X, P), not A = putDown(X, P), loc(X, P, S).

% wet(X, S)
% Item X just got rinsed
wet(X, [rinse(X) | S]).
% Item X was rinsed in a previous action (goes through the list until we get to just rinsed base case)
wet(X, [A | S]) :- not A = rinse(X), wet(X, S).

% dirty(X, S)
% dish X was just rinsed but was not soapy
dirty(X, [rinse(X) | S]) :- dish(X), not soapy(X, S).
% dish X was never rinsed
dirty(X, [A | S]) :- dish(X), not A = rinse(X), dirty(X, S).

% soapy(X, S)
% Just added soap to scrubber X
soapy(X, [addSoap(X) | S]) :- scrubber(X).
% Just scrubbed soap onto dish X with soapy scrubber Y
soapy(X, [scrub(X, Y) | S]) :- soapy(Y, S).
% Haven't rinsed soap off yet
soapy(X, [A | S]) :- scrubber(X), not A = rinse(X), not A = addSoap(X), soapy(X, S).
soapy(X, [A | S]) :- dish(X), not A = rinse(X), not A = scrub(X, Y), soapy(X, S).

%%%%% SECTION: declarative_heuristics_dishwashing
%%%%% The predicate useless(A,ListOfPastActions) is true if an action A is useless
%%%%% given the list of previously performed actions. The predicate useless(A,ListOfPastActions)
%%%%% helps to solve the planning problem by providing declarative heuristics to 
%%%%% the planner. If this predicate is correctly defined using a few rules, then it 
%%%%% helps to speed-up the search that your program is doing to find a list of actions
%%%%% that solves a planning problem. Write as many rules that define this predicate
%%%%% as you can: think about useless repetitions you would like to avoid, and about 
%%%%% order of execution (i.e., use common sense properties of the application domain). 
%%%%% Your rules have to be general enough to be applicable to any problem in your domain,
%%%%% in other words, they have to help in solving a planning problem for any instance
%%%%% (i.e., any initial and goal states).
%%%%%	
%%%%% write your rules implementing the predicate  useless(Action, History) here. %

% Consectutive opposing actions
useless(pickUp(X, P), [putDown(X, P) | S]).         % Putting down an item you just picked up.
useless(putDown(X, P), [pickUp(X, P) | S]).         % Picking up an item you just put down.
useless(turnOnFaucet, [turnOffFaucet | S]).         % Turning on the faucet when it was just turned off
useless(turnOffFaucet, [turnOnFaucet | S]).         % Turning off the faucet when it was just turned on

% Does not change the state
useless(addSoap(X), S) :- soapy(X, S).              % Adding soap to a soapy item
useless(scrub(X, Y), S) :- soapy(X, S).             % Scrubbing a dish that is already soapy
useless(scrub(X, Y), S) :- not soapy(Y, S).         % Scrubbing a dish when the scrubber is not soapy

% Unecessary actions
useless(scrub(X, Y), S) :-                          % Scrubbing a clean dish
    not soapy(X, S), not dirty(X, S).
useless(rinse(X), S) :-                             % Rinsing a clean dish
    dish(X), not soapy(X, S), not dirty(X, S).
useless(rinse(X), S) :- dish(X), not soapy(X, S).   % Rinsing a dish that is not soapy
useless(putDown(X, counter), S) :- 
    dish(X), not soapy(X, S), not dirty(X, S).      % Putting a clean dish back on the counter
useless(putDown(X, dish_rack), S) :-                % Putting a dirty dish on the dish rack
    dish(X), dirty(X, S).
useless(putDown(X, dish_rack), S) :-                % Putting a soapy dish on the dish rack
    dish(X), soapy(X, S).
