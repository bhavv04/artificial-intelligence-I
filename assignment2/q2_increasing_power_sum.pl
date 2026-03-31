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
% Add the required statements in the q2_rules section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%

%%%%% SECTION: q2_rules
%%%%% You should put your rules in this section, including helper predicates.
%%%%% Predicate definition: increasingPowerSum(List, Power, PowerInc, Sum)

% Base case: empty list returns sum 0
increasingPowerSum([], _, _, 0).

% Recursive case: process the head and recurse on the tail
increasingPowerSum([Head | Tail], Power, PowerInc, Sum) :-
    % Calculate Head^Power using helper predicate
    power(Head, Power, PowerValue),
    
    % Recurse on the tail with incremented power
    NextPower is Power + PowerInc,
    increasingPowerSum(Tail, NextPower, PowerInc, TailSum),
    
    % Sum the current power value with the sum of the tail
    Sum is PowerValue + TailSum.

% Helper predicate: power(Base, Exponent, Result)
% Calculates Base^Exponent
power(_, 0, 1).  % Anything to the power of 0 is 1

power(Base, Exp, Result) :-
    Exp > 0,
    Exp1 is Exp - 1,
    power(Base, Exp1, Result1),
    Result is Base * Result1.

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW