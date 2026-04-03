%%%%% Do NOT copy this file into pathfinding.pl
%%%%% Feel free to make new initial states for testing/debugging purposes
%%%%% However, we suggest to do so, you should create a new file and load it 
%%%%% instead of this one in pathfinding.pl
%%%%% DO NOT SUBMIT THIS FILE

% This situation consists of a 3x4 grid with 3 agents and 2 walls

numCols(3).
numRows(4).

wallAt(1, 1).
wallAt(2, 0).

agent(a1).
agent(a2).
agent(a3).

agentLoc(a1, 1, 0, []).
agentLoc(a2, 0, 2, []).
agentLoc(a3, 3, 1, [])


