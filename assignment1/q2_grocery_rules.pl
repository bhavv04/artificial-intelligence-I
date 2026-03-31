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
% Add the required statements in the q2_rules section below.
% Any helper predicates should also be added to that section.
% Do NOT delete, edit, or add SECTION headers.
% If you put statements in the wrong section, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY 
% the already included comment lines below
%

%%%%% SECTION: q2_kb_import
% The following line will import your grocery KB. You can feel free to
% edit this line if you want to import and test on different KBs.
% We will ignore this section when testing your code, and instead test
% on our own KBs.
:- [q2_grocery_kb].


%%%%% SECTION: q2_rules
%%%%% You should put your rules in this section, including helper predicates.

% costPerUnitAfterTax(Product, AfterTax) - cost per unit after tax
costPerUnitAfterTax(Product, AfterTax) :-
    cost(Product, Cost),
    taxable(Product),
    taxRate(Rate),
    AfterTax is Cost * (1 + Rate).

costPerUnitAfterTax(Product, Cost) :-
    cost(Product, Cost),
    not(taxable(Product)).

% Helper predicate for sale calculation - taxable items
calculateSalePriceTaxable(Product, Quantity, TotalAfterSale) :-
    twoForOneSale(Product),
    cost(Product, Cost),
    taxRate(Rate),
    FullPriceUnits is Quantity // 2 + Quantity mod 2,
    TotalAfterSale is FullPriceUnits * Cost * (1 + Rate).

calculateSalePriceTaxable(Product, Quantity, TotalAfterSale) :-
    not(twoForOneSale(Product)),
    cost(Product, Cost),
    taxRate(Rate),
    TotalAfterSale is Quantity * Cost * (1 + Rate).

% Helper predicate for sale calculation of non-taxable items
calculateSalePriceNonTaxable(Product, Quantity, TotalAfterSale) :-
    twoForOneSale(Product),
    cost(Product, Cost),
    FullPriceUnits is Quantity // 2 + Quantity mod 2,
    TotalAfterSale is FullPriceUnits * Cost.

calculateSalePriceNonTaxable(Product, Quantity, TotalAfterSale) :-
    not(twoForOneSale(Product)),
    cost(Product, Cost),
    TotalAfterSale is Quantity * Cost.

% costPerProductAfterTaxAndSale(Product, AfterSaleAndTax) - total for purchased items
costPerProductAfterTaxAndSale(Product, AfterSaleAndTax) :-
    numPurchased(Product, Quantity),
    taxable(Product),
    calculateSalePriceTaxable(Product, Quantity, AfterSaleAndTax).

costPerProductAfterTaxAndSale(Product, AfterSaleAndTax) :-
    numPurchased(Product, Quantity),
    not(taxable(Product)),
    calculateSalePriceNonTaxable(Product, Quantity, AfterSaleAndTax).

% totalCost(Cost) - total cost for all five items
totalCost(TotalCost) :-
    costPerProductAfterTaxAndSale(milk, MilkCost),
    costPerProductAfterTaxAndSale(tomato, TomatoCost),
    costPerProductAfterTaxAndSale(orange, OrangeCost),
    costPerProductAfterTaxAndSale(marshmallow, MarshmallowCost),
    costPerProductAfterTaxAndSale(ice_cream, IceCreamCost),
    TotalCost is MilkCost + TomatoCost + OrangeCost + MarshmallowCost + IceCreamCost.


%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW