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
% Add the required statements in the correct section below.
% You should not use helper predicates for these queries.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%
%
% 
% Add your solution queries in section q1_movie_queries below. The argument in the query
% should be the answer to question given in natural language. Note that the first
% query does not have such an answer, which is why it has no argument. The constant 
% query1 will thus be true or false if the query is asked correctly.
%
% To test your queries, first compile this file in ECLiPSe. Doing so will first
% load your KB, and then create a rule for each query. You can then test a query
% (for example query 5), by entering the following in interactive mode.
%
% > query5(D).
%
% Note that the value assigned to each variable in the body of each rule is not 
% printed out. For example, if you have the following rule
%
% query99(X) :- pred1(Y), pred2(X, Y), pred3(Z).
%
% then calling query(X) will only print out X if it succeeds. Thus, for debugging,
% it may be useful to test your queries directly as
%
% > pred1(Y), pred2(X, Y), pred3(Z).
%
% as doing so will print the values of all of X, Y, and Z. However, ensure that your
% final submission follows the required format, and works as expected.




%%%%% SECTION: q1_movie_queries_kb_import
% The following line will import your movie KB. You can feel free to
% edit this line if you want to import and test on different KBs.
% We will ignore this section when testing your code, and instead test
% on our own KBs.
:- [q1_movie_kb].





%%%%% SECTION: q1_movie_years
% This section lists every year from 1900 to 2025, and identifies
% that they are a valid year for a movie. You may use this for
% formulating your queries. You do not need to edit this section.
% ANY CHANGES YOU MAKE WILL BE IGNORED.
year(1900). year(1901). year(1902). year(1903). year(1904). year(1905). year(1906). year(1907). year(1908). year(1909). 
year(1910). year(1911). year(1912). year(1913). year(1914). year(1915). year(1916). year(1917). year(1918). year(1919). 
year(1920). year(1921). year(1922). year(1923). year(1924). year(1925). year(1926). year(1927). year(1928). year(1929). 
year(1930). year(1931). year(1932). year(1933). year(1934). year(1935). year(1936). year(1937). year(1938). year(1939). 
year(1940). year(1941). year(1942). year(1943). year(1944). year(1945). year(1946). year(1947). year(1948). year(1949). 
year(1950). year(1951). year(1952). year(1953). year(1954). year(1955). year(1956). year(1957). year(1958). year(1959). 
year(1960). year(1961). year(1962). year(1963). year(1964). year(1965). year(1966). year(1967). year(1968). year(1969). 
year(1970). year(1971). year(1972). year(1973). year(1974). year(1975). year(1976). year(1977). year(1978). year(1979). 
year(1980). year(1981). year(1982). year(1983). year(1984). year(1985). year(1986). year(1987). year(1988). year(1989). 
year(1990). year(1991). year(1992). year(1993). year(1994). year(1995). year(1996). year(1997). year(1998). year(1999). 
year(2000). year(2001). year(2002). year(2003). year(2004). year(2005). year(2006). year(2007). year(2008). year(2009). 
year(2010). year(2011). year(2012). year(2013). year(2014). year(2015). year(2016). year(2017). year(2018). year(2019). 
year(2020). year(2021). year(2022). year(2023). year(2024). year(2025).





%%%%% SECTION: q1_movie_queries
% Enter your solution queries below
% By default, all queries currently succeed without answering the question correctly.
% They do so using the Prolog keyword "true". Below, we are using this as a placeholder.
% This keyword is not helpful beyond this use case and you should NOT use it in this
% assignment or any other unless explicitly told to. You should similarly never use the
% "false" keyword.

%%% QUERY 1: Did Steven Spielberg direct "Jaws"?
% For this query, use the constants steven_spielberg and jaws to refer to 
% Steven Spielberg and "Jaws", respectively.
query1 :- directedBy(jaws, steven_spielberg).


%%% QUERY 2: What character did Janelle Monae play in "Glass Onion"?
% For this query, use the constants janelle_monae and glass_onion to refer to
% Janelle Monae and Glass Onion, respectively.
query2(Character) :- actedIn(janelle_monae, glass_onion, Character).


%%% QUERY 3: Which actor was in both "Oppenheimer" and "Midsommar"?
% For this query, use the constants oppenheimer and midsommar to refer to
% Oppenheimer and Midsommar, respectively.
query3(Actor) :-
    actedIn(Actor, oppenheimer, _),
    actedIn(Actor, midsommar, _).


%%% QUERY 4: Did any actor who appeared in ``The Godfather", not appear in ``The Godfather Part II"?
% For this query, use the constants the_godfather and the_godfather_part_2, to refer
% to "The Godfather" and "The Godfather Part II", respectively.
query4(Actor) :-
    actedIn(Actor, the_godfather, _),
    not actedIn(Actor, the_godfather_part_2, _).


%%% QUERY 5: Did anyone direct a movie before 1980 and after 2010?
% Note that "before" and "after" are not inclusive
query5(Director) :-
    directedBy(Movie1, Director),
    releaseInfo(Movie1, Year1, _),
    directedBy(Movie2, Director),
    releaseInfo(Movie2, Year2, _),
    Year1 < 1980,
    Year2 > 2010.


%%% QUERY 6: Did any actor appear in more than one movie in 2023?
query6(Actor) :-
    actedIn(Actor, Movie1, _),
    releaseInfo(Movie1, 2023, _),
    actedIn(Actor, Movie2, _),
    releaseInfo(Movie2, 2023, _),
    not Movie1 = Movie2.


%%% QUERY 7: Did any actor appear in more than one movie in the same year that were all at least 3 hours long?
query7(Actor) :-
    actedIn(Actor, Movie1, _),
    releaseInfo(Movie1, Year, Duration1),
    actedIn(Actor, Movie2, _),
    releaseInfo(Movie2, Year, Duration2),
    Duration1 >= 180,
    Duration2 >= 180,
    not Movie1 = Movie2.


%%% QUERY 8: Is there a year from 2010 to 2019 (inclusive) in which Sarah Polley did not direct a movie?
% For this query, use the constant sarah_polley to refer to Sarah Polley
query8(Year) :-
    year(Year),
    Year >= 2010,
    Year =< 2019,
    not (directedBy(Movie, sarah_polley), releaseInfo(Movie, Year, _)).


%%% QUERY 9: Did anyone act in 3 movies that were released in 3 consecutive years?
query9(Actor) :-
    actedIn(Actor, Movie1, _),
    releaseInfo(Movie1, Year1, _),
    actedIn(Actor, Movie2, _),
    releaseInfo(Movie2, Year2, _),
    actedIn(Actor, Movie3, _),
    releaseInfo(Movie3, Year3, _),
    Year1 is Year2 - 1,
    Year2 is Year3 - 1.


%%% QUERY 10: What is the oldest movie in the knowledge base?
query10(Movie) :-
    releaseInfo(Movie, YearOldest, _),
    not (releaseInfo(_, Year, _), Year < YearOldest).


%%% QUERY 11: What is the longest movie that Cate Blanchett has acted in?
% For this query, use the constant cate_blanchett to refer to Cate Blanchett
query11(Movie) :-
    actedIn(cate_blanchett, Movie, _),
    releaseInfo(Movie, _, Duration),
    not (actedIn(cate_blanchett, Movie1, _), releaseInfo(Movie1, _, Duration1), Duration1 > Duration).



%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW
