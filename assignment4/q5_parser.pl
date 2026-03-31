% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Parsa Kermani Pour
%%%%% NAME: Bhavdeep Arora
%%%%% NAME: Arshia Sharifi
%
% This file contains the parser that you should edit for Q5.
% The code below is the same as in original_parser.pl
%
% Ensure your lexicon works with just the parser in original_parser.pl.
% Further, ensure all your edits are in the augmented_parser section
% If you put the rules anywhere else, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: augmented_parser
%%%%% Edit the following files for the functionality needed in q5
%%%%% Any helpers needed for editing the parser should also be included below.

/* Helper predicate to find the oldest item that satisfies all constraints already applied */
findOldest(What) :-
    releaseInfo(What, Year, _),
    not((releaseInfo(Other, OtherYear, _),
         not(What = Other),
         OtherYear < Year)).

/* Helper to check if a value is between two bounds (exclusive) */
isBetween(Value, Low, High) :-
    Value > Low,
    Value < High.

/* Noun phrase can be a proper name or can start with an article */
np([Name], Name) :- proper_noun(Name).
np([Art | Rest], What) :- article(Art), np2(Rest, What).

/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */

/* Handle "oldest" adjective specially - it must be first */
np2([oldest | Rest], What) :- 
    np2(Rest, What),
    releaseInfo(What, Year, _),
    not((np2(Rest, Other),
         not(What = Other),
         releaseInfo(Other, OtherYear, _),
         OtherYear < Year)).

np2([Adj | Rest], What) :- adjective(Adj, What), np2(Rest, What).
np2([Noun | Rest], What) :- common_noun(Noun, What), mods(Rest, What).

/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).
mods(Words, What) :-
	append(Start, End, Words),
	prepPhrase(Start, What), mods(End, What).

/* Handle "between X and Y" as a direct prepositional phrase */
prepPhrase([between | Rest], What) :-
    append(LowPart, [and | HighPart], Rest),
    np(LowPart, Low),
    np(HighPart, High),
    isBetween(What, Low, High).

/* Handle nested "with ... between" structure */
prepPhrase([with, a, Noun, between | Rest], What) :-
    append(LowPart, [and | HighPart], Rest),
    np(LowPart, Low),
    np(HighPart, High),
    common_noun(Noun, Ref),
    isBetween(Ref, Low, High),
    movie(What),
    releaseInfo(What, Ref, _).

prepPhrase([with, a, Noun, between | Rest], What) :-
    append(LowPart, [and | HighPart], Rest),
    np(LowPart, Low),
    np(HighPart, High),
    common_noun(Noun, Ref),
    isBetween(Ref, Low, High),
    movie(What),
    releaseInfo(What, _, Ref).

prepPhrase([with, the, Noun, between | Rest], What) :-
    append(LowPart, [and | HighPart], Rest),
    np(LowPart, Low),
    np(HighPart, High),
    common_noun(Noun, Ref),
    isBetween(Ref, Low, High),
    movie(What),
    releaseInfo(What, Ref, _).

prepPhrase([with, the, Noun, between | Rest], What) :-
    append(LowPart, [and | HighPart], Rest),
    np(LowPart, Low),
    np(HighPart, High),
    common_noun(Noun, Ref),
    isBetween(Ref, Low, High),
    movie(What),
    releaseInfo(What, _, Ref).

/* Standard prepositional phrases */
prepPhrase([Prep | Rest], What) :-
	preposition(Prep, What, Ref), np(Rest, Ref).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Q5 TEST INTERACTION LOG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- [movie_q_and_a_system].
% Yes (0.05s cpu)

%%%%%% TEST 1: Between with years (exclusive - only 2021)
% ?- what([a, movie, with, a, release_year, between, 2020, and, 2022], M).
% M = dune
% Yes (0.00s cpu, solution 1, maybe more)
% No (0.00s cpu)

%%%%%% TEST 2: Between with length using literal numbers
% ?- what([a, film, with, a, length, between, 100, and, 130], M).
% M = fury_road
% Yes (0.00s cpu, solution 1, maybe more)
% M = get_out
% Yes (0.00s cpu, solution 2, maybe more)
% M = hereditary
% Yes (0.00s cpu, solution 3, maybe more)
% M = the_whale
% Yes (0.00s cpu, solution 4, maybe more)
% M = mickey_17
% Yes (0.00s cpu, solution 5, maybe more)
% M = training_day
% Yes (0.00s cpu, solution 6, maybe more)
% M = past_lives
% Yes (0.00s cpu, solution 7, maybe more)
% No (0.00s cpu)

%%%%%% TEST 3: Between with reference to another movies length
% ?- what([a, film, with, a, length, between, the, length, of, fury_road, and, 200], M).
% M = parasite
% Yes (0.00s cpu, solution 1, maybe more)
% M = the_fabelmans
% Yes (0.00s cpu, solution 2, maybe more)
% M = dune
% Yes (0.00s cpu, solution 3, maybe more)
% M = everything_everywhere_all_at_once
% Yes (0.02s cpu, solution 4, maybe more)
% M = the_batman
% Yes (0.02s cpu, solution 5, maybe more)
% M = knives_out
% Yes (0.02s cpu, solution 6, maybe more)
% M = knives_out
% Yes (0.02s cpu, solution 7, maybe more)
% M = oppenheimer
% Yes (0.02s cpu, solution 8, maybe more)
% M = hereditary
% Yes (0.02s cpu, solution 9, maybe more)
% M = nope
% Yes (0.02s cpu, solution 10, maybe more)
% M = nope
% Yes (0.02s cpu, solution 11, maybe more)
% M = training_day
% Yes (0.02s cpu, solution 12, maybe more)
% No (0.02s cpu)

%%%%%% TEST 4: Between with smaller year range
% ?- what([a, movie, with, a, release_year, between, 2016, and, 2018], M).
% M = get_out
% Yes (0.00s cpu, solution 1, maybe more)
% No (0.00s cpu)

%%%%%% TEST 5: Between with narrow length range
% ?- what([a, movie, with, a, length, between, 150, and, 160], M).
% M = the_fabelmans
% Yes (0.00s cpu, solution 1, maybe more)
% M = dune
% Yes (0.00s cpu, solution 2, maybe more)
% No (0.00s cpu)

%%%%%% TEST 6: Oldest movie overall
% ?- what([the, oldest, movie], M).
% M = the_red_balloon
% Yes (0.00s cpu, solution 1, maybe more)
% No (0.00s cpu)

%%%%%% TEST 7: Oldest horror movie
% ?- what([the, oldest, horror, movie], M).
% M = get_out
% Yes (0.00s cpu, solution 1, maybe more)
% No (0.00s cpu)

%%%%%% TEST 8: Oldest action movie
% ?- what([the, oldest, action, movie], M).
% M = fury_road
% Yes (0.00s cpu, solution 1, maybe more)
% No (0.00s cpu)

%%%%%% TEST 9: Oldest drama movie
% ?- what([the, oldest, drama, movie], M).
% M = the_red_balloon
% Yes (0.00s cpu, solution 1, maybe more)
% No (0.00s cpu)

%%%%%% TEST 10: Oldest scifi movie
% ?- what([the, oldest, scifi, movie], M).
% M = fury_road
% Yes (0.00s cpu, solution 1, maybe more)
% No (0.00s cpu)

%%%%%% TEST 11: Three hour movies (>=180 minutes)
% ?- what([a, three_hour, movie], M).
% M = oppenheimer
% Yes (0.00s cpu, solution 1, maybe more)
% M = lord_of_the_rings_the_return_of_the_king
% Yes (0.00s cpu, solution 2, maybe more)
% No (0.00s cpu)

%%%%%% TEST 12: Short movies (<60 minutes)
% ?- what([a, short, movie], M).
% M = the_red_balloon
% Yes (0.00s cpu, solution 1, maybe more)
% No (0.00s cpu)

