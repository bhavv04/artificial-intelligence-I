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

%%%%% SECTION: current_year
%%%%% This section defined the current year
%%%%% You can edit it if you want to test your code with different current years
%%%%% However, our autograder will ignore everything in this section

currentYear(2025).


%%%%% SECTION: kb_import
%%%%% This section simply imports the movie KB file.
%%%%% You may edit it to toggle between different KBs for testing.
%%%%% However, our autograder will ignore everything in this section

:- [movie_kb].



%%%%% SECTION: lexicon_and_helpers
%%%%% Put the rules/statements defining articles, adjectives, proper nouns, common nouns,
%%%%% and prepositions in this section.
%%%%% You should also put your the helpers described in q2 in this part.
%%%%% You may introduce other helpers for defining your lexicon as you see fit.
%%%%% DO NOT INCLUDE ANY KB atomic statements in this section. 
%%%%% Those should appear in movie_kb.pl

movie(Name) :- releaseInfo(Name, _, _).
actor(Name) :- actedIn(Name, _, _).
director(Name) :- directedBy(_, Name).
character(Name) :- actedIn(_, _, Name).
genre(Genre) :- movieGenre(_, Genre).
releaseYear(Year) :- releaseInfo(_, Year, _).
movieLength(Length) :- releaseInfo(_, _, Length).

newDirector(Director) :- currentYear(Current), directedBy(Movie, Director), releaseInfo(Movie, Year, _), not ((directedBy(MovieBefore, Director), releaseInfo(MovieBefore, YearBefore, _), YearBefore <Current)).

newActor(Name) :- currentYear(Current), actedIn(Name, Movie, _), releaseInfo(Movie, Year, _), not((actedIn(Name, MovieBefore, _), releaseInfo(MovieBefore, YearBefore, _), YearBefore < Current)).

genreDirector(Name, Genre) :- movieGenre(Movie1, Genre),movieGenre(Movie2, Genre), directedBy(Movie1, Name), directedBy(Movie2, Name), not(Movie1 = Movie2).

genreActor(Name, Genre) :- movieGenre(Movie1, Genre), movieGenre(Movie2, Genre), actedIn(Name, Movie1, _), actedIn(Name, Movie2, _), not(Movie1 = Movie2). 

% Articles
article(a).
article(an).
article(the).
article(any).

% Proper nouns - movies, actors, directors, characters
proper_noun(Name) :- movie(Name).
proper_noun(Name) :- actor(Name).
proper_noun(Name) :- director(Name).
proper_noun(Name) :- character(Name).
proper_noun(X) :- number(X).  

% Common nouns
common_noun(movie, Name) :- movie(Name).
common_noun(film, Name) :- movie(Name).  
common_noun(actor, Name) :- actor(Name).
common_noun(director, Name) :- director(Name).
common_noun(character, Name) :- character(Name).
common_noun(length, Name) :- movieLength(Name).  
common_noun(running_time, Name) :- movieLength(Name).  
common_noun(genre, Name) :- genre(Name).  
common_noun(release_year, Name) :- releaseYear(Name).  

% Adjectives for genres 
adjective(thriller, Name) :- movie(Name), movieGenre(Name, thriller).
adjective(drama, Name) :- movie(Name), movieGenre(Name, drama).
adjective(comedy, Name) :- movie(Name), movieGenre(Name, comedy).
adjective(scifi, Name) :- movie(Name), movieGenre(Name, scifi).
adjective(action, Name) :- movie(Name), movieGenre(Name, action).
adjective(crime, Name) :- movie(Name), movieGenre(Name, crime).
adjective(horror, Name) :- movie(Name), movieGenre(Name, horror).
adjective(mystery, Name) :- movie(Name), movieGenre(Name, mystery).
adjective(biography, Name) :- movie(Name), movieGenre(Name, biography).
adjective(fantasy, Name) :- movie(Name), movieGenre(Name, fantasy).
adjective(adventure, Name) :- movie(Name), movieGenre(Name, adventure).
adjective(romance, Name) :- movie(Name), movieGenre(Name, romance).

% Adjectives for new directors/actors
adjective(new, Name) :- newDirector(Name).
adjective(new, Name) :- newActor(Name).

