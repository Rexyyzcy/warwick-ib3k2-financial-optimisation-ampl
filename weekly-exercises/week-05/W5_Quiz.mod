#Portfolio Dedication  min Convexity(risk)

#part 0 Declariation of parameters:
param T; param U; 
set t := 1..T; #time from 1 to T
set u := 1..U; #Universe of securities from 1 to n

param C{u,t}; #Cashflow from security U at time t
param i_u{u};#YTM at time t for each bond u=8

param L{t};  #Liability at time t
param i_L{t};#Liability rates at time t

param P_L := sum{a in t}(L[a]/(1+i_L[a])^a); #PV of liabilities
param k_L := sum{a in t} (-a*L[a]/(1+i_L[a])^(a+1)); #Duration of liabilities
param Q_L := sum{a in t} (a*(a+1)*L[a]/(1+i_L[a])^(a+2)); #Convexity of liabilities


#param P{U}; #Present Value of secutiry U
param P{j in u} := sum{a in t} (C[j,a]/(1+i_u[j])^a); #PV of bond in U

#param k{U}; #Duration of secutiry U
param k{j in u} := sum{a in t} (-a*C[j,a]/(1+i_u[j])^(a+1)); #duratioin

#param Q{U}; #Convexity of secutiry U
param Q{j in u}:= sum{a in t} (a*(a+1)*C[j,a]/(1+i_u[j])^(a+2)); #Convexity of bond in U



#Part 1 declaration of variables:
var x{u} >= 0; #Amount of Security U purchased




#Part 2 objective function:
#maximize Yield: sum{j in u} k[j]*i_u[j]*x[j];  #Maximise total portfolio yield
minimize Convexity: sum{j in u} Q[j]*x[j]; # Minimise convexity


#Part 3 Constraints:
subject to PV: sum{j in u} P[j]*x[j] = P_L; 
subject to Duration: sum{j in u} k[j]*x[j] = k_L;
subject to Conve: sum{j in u} Q[j]*x[j] >= Q_L;