%%%%%% TEST 13: New movies (from 2025)
% ?- what([a, new, movie], M).
% M = mickey_17
% Yes (0.00s cpu, solution 1, maybe more)
% M = past_lives
% Yes (0.00s cpu, solution 2, maybe more)
% No (0.00s cpu)

%%%%%% TEST 14: Oldest movie by specific director
% ?- what([the, oldest, bong_joon_ho, movie], M).
% M = parasite
% Yes (0.00s cpu, solution 1, maybe more)
% M = parasite
% Yes (0.00s cpu, solution 2, maybe more)
% No (0.00s cpu)

%%%%%% TEST 15: Oldest fantasy movie
% ?- what([the, oldest, fantasy, movie], M).
% M = the_red_balloon
% Yes (0.00s cpu, solution 1, maybe more)
% No (0.00s cpu)

%%%%%% TEST 16: Between with year range 2021-2024 (returns 2022 and 2023)
% ?- what([a, movie, with, a, release_year, between, 2021, and, 2024], M).
% M = the_fabelmans
% Yes (0.00s cpu, solution 1, maybe more)
% M = the_fabelmans
% Yes (0.00s cpu, solution 2, maybe more)
% M = the_fabelmans
% Yes (0.00s cpu, solution 3, maybe more)
% M = the_fabelmans
% Yes (0.00s cpu, solution 4, maybe more)
% M = the_fabelmans
% Yes (0.00s cpu, solution 5, maybe more)
% M = everything_everywhere_all_at_once
% Yes (0.00s cpu, solution 6, maybe more)
% M = everything_everywhere_all_at_once
% Yes (0.00s cpu, solution 7, maybe more)
% M = everything_everywhere_all_at_once
% Yes (0.00s cpu, solution 8, maybe more)
% M = everything_everywhere_all_at_once
% Yes (0.00s cpu, solution 9, maybe more)
% M = everything_everywhere_all_at_once
% Yes (0.00s cpu, solution 10, maybe more)
% M = the_batman
% Yes (0.00s cpu, solution 11, maybe more)
% M = the_batman
% Yes (0.00s cpu, solution 12, maybe more)
% M = the_batman
% Yes (0.00s cpu, solution 13, maybe more)
% M = the_batman
% Yes (0.00s cpu, solution 14, maybe more)
% M = the_batman
% Yes (0.00s cpu, solution 15, maybe more)
% M = oppenheimer
% Yes (0.00s cpu, solution 16, maybe more)
% M = nope
% Yes (0.00s cpu, solution 17, maybe more)
% M = nope
% Yes (0.00s cpu, solution 18, maybe more)
% M = nope
% Yes (0.00s cpu, solution 19, maybe more)
% M = nope
% Yes (0.00s cpu, solution 20, maybe more)
% M = nope
% Yes (0.00s cpu, solution 21, maybe more)
% M = the_whale
% Yes (0.00s cpu, solution 22, maybe more)
% M = the_whale
% Yes (0.00s cpu, solution 23, maybe more)
% M = the_whale
% Yes (0.00s cpu, solution 24, maybe more)
% M = the_whale
% Yes (0.00s cpu, solution 25, maybe more)
% M = the_whale
% Yes (0.00s cpu, solution 26, maybe more)
% No (0.00s cpu)

%%%%%% TEST 17: Oldest comedy movie
% ?- what([the, oldest, comedy, movie], M).
% M = parasite
% Yes (0.00s cpu, solution 1, maybe more)
% M = knives_out
% Yes (0.00s cpu, solution 2, maybe more)
% No (0.00s cpu)

%%%%%% TEST 18: Oldest movie by specific director with prepositional phrase
% ?- what([the, oldest, movie, by, jordan_peele], M).
% M = get_out
% Yes (0.00s cpu, solution 1, maybe more)
% M = get_out
% Yes (0.00s cpu, solution 2, maybe more)
% No (0.00s cpu)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% END OF Q5 TEST INTERACTION LOG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%