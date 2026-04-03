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
% Add the required statements in the q4b_bacon section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%

%%%%% SECTION: q4b_movie_kb_import
% The following line will import a file called "movie_kb.pl". 
% Thus, you can create such a file to test your program.
% You can feel free tovedit this line if you want to import and test 
% on different KBs. We will ignore this section when testing your code, 
% and instead test on our own KBs.
:- [movie_kb].



%%%%% SECTION: q4b_rules
%%%%% You should put your rules in this section, including helper predicates.
%%%%% Predicate definition: canReachThroughMovies(A1, A2, M, TargetMovies, ActPath, MoviePath)
%  empty TargetMovies
canReachThroughMovies(A1, A2, M, [], ActPath, MoviePath) :-
    M >= 0,
    pathFinder(A1, A2, M, [A1], [], ActPath, MoviePath).

% non-empty TargetMovies 
canReachThroughMovies(A1, A2, M, TargetMovies, ActPath, MoviePath) :-
    length(TargetMovies, TL), TL > 0,     
    M >= 0,
    pathFinder(A1, A2, M, [A1], [], ActPath, MoviePath),
    length(ActPath, L), L > 1,          
    includesAllMovies(TargetMovies, MoviePath).

% Base case
pathFinder(A, A, _, ActAcc, MovieAcc, ActPath, MoviePath) :-
    actedIn(A, _, _),   
    reverse(ActAcc, ActPath),
    reverse(MovieAcc, MoviePath).

% Recursive case
pathFinder(A1, A2, M, ActAcc, MovieAcc, ActPath, MoviePath) :-
    M > 0,
    actedIn(A1, Movie, _),
    not(member(Movie, MovieAcc)),         
    actedIn(A3, Movie, _),
    not(member(A3, ActAcc)),           
    M1 is M - 1,
    pathFinder(A3, A2, M1, [A3|ActAcc], [Movie|MovieAcc], ActPath, MoviePath).

% Check if all target movies are in the path
includesAllMovies([], _).
includesAllMovies([Movie|Rest], MoviePath) :-
    member(Movie, MoviePath),
    includesAllMovies(Rest, MoviePath).


%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW