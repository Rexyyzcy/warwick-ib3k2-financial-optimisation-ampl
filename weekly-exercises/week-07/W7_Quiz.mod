#Robust portfolio allocation model (model from Task without transaction

#part 0 Declariation of parameters:
param U; 
set u := 1..U; #Type of securities from 1 to U

param I; 
set i := 1..I; #rival return scenarios

param J; 
set j := 1..J; #rival risk scenarios


#risk aversion parameter Alpha
param Alpha; 
param AlphaRange{1..11}; 

#Rival rate of return u_i for security u in scenario i
param u_i{u,i}; 

#V-C matrix in scenario 1 and scenatio 2
param VC_Matrix_S1{u,u}; 
param VC_Matrix_S2{u,u};


#Part 1 declaration of variables:
var w{u}>=0; #Weight of asset u in the portfolio, no short-sell

var Beta; # Worst-case return
var Lemda; #Worst-case risk



#Part 2 objective function:
maximize RO_Portfolio: Alpha*Beta-(1-Alpha)*Lemda;

#Part 3 Constraints:
subject to Weight: sum{a in u} w[a] = 1; #sum of all weights = 1
subject to Worst_Case_Return{k in i}: sum{a in u} u_i[a,k]*w[a] >= Beta;

subject to Worst_Case_risk1: sum{a in u, d in u} (w[a]*VC_Matrix_S1[a,d]*w[d]) <= Lemda;
subject to Worst_Case_risk2: sum{a in u, d in u} (w[a]*VC_Matrix_S2[a,d]*w[d]) <= Lemda;
 
 
 