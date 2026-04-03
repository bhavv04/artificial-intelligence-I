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
% Add the required statements in the q5_rules section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%

%%%%% SECTION: q5_rules
%%%%% You should put your rules in this section, including helper predicates.
%%%%% Predicate definition: zipper(List1, List2, Zipper)

% Base case: both lists are empty, result is empty
zipper(nil, nil, nil).

% Case 1: List1 is empty, result is just List2
zipper(nil, List2, List2).

% Case 2: List2 is empty, result is just List1
zipper(List1, nil, List1) :-
    not(List1 = nil).

% Case 3: Both lists have elements - alternate them
zipper(next(H1, T1), next(H2, T2), next(H1, next(H2, Result))) :-
    zipper(T1, T2, Result).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW