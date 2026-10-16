#Scenario based Cash flow Matching

#part 0 Declariation of parameters:
param U; 
set u := 1..U; #Type of securities from 1 to U

param T; 
set t := 1..T; #time t

param K;		#K scenarios at final stage
set k:= 1..K; 

param S1; #there are 3 scenarios from t=0 to t=1
set s1:= 1..S1;
param S2; #there are 2 scenarios from each 3 scenario at t=1 to t=2
set s2:= 1..S2;


#Return 
param r1{s1,u}; #t=1, at 0,0
param r2_11{s2,u}; #t=2, at 1,1 {k=2,u}, implies s1=1
param r2_12{s2,u}; #t=2, at 1,2 {k=2,u}, implies s1=2
param r2_13{s2,u}; #t=2, at 1,3 {k=2,u}, implies s1=3

#param r2{k,u};

param L{t}; #Liability

param P{k}; #prabability at final stage in scenario k


param w0;#Initial wealth


#Part 1 declaration of variables:

#Amoiunt invested in at time 0
var x0{u} >=0;

var x1{s1,u}>=0; #amount invested in at time 1 for asset u in 3 different scenarios
var x21{s2,u}>=0; #amount invested in at time 2 for asset u at 1,1, implies s1=1
var x22{s2,u}>=0; #amount invested in at time 2 for asset u at 1,1, implies s1=2
var x23{s2,u}>=0; #amount invested in at time 2 for asset u at 1,1, implies s1=3

var w_T{k} >=0;#Final Wealth in k scenarios!!!!



#Part 2 objective function: Maximise expected return across scenarios
maximize ExpectedReturn: sum{z in k}(P[z]*w_T[z]);



#Part 3 Constraints:

#Initial wealth, t=0
subject to InitialWealth: sum{i in u}x0[i]=w0;

#t=1
subject to t1{z in s1}: (sum{i in u} (x0[i]*r1[z,i]) - L[1] = sum{i in u}x1[z,i]);

#t=2, T 
#subject to t21{z in s2}: (sum {i in u} (x1[1,i]*r2_11[z,i]) - L[2] = sum{j in 1..2}w_T[j]);
#subject to t22{z in s2}: (sum {i in u} (x1[2,i]*r2_12[z,i]) - L[2] = sum{j in 3..4}w_T[j]);
#subject to t23{z in s2}: (sum {i in u} (x1[3,i]*r2_13[z,i]) - L[2] = sum{j in 5..6}w_T[j]);
 
subject to t21: sum {i in u} (x1[1,i]*r2_11[1,i]) - L[2] = w_T[1];
subject to t22: sum {i in u} (x1[1,i]*r2_11[2,i]) - L[2] = w_T[2];
subject to t23: sum {i in u} (x1[2,i]*r2_12[1,i]) - L[2] = w_T[3];
subject to t24: sum {i in u} (x1[2,i]*r2_12[2,i]) - L[2] = w_T[4];
subject to t25: sum {i in u} (x1[3,i]*r2_13[1,i]) - L[2] = w_T[5];
subject to t26: sum {i in u} (x1[3,i]*r2_13[2,i]) - L[2] = w_T[6];

subject to Diversification{i in u}: x0[i]<=0.4*w0;
 