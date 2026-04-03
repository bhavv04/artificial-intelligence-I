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
% Add the required statements in the q3_rules section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%

%%%%% SECTION: q3_rules
%%%%% You should put your rules in this section, including helper predicates.
%%%%% Predicate definition: splitOnInt(List, Value, NoLargerList, LargerList)
splitOnInt([], _, [], []).
splitOnInt([H|T], Value, [H|NoLargerList], LargerList) :-
    H =< Value,
    splitOnInt(T, Value, NoLargerList, LargerList).

splitOnInt([H|T], Value, NoLargerList, [H|LargerList]) :-
    H > Value,
    splitOnInt(T, Value, NoLargerList, LargerList).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW