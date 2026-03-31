%%%%% Do NOT copy this file into pathfinding.pl
%%%%% Feel free to make new initial states for testing/debugging purposes
%%%%% However, we suggest to do so, you should create a new file and load it 
%%%%% instead of this one in pathfinding.pl
%%%%% DO NOT SUBMIT THIS FILE

% This situation consists of a 5x5 grid seen in Figure 1 of the assignment PDF

numCols(5).
numRows(5).

wallAt(1, 2).
wallAt(2, 0).
wallAt(2, 1).
wallAt(2, 3).
wallAt(4, 3).

agent(a1).
agent(a2).
agent(a3).
agent(a4).
agent(a5).

agentLoc(a1, 0, 2, []).
agentLoc(a2, 0, 3, []).
agentLoc(a3, 0, 4, []).
agentLoc(a4, 1, 1, []).
agentLoc(a5, 3, 2, []).

