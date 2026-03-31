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

%%%%% SECTION: q4a_movie_kb_import
% The following line will import a file called "movie_kb.pl". 
% Thus, you can create such a file to test your program.
% You can feel free tovedit this line if you want to import and test 
% on different KBs. We will ignore this section when testing your code, 
% and instead test on our own KBs.
:- [movie_kb].



%%%%% SECTION: q4a_rules
%%%%% You should put your rules in this section, including helper predicates.
%%%%% Predicate definition: canReach(A1, A2, M, ActPath, MoviePath)
canReach(A1, A2, M, ActPath, MoviePath) :-
    M >= 0,
    canReachHelper(A1, A2, M, [A1], [], ActPath, MoviePath).

% Base case
canReachHelper(A, A, _, ActAcc, MovieAcc, ActPath, MoviePath) :-
    actedIn(A, _Movie, _),  % just verify they acted in at least one movie
    reverse(ActAcc, ActPath),
    reverse(MovieAcc, MoviePath).

% Recursive case 
canReachHelper(A1, A2, M, ActAcc, MovieAcc, ActPath, MoviePath) :-
    M > 0,
    actedIn(A1, Movie,_),
    not(member(Movie, MovieAcc)),
    actedIn(A3, Movie,_),
    not(A3 = A1),
    not(member(A3, ActAcc)),
    M1 is M - 1,
    canReachHelper(A3, A2, M1, [A3|ActAcc], [Movie|MovieAcc], ActPath, MoviePath).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW