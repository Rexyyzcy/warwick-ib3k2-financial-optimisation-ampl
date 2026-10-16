#Markovtz Model

#part 0 Declariation of parameters:
param U; 
set u := 1..U; #Type of securities from 1 to U

param u_i{u};	#Expected rate of return for each asset

param VC_Matrix{u,u}; #V-C matrix


param Exp_r_p; #r_p bar, expected portfolio return

param w0{u}; #Current holding of asset u


#Part 1 declaration of variables:
var w{u}>=0; #Weight of asset u in the portfolio, no short-sell
var y{u}>=0; #amount of asset bought
var z{u}>=0; #amount of asset sold



#Part 2 objective function:
#min W^t * V-C * W
minimize PortfolioRisk: sum{i in u, j in u} w[i]*VC_Matrix[i,j]*w[j]; 

#Part 3 Constraints:
subject to Weight: sum{i in u} w[i] = 1; #sum of all weights = 1
#subject to DesiredPortfolioReturn : sum{i in u} u_i[i]*w[i] >= 0.15;

subject to DesiredPortfolioReturn: sum{i in u} (u_i[i]*w[i]-0.0125*y[i]-0.0125*z[i]) >= 0.15;
subject to Bought {i in u}: w[i]-w0[i]<= y[i];
subject to Sold {i in u}: w0[i]-w[i]<= z[i];


var sum_expression{u}= sum{i in u} (-0.0125*y[i]-0.0125*z[i]);