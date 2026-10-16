#Scenario based Asset-Liability Management (ALM)

#part 0 Declariation of parameters:
param U; 
set m := 1..U; #Type of securities from 1 to U, where m=1 is the risk-free asset

param T; 
set t := 1..T; #time t

param K;	#K scenarios at final stage, all nodes in N2
set k:= 1..K; 

param N1; #there are 3 scenarios from t=0 to t=1
set s1:= 1..N1;
param N2; #there are 2 scenarios from each 3 scenario at t=1 to t=2
set s2:= 1..N2;

param parent{1..6};

param r2{k,m};

param L{t}; #Liability

param wage{t}; #Wage 

param w0;#Initial wealth

#Transaction costs for buying and selling 
param Cb;
param Cs;

param P{k}; #prabability at final stage in scenario k


#Return 
param r1{s1,m}; #t=1, at 0,0
param r2_11{s2,m}; #t=2, at 1,1 {s2=2,m}, implies s1=1
param r2_12{s2,m}; #t=2, at 1,2 {s2=2,m}, implies s1=2
param r2_13{s2,m}; #t=2, at 1,3 {s2=2,m}, implies s1=3


#Part 1 declaration of variables:

#Amoiunt invested in at Time 0
#<=4500 corresponds to diversification limit
var h0{m} >=0, <=4500; #holding in asset m at time t=0, m=0,1,2
#Time 1
var h1{s1,m}>=0 ,<=4500; #holding in asset m in time t=1 for s1 scenario, m=0,1,2
#Time 2
var h2{k,m}>=0 ,<=4500; 

#Amount sell and buy, Time0
#<=1000 refer to upper limit for buying and selling
#Time 1
var S1{s1,2..3}>=0,<=1000;
var B1{s1,2..3}>=0,<=1000;
#Time 2
#var S21{s2,2..3}>=0,<=1000; #from a(e)=(1,1) 
#var S22{s2,2..3}>=0,<=1000; #from a(e)=(1,2) 
#var S23{s2,2..3}>=0,<=1000; #from a(e)=(1,3) 
#var B21{s2,2..3}>=0,<=1000;
#var B22{s2,2..3}>=0,<=1000;
#var B23{s2,2..3}>=0,<=1000;

var S2{k,2..3}>=0,<=1000;
var B2{k,2..3}>=0,<=1000;

var gamma{t}>=0;#Contribution of wage

#Part 2 objective function: Maximise expected portfolio holding at T=2
maximize ExpectedPortfolioHolding: sum{z in k}(P[z]*(sum{i in m}h2[z,i]));


#Part 3 Constraints:

#Initial wealth, t=0
subject to InitialWealth: sum{i in m}h0[i]=w0;

#Balance for risky assests m=1,2 at t=1
subject to Riskyt1{j in s1,i in 2..3}: h1[j,i]=h0[i]*(1+r1[j,i])-S1[j,i]+B1[j,i] ;
#Balance for risky assests m=1,2, at t=2
#expended form for all 6 nodes in t=2
#subject to Riskyt21{i in 2..3}: h2[1,i]=h1[1,i]*(1+r2_11[1,i])-S21[1,i]+B21[1,i];
#subject to Riskyt22{i in 2..3}: h2[2,i]=h1[1,i]*(1+r2_11[2,i])-S21[2,i]+B21[2,i];
#subject to Riskyt23{i in 2..3}: h2[3,i]=h1[2,i]*(1+r2_12[1,i])-S22[1,i]+B22[1,i];
#subject to Riskyt24{i in 2..3}: h2[4,i]=h1[2,i]*(1+r2_12[2,i])-S22[2,i]+B22[2,i];
#subject to Riskyt25{i in 2..3}: h2[5,i]=h1[3,i]*(1+r2_13[1,i])-S23[1,i]+B23[1,i];
#subject to Riskyt26{i in 2..3}: h2[6,i]=h1[3,i]*(1+r2_13[2,i])-S23[2,i]+B23[2,i];

## !! return matrix needs to be re-construxted
subject to Riskyt2{i in 2..3,j in 1..6}: h2[j,i]=h1[parent[j],i]*(1+r2[j,i])-S2[j,i]+B2[j,i];

#Balance for risk-free asset m=0, at t=1
subject to RiskFree1{j in s1}: h1[j,1]=h0[1]*(1+r1[j,1])+sum{i in 2..3}((1-Cs)*S1[j,i])-sum{i in 2..3}((1+Cb)*B1[j,i])-L[1]+gamma[1]*wage[1] ;
#Balance for risk-free assests m=0, at t=2
#expended form for all 6 nodes in t=2
#subject to RiskFree21: h2[1,1]=h1[1,1]*(1+r2_11[1,1])+sum{i in 2..3}((1-Cs)*S21[1,i])-sum{i in 2..3}((1+Cb)*B21[1,i])-L[2]+gamma[2]*wage[2];
#subject to RiskFree22: h2[2,1]=h1[1,1]*(1+r2_11[2,1])+sum{i in 2..3}((1-Cs)*S21[2,i])-sum{i in 2..3}((1+Cb)*B21[2,i])-L[2]+gamma[2]*wage[2];
#subject to RiskFree23: h2[3,1]=h1[2,1]*(1+r2_12[1,1])+sum{i in 2..3}((1-Cs)*S22[1,i])-sum{i in 2..3}((1+Cb)*B22[1,i])-L[2]+gamma[2]*wage[2];
#subject to RiskFree24: h2[4,1]=h1[2,1]*(1+r2_12[2,1])+sum{i in 2..3}((1-Cs)*S22[2,i])-sum{i in 2..3}((1+Cb)*B22[2,i])-L[2]+gamma[2]*wage[2];
#subject to RiskFree25: h2[5,1]=h1[3,1]*(1+r2_13[1,1])+sum{i in 2..3}((1-Cs)*S23[1,i])-sum{i in 2..3}((1+Cb)*B23[1,i])-L[2]+gamma[2]*wage[2];
#subject to RiskFree26: h2[6,1]=h1[3,1]*(1+r2_13[2,1])+sum{i in 2..3}((1-Cs)*S23[2,i])-sum{i in 2..3}((1+Cb)*B23[2,i])-L[2]+gamma[2]*wage[2];

subject to RiskFree2{j in k}:h2[j,1] = h1[parent[j],1]*(1+r2[j,1])+sum{i in 2..3}((1-Cs)*S2[j,i])-sum{i in 2..3}((1+Cb)*B2[j,i])-L[2]+gamma[2]*wage[2];