% Adjectives for genre specialization
adjective(thriller, Name) :- director(Name), genreDirector(Name, thriller).
adjective(drama, Name) :- director(Name), genreDirector(Name, drama).
adjective(comedy, Name) :- director(Name), genreDirector(Name, comedy).
adjective(scifi, Name) :- director(Name), genreDirector(Name, scifi).
adjective(action, Name) :- director(Name), genreDirector(Name, action).
adjective(crime, Name) :- director(Name), genreDirector(Name, crime).
adjective(horror, Name) :- director(Name), genreDirector(Name, horror).
adjective(mystery, Name) :- director(Name), genreDirector(Name, mystery).
adjective(biography, Name) :- director(Name), genreDirector(Name, biography).
adjective(fantasy, Name) :- director(Name), genreDirector(Name, fantasy).
adjective(adventure, Name) :- director(Name), genreDirector(Name, adventure).
adjective(romance, Name) :- director(Name), genreDirector(Name, romance).

adjective(thriller, Name) :- actor(Name), genreActor(Name, thriller).
adjective(drama, Name) :- actor(Name), genreActor(Name, drama).
adjective(comedy, Name) :- actor(Name), genreActor(Name, comedy).
adjective(scifi, Name) :- actor(Name), genreActor(Name, scifi).
adjective(action, Name) :- actor(Name), genreActor(Name, action).
adjective(crime, Name) :- actor(Name), genreActor(Name, crime).
adjective(horror, Name) :- actor(Name), genreActor(Name, horror).
adjective(mystery, Name) :- actor(Name), genreActor(Name, mystery).
adjective(biography, Name) :- actor(Name), genreActor(Name, biography).
adjective(fantasy, Name) :- actor(Name), genreActor(Name, fantasy).
adjective(adventure, Name) :- actor(Name), genreActor(Name, adventure).
adjective(romance, Name) :- actor(Name), genreActor(Name, romance).
adjective(three_hour, Name) :- movie(Name), releaseInfo(Name, _, Length), Length >= 180.
adjective(short, Name) :- movie(Name), releaseInfo(Name, _, Length), Length < 60.
adjective(new, Name) :- movie(Name), currentYear(Year), releaseInfo(Name, Year, _).
adjective(Name, Movie) :- director(Name), directedBy(Movie, Name).
adjective(Name, Movie) :- actor(Name), actedIn(Name, Movie, _).

% Prepositions
preposition(with, Movie, Actor) :- actedIn(Actor, Movie, _).
preposition(with, Movie, Character) :- actedIn(_, Movie, Character).
preposition(in, Actor, Movie) :- actedIn(Actor, Movie, _).
preposition(in, Character, Movie) :- actedIn(_, Movie, Character).
preposition(by, Movie, Director) :- directedBy(Movie, Director).
preposition(from, Movie, Year) :- releaseInfo(Movie, Year, _).
preposition(released_in, Movie, Year) :- releaseInfo(Movie, Year, _).
preposition(played_by, Character, Actor) :- actedIn(Actor, _, Character).
preposition(of, Length, Movie) :- releaseInfo(Movie, _, Length).
preposition(of, Year, Movie) :- releaseInfo(Movie, Year, _).


%%%%% SECTION: parser_import
%%%%% This section imports the parser. By default, it imports the 
%%%%% original parser. To test your edited parser, comment out the first
%%%%% line and uncomment the second. Your code should work when only one
%%%%% of these is uncommented at any time, as our autograder will only
%%%%% import the original parser or q5_parser depended on which part of
%%%%% the assignment is being graded.

% :- [original_parser].
:- [q5_parser].



%%%%% SECTION: define_what
%%%%% This section defines the "what" predicate used for interacting with
%%%%% your program. It includes a convenient form of the "what" predicate
%%%%% that takes in a string instead of a list of words as atoms

% The usual "what" call, but ensures a list is provided
what(Words, Ref) :- is_list(Words), np(Words, Ref).


% Allows for queries like 'what("the steven_spielberg movie from 2022", X)'
% Simply tokenizes the strong, converts the strings to atoms, and calls what
% on the list of atoms.
what(WordsString, Ref) :- string(WordsString),
   atom_list_from_string(WordsString, Words), what(Words, Ref).


%% Helpers for what with words
% Converts string either to atom or number
convert_string(String, Num) :- number_string(Num, String).
convert_string(String, Atom) :- not number_string(_, String), atom_string(Atom, String).

% Converts a list of strings to a list of atoms
strings_to_atoms([], []).
strings_to_atoms([String | RestStrings], [X | RestAtoms]) :-
   convert_string(String, X), strings_to_atoms(RestStrings, RestAtoms).

% Takes in a string where words are separated by spaces, and finds a list
% of atoms corresponding to that string.
% ie. " hello    world how are  you   " becomes [hello, world, how, are, you]
atom_list_from_string(WordsString, AtomList) :-
   split_string(WordsString, " ", " ", WordList), strings_to_atoms(WordList, AtomList).
   
   



