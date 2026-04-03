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
% Add the required statements in the q3a_can_reach section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%


%%%%% SECTION: q3a_movie_kb_import
% The following line will import your movie KB. You can feel free to
% edit this line if you want to import and test on different KBs.
% We will ignore this section when testing your code, and instead test
% on our own KBs.
:- [q1_movie_kb].



%%%%% SECTION: q3a_can_reach
% You define canReach and any helper predicates below.

% Base case: An actor can reach themselves with distance 0
% Only if they acted in at least one movie
canReach(A, A, M) :- 
    M >= 0,
    actedIn(A, _, _).

% Recursive case: A1 can reach A2 if:
% - M > 0 (we have steps remaining)
% - A1 acted in some movie Movie
% - Another actor Mid also acted in the same Movie
% - A1 is not the same as Mid (to avoid trivial self-loops)
% - Mid can reach A2 with at most M-1 steps
canReach(A1, A2, M) :- 
    M > 0,
    actedIn(A1, Movie, _),
    actedIn(Mid, Movie, _),
    not(A1 = Mid),
    M1 is M - 1,
    canReach(Mid, A2, M1).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW