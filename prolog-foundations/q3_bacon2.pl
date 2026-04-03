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
% Add the required statements in the q3b_can_reach_through_movie section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%


%%%%% SECTION: q3b_kb_import
% The following line will import your movie KB. You can feel free to
% edit this line if you want to import and test on different KBs.
% We will ignore this section when testing your code, and instead test
% on our own KBs.
:- [q1_movie_kb].



%%%%% SECTION: q3b_can_reach_through_movie
% You define canReachThroughMovie and any helper predicates below.

% Helper predicate: two actors are directly connected if they acted in the same movie
directCoActor(A1, A2) :-
    actedIn(A1, Movie, _),
    actedIn(A2, Movie, _),
    not(A1 = A2).

% Helper predicate: two actors are connected through a specific movie
directCoActorThroughMovie(A1, A2, Movie) :-
    actedIn(A1, Movie, _),
    actedIn(A2, Movie, _),
    not(A1 = A2).

% Base case: direct connection through the specified movie
canReachThroughMovie(A1, A2, Movie, M) :-
    M >= 1,
    directCoActorThroughMovie(A1, A2, Movie).

% Recursive case: go to intermediate actor first, then through the movie (but not if direct path exists)
canReachThroughMovie(A1, A2, Movie, M) :-
    M >= 2,
    not(directCoActorThroughMovie(A1, A2, Movie)),  % Only if no direct path
    M1 is M - 1,
    directCoActor(A1, X),
    canReachThroughMovie(X, A2, Movie, M1).

% Recursive case: go through the movie first, then continue to target
canReachThroughMovie(A1, A2, Movie, M) :-
    M >= 2,
    M1 is M - 1,
    directCoActorThroughMovie(A1, X, Movie),
    not(A1 = X),
    not(directCoActorThroughMovie(A1, A2, Movie)),  % Only if no direct path
    canReach2(X, A2, M1).

% Base case: distance 0 - actor can reach themselves if they appear in some movie
canReach2(A, A, M) :-
    M >= 0,
    actedIn(A, _, _).

% Base case: distance 1 - direct co-actors
canReach2(A1, A2, M) :-
    M >= 1,
    not(A1 = A2),
    directCoActor(A1, A2).

% Recursive case: find path through intermediate actor
canReach2(A1, A2, M) :-
    M >= 2,
    not(A1 = A2),
    M1 is M - 1,
    directCoActor(A1, X),
    not(A1 = X),
    canReach2(X, A2, M1).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW