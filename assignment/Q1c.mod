# PART 0 DECLARATION OF PARAMETERS

#securities n under consideration, only with 1, 2, 3, and 4-year maturities
param N;
set n := 1..N; 
#number of years
param T;
set t := 1..T; 

param p{n}; #current price of bonds

param C{t}; #Future cash requirements

param f{t,n}; #Cash inflow arising from asset n in time t

param S4;	#S4 scenarios at final stage t=4
set s4:= 1..S4;

param P{s4}; #prabability at final stage for each scenario in s4

param b{t,s4}; #borrowing rate at time t for each scenario in s4
param r{t,s4}; #loan interest rate at time t for each scenario in s4

# PART 1 DECLARATION OF VARIABLES
var x{n} >= 0; #investment on bonds
var z{0..T,s4} >= 0; #cash on hand at time t in each final scenario s4
var B{0..T,s4} >= 0; # borrowed amount at time t in each final scenario s4
var Loan{0..T,s4} >= 0; #loan amount at time t in each final scenario s4

# PART 2 OBJECTIVE FUNCTION

#In order to achieve a bounded solution, first use objective 'MinCost' 
#The optimal solution from first run will be set to RHS in constraint 'capital' (68255)
#Then use objective 'finalcash' 

minimize MinCost:sum{j in n}p[j]*x[j];
#maximize finalcash: sum{k in s4}z[4,k]*P[k];


# PART 3 CONSTRAINTS

subject to initial{k in s4}: z[0,k] = 0;

#The value of the upperbound Lemda on RHS is the optimal solution for objective MinCost above
subject to capital: sum{a in n} p[a]*x[a] <= 68255;
 
subject to liability{j in t, k in s4}:sum{a in n}f[j,a]*x[a]+z[j-1,k]-z[j,k]+ B[j,k]+ Loan[j,k]-((1+b[j,k])*B[j-1,k])-((1+r[j,k])*Loan[j-1,k])>= C[j];

subject to borrowing1{k in s4}: B[0,k] =0;
subject to borrowing2{k in s4}: Loan[0,k] =0;
subject to borrowing3{k in s4}: B[T,k] =0;
subject to borrowing4{k in s4}: Loan[T,k] =0;

