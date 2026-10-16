
#Portfolio Dedication 

#part 0 Declariation of parameters:
param T; param n; 
set t := 1..T; #time from 1 to T
set A := 1..n; #Asset from 1 to n

param f{A,t}; #Cashflow from asset A in time t
param L{t}; #Liability at time t
param p{A}; #Price of asset A


#Part 1 declaration of variables:
var x{A} >= 0, integer; #Amount of asset A purchased


#Part 2 objective function:
minimize Cost: sum{i in A} p[i]*x[i];  #Total cost of portfolio





#Part 3 Constraints:
subject to TotalCost: sum{i in A} (x[i]*p[i]-p[i]*x[i]) >=0; #not sure!!!
subject to PayBackLiability{j in t}: sum{i in A} f[i,j]*x[i] >= L[j];
#at most 1 project from each goal