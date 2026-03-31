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
% Add the required statements in the q3a_can_reach_through_2_movies section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%


%%%%% SECTION: q3c_kb_import
% The following line will import your movie KB. You can feel free to
% edit this line if you want to import and test on different KBs.
% We will ignore this section when testing your code, and instead test
% on our own KBs.
:- [q1_movie_kb].



%%%%% SECTION: q3c_can_reach_through_2_movies
% You define canReachThrough2Movies and any helper predicates below.
% If you decide to reuse your canReach and canReachThroughMovie implementations from q3a 
% and q3b as part of this solution, include it below. To avoid collision if you first compile
% q3_bacon1 and then q3_bacon2, we suggest you rename canReach to something else.
% Do NOT use an import statement like the one in section q3c_kb_import to import and reuse
% your answer to parts (a) and (b) below. 

% Done going through needed movies, just find rest of path

% canReachThrough2Movies(A1, A3) is true if there exists A2, M1, M2 such that:
% A1 and A2 acted in M1, A2 and A3 acted in M2, all actors and movies are distinct.

% You define canReachThrough2Movies and any helper predicates below.

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

% Base case for canReach3 (needed for helper functions)
canReach3(A, A, M) :-
    M >= 0,
    actedIn(A, _, _).

% Base case: distance 1 - direct co-actors
canReach3(A1, A2, M) :-
    M >= 1,
    directCoActor(A1, A2).

% Recursive case: find path through intermediate actor
canReach3(A1, A2, M) :-
    M >= 2,
    M1 is M - 1,
    directCoActor(A1, X),
    canReach3(X, A2, M1).

% canReachThroughMovie from part (b) - needed as helper
% Base case: direct connection through the specified movie
canReachThroughMovie2(A1, A2, Movie, M) :-
    M >= 1,
    directCoActorThroughMovie(A1, A2, Movie).

% Recursive case: reach intermediate actor, then through movie
canReachThroughMovie2(A1, A2, Movie, M) :-
    M >= 2,
    M1 is M - 1,
    directCoActor(A1, X),
    canReachThroughMovie2(X, A2, Movie, M1).

% Recursive case: go through movie first, then continue
canReachThroughMovie2(A1, A2, Movie, M) :-
    M >= 2,
    M1 is M - 1,
    directCoActorThroughMovie(A1, X, Movie),
    canReach3(X, A2, M1).

% Main predicate: canReachThrough2Movies
% Special case: both actors in one movie, and one actor also in the other movie
canReachThrough2Movies(A1, A2, Mov1, Mov2, M) :-
    M >= 1,
    not(Mov1 = Mov2),
    directCoActorThroughMovie(A1, A2, Mov2),
    actedIn(A1, Mov1, _).

canReachThrough2Movies(A1, A2, Mov1, Mov2, M) :-
    M >= 1,
    not(Mov1 = Mov2),
    directCoActorThroughMovie(A1, A2, Mov1),
    actedIn(A1, Mov2, _).

canReachThrough2Movies(A1, A2, Mov1, Mov2, M) :-
    M >= 1,
    not(Mov1 = Mov2),
    directCoActorThroughMovie(A1, A2, Mov2),
    actedIn(A2, Mov1, _).

canReachThrough2Movies(A1, A2, Mov1, Mov2, M) :-
    M >= 1,
    not(Mov1 = Mov2),
    directCoActorThroughMovie(A1, A2, Mov1),
    actedIn(A2, Mov2, _).

% Simple case: direct 2-step connection through both movies
canReachThrough2Movies(A1, A2, Mov1, Mov2, M) :-
    M >= 2,
    not(Mov1 = Mov2),
    directCoActorThroughMovie(A1, X, Mov1),
    directCoActorThroughMovie(X, A2, Mov2).

% Same movies but different order
canReachThrough2Movies(A1, A2, Mov1, Mov2, M) :-
    M >= 2,
    not(Mov1 = Mov2),
    directCoActorThroughMovie(A1, X, Mov2),
    directCoActorThroughMovie(X, A2, Mov1).

% Same movie twice - direct 2-step case for different actors
canReachThrough2Movies(A1, A2, Mov, Mov, M) :-
    M >= 2,
    directCoActorThroughMovie(A1, X, Mov),
    directCoActorThroughMovie(X, A2, Mov),
    not(A1 = A2).

% Same movie twice - self case with intermediate actor
canReachThrough2Movies(A, A, Mov, Mov, M) :-
    M >= 2,
    directCoActorThroughMovie(A, X, Mov),
    directCoActorThroughMovie(X, A, Mov).

% Extended case: use canReachThroughMovie for longer paths (only for different movies)
canReachThrough2Movies(A1, A2, Mov1, Mov2, M) :-
    M >= 3,
    not(Mov1 = Mov2),  % Only for different movies
    M1 is M // 2,
    M2 is M - M1,
    M1 >= 1,
    M2 >= 1,
    canReachThroughMovie(A1, X, Mov1, M1),
    canReachThroughMovie(X, A2, Mov2, M2),
    not(directCoActorThroughMovie(A1, X, Mov1)),  % Avoid duplicating simple cases
    not(directCoActorThroughMovie(X, A2, Mov2)).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW