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
% Add the required KB statements in the section below.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%


%%%%% SECTION: q2_kb
%%%%% You should put the atomic statements for your KB below

% cost(Product, Cost) - cost per unit
cost(milk, 4.50).
cost(tomato, 1.25).
cost(orange, 0.75).
cost(marshmallow, 3.00).
cost(ice_cream, 5.99).

% numPurchased(Product, Count) - number purchased
numPurchased(milk, 2).
numPurchased(tomato, 6).
numPurchased(orange, 4).
numPurchased(marshmallow, 3).
numPurchased(ice_cream, 1).

% twoForOneSale(Product)
twoForOneSale(tomato).
twoForOneSale(marshmallow).
twoForOneSale(orange).

% taxable(Product)
taxable(marshmallow).
taxable(ice_cream).

% taxRate(Rate)
taxRate(0.13).



%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW