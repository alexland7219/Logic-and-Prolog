% 18. Consider two groups of 10 people each. In the first group, as expected, the percentage of people
% with lung cancer among smokers is higher than among non-smokers. In the second group, the
% same is the case. But if we consider the 20 people of the two groups together, then the situation
% is the opposite: the proportion of people with lung cancer is higher among non-smokers than
% among smokers! Can this be true? Write a little Prolog program to find it out.


main(SC1, NC1, SH1, NH1, SC2, NC2, SH2, NH2) :-  size(SC1, NC1, SH1, NH1), size(SC2, NC2, SH2, NH2), S1 is SC1 + SH1, N1 is NC1 + NH1,
percent(SC1, S1, S1PERC), percent(NC1, N1, N1PERC), S1PERC > N1PERC, S2 is SC2 + SH2, N2 is NC2 + NH2, percent(SC2, S2, S2PERC), 
percent(NC2, N2, N2PERC), S2PERC > N2PERC, percent(SC1 + SC2, S1 + S2, SPERC), percent(NC1 + NC2, N1+N2, NPERC), NPERC > SPERC.

possibleValues(L) :- L = [0,1,2,3,4,5,6,7,8,9,10].

size(SC, NC, SH, NH) :- possibleValues(L), member(SC, L), member(NC, L), member(SH, L), member(NH, L), X is SC + NC + SH + NH, X is 10.

percent(X, T, R) :- T > 0, R is X / T.