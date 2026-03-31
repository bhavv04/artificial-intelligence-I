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
% Add the required statements in the q6_rules section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%

%%%%% SECTION: q6_trees
%%%%% This section contains the tree given as an example in the assignment PDF.
%%%%% You can use it in a query as follows:
%%%%%
%%%%% ?- testTree(1, X), highestCostPath(X, Cost, Path).
%%%%% Feel free to add other test trees as you so choose in this section for your
%%%%% own testing. We will ignore this section as part of your submission so
%%%%% DO NOT put any helper predicates below.
testTree(1, 
    tree3(a,  % The root node has name a
            2, tree3(b, % Left child of a is b and can be reached with cost 2 
                    3, tree3(e, 0, none, 0, none, 0, none),   % Left child of b is e. It is a leaf node
                    5, tree3(f, 0, none, 0, none, 0, none),   % Middle child of b is f. It is a leaf node
                    0, none  % There is no right childe of b
                    ),
            3, tree3(c, 0, none, 0, none, 0, none),  % Middle child of a is c. It is a leaf node
            1, tree3(d,   % Right child of a is d
                    2, tree3(g, 0, none, 0, none,   % Left child of d is g. It has no left or middle child
                            1, tree3(h, 0, none, 0, none, 0, none)),   % The right child of g is h. It is a leaf node
                    0, none, 0, none  % d has no middle or right children
                    )
        )
).

% Top 9 challenging test cases (plus original test 1 = 10 total)

% Test 2: Single node (trivial base case)
testTree(2,
    tree3(a, 0, none, 0, none, 0, none)
).

% Test 3: Wide root with ties - multiple equal max leaves
testTree(3,
    tree3(root,
        5, tree3(l1, 0, none, 0, none, 0, none),
        5, tree3(l2, 0, none, 0, none, 0, none),
        5, tree3(l3, 0, none, 0, none, 0, none)
    )
).

% Test 4: Deep winner vs shallow candidates
testTree(4,
    tree3(r,
        2, tree3(a,
            2, tree3(b,
                8, tree3(deepwin, 0, none, 0, none, 0, none),
                0, none,
                0, none
            ),
            0, none,
            0, none
        ),
        6, tree3(shallow, 0, none, 0, none, 0, none),
        1, tree3(other, 0, none, 0, none, 0, none)
    )
).

% Test 5: Zero-cost backbone with one small branch winner
testTree(5,
    tree3(root,
        0, tree3(mid1,
            0, tree3(mid2,
                0, tree3(mid3, 0, none, 0, none, 1, tree3(leaf1,0,none,0,none,0,none)),
                0, none,
                0, none
            ),
            0, none,
            0, none
        ),
        0, none,
        0, tree3(side, 2, tree3(sideLeaf,0,none,0,none,0,none), 0, none, 0, none)
    )
).

% Test 6: Asymmetric deep ties across branches
testTree(6,
    tree3(root,
        3, tree3(left,
            2, tree3(la, 1, tree3(laa,0,none,0,none,0,none), 0, none, 0, none),
            0, none,
            0, none
        ),
        1, tree3(mid, 4, tree3(midLeaf,0,none,0,none,0,none), 0, none, 0, none),
        3, tree3(right,
            0, none,
            2, tree3(rb, 1, tree3(rbb,0,none,0,none,0,none), 0, none, 0, none),
            0, none
        )
    )
).

% Test 7: Single long chain (depth stress test)
testTree(7,
    tree3(n1,
        1, tree3(n2,
            1, tree3(n3,
                1, tree3(n4,
                    1, tree3(n5, 
                        10, tree3(leafDeep,0,none,0,none,0,none),
                        0, none,
                        0, none),
                    0, none,
                    0, none),
                0, none,
                0, none),
            0, none,
            0, none),
        0, none,
        0, none)
).

% Test 8: Four-way equivalent paths (multiple ties)
testTree(8,
    tree3(hub,
        8, tree3(direct, 0, none, 0, none, 0, none),
        4, tree3(split1,
            4, tree3(end_a, 0, none, 0, none, 0, none),
            0, none,
            0, none
        ),
        2, tree3(split2,
            6, tree3(end_b, 0, none, 0, none, 0, none),
            0, none,
            0, none
        )
    )
).

% Test 9: Deep path beats shallow - deceptive shallow trap
testTree(9,
    tree3(start,
        9, tree3(shallow_trap, 0, none, 0, none, 0, none),  % Looks good but only cost 9
        2, tree3(deeper_route,
            3, tree3(middle,
                8, tree3(deep_winner, 0, none, 0, none, 0, none),  % 2+3+8=13 > 9
                1, tree3(deep_loser, 0, none, 0, none, 0, none),   % 2+3+1=6 < 9
                0, none
            ),
            0, none,
            0, none
        ),
        1, tree3(another_trap, 0, none, 0, none, 0, none)   % Only cost 1
    )
).

% Test 10: Very deep exploration needed (5 levels) - ultimate stress test
testTree(10,
    tree3(level1,
        12, tree3(shallow_best, 0, none, 0, none, 0, none),     % Cost 12 - seems great
        1, tree3(level2,
            1, tree3(level3,
                1, tree3(level4,
                    1, tree3(level5,
                        20, tree3(ultimate_prize, 0, none, 0, none, 0, none), % 1+1+1+1+20=24 > 12
                        0, none,
                        0, none
                    ),
                    0, none,
                    0, none
                ),
                0, none,
                0, none
            ),
            0, none,
            0, none
        ),
        0, none
    )
).

%%%%% SECTION: q6_rules
%%%%% You should put your rules in this section, including helper predicates.
%%%%% Predicate definition: highestCostPath(Tree, PathCost, PathList)

% Base Cases
highestCostPath(none, 0, []).                                        % For when trying to traverse null nodes (basically sends you back with nothing)
highestCostPath(tree3(Name, 0, none, 0, none, 0, none), 0, [Name]).  % For when you get to a leaf node

% Recursive Cases

% If the left subtree yields the highest cost
highestCostPath(Tree, PathCost, [Name | PathListLeft]) :-
    Tree = tree3(Name, LeftCost, Left, MiddleCost, Middle, RightCost, Right),
    not Left = none,
    % recursive call for all subtrees
    highestCostPath(Left, PathCostLeft, PathListLeft),
    highestCostPath(Middle, PathCostMiddle, PathListMiddle),
    highestCostPath(Right, PathCostRight, PathListRight),
    % checks that the left subtree yields the highest cost
    (PathCostLeft + LeftCost) >= (PathCostMiddle + MiddleCost),
    (PathCostLeft + LeftCost) >= (PathCostRight + RightCost),
    % adds left subtree cost + left node cost to overall cost of the path
    PathCost is PathCostLeft + LeftCost.

% If the middle subtree yields the highest cost
highestCostPath(Tree, PathCost, [Name | PathListMiddle]) :-
    Tree = tree3(Name, LeftCost, Left, MiddleCost, Middle, RightCost, Right),
    not Middle = none,
    highestCostPath(Left, PathCostLeft, PathListLeft),
    highestCostPath(Middle, PathCostMiddle, PathListMiddle),
    highestCostPath(Right, PathCostRight, PathListRight),
    (PathCostMiddle + MiddleCost) >= (PathCostLeft + LeftCost),
    (PathCostMiddle + MiddleCost) >= (PathCostRight + RightCost),
    PathCost is PathCostMiddle + MiddleCost.

% If the right subtree yields the highest cost
highestCostPath(Tree, PathCost, [Name | PathListRight]) :-
    Tree = tree3(Name, LeftCost, Left, MiddleCost, Middle, RightCost, Right),
    not Right = none,
    highestCostPath(Left, PathCostLeft, PathListLeft),
    highestCostPath(Middle, PathCostMiddle, PathListMiddle),
    highestCostPath(Right, PathCostRight, PathListRight),
    (PathCostRight + RightCost) >= (PathCostLeft + LeftCost),
    (PathCostRight + RightCost) >= (PathCostMiddle + MiddleCost),
    PathCost is PathCostRight + RightCost.

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW