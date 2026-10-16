#part 0 Declariation of parameters:
param U; 
set u := 1..U; #Type of stocks from 1 to U, 

param T; 
set t := 1..T; #time t

param S9;	#S9 scenarios at stage t=9
set s9:= 1..S9; 

param w0;#Initial wealth, capital budget
param G; #goal of investment at the end

param b;#cost of borrowing

param P{s9}; #prabability at final stage in scenario s9

#Since the scenario tree has 9 periods but only 4 scenarios at final stage
#modofy return at time t for stock u in all 4 combinations of scenarios to final stage
param r91{t,u}; #return for each node for scenario up to (9,1)
param r92{t,u}; #return for each node for scenario up to (9,2)
param r93{t,u}; #return for each node for scenario up to (9,3)
param r94{t,u}; #return for each node for scenario up to (9,4)


#Part 1 declaration of variables:
var x0{u}>=0;
var x3{u,s9}>=0;
var x6{u,s9}>=0;
var x9{u,s9}>=0;

var B{s9}>=0;
var w_T{s9} >=0;#Final Wealth in s9 scenarios!!!!



#Part 2 objective function: Maximise expected  wealth at T=9
maximize ExpectedWealth_MinExpCost: sum{k in s9}P[k]*(w_T[k]-b*B[k]);


#Part 3 Constraints:
subject to initial: sum {i in u}x0[i]=w0; #initial budget constraint

#For the scenario 1 at time 9
subject to S91_t3: sum {i in u}x3[i,1]=sum {i in u}(x0[i]*(1+r91[1,i])*(1+r91[2,i])*(1+r91[3,i]));
subject to S91_t6: sum {i in u}x6[i,1]=sum {i in u}(x3[i,1]*(1+r91[4,i])*(1+r91[5,i])*(1+r91[6,i]));
subject to S91_t9: sum {i in u}x9[i,1]=sum {i in u}(x6[i,1]*(1+r91[7,i])*(1+r91[8,i])*(1+r91[9,i]));
#For the scenario 2 at time 9
subject to S92_t3: sum {i in u}x3[i,2]=sum {i in u}(x0[i]*(1+r92[1,i])*(1+r92[2,i])*(1+r92[3,i]));
subject to S92_t6: sum {i in u}x6[i,2]=sum {i in u}(x3[i,2]*(1+r92[4,i])*(1+r92[5,i])*(1+r92[6,i]));
subject to S92_t9: sum {i in u}x9[i,2]=sum {i in u}(x6[i,2]*(1+r92[7,i])*(1+r92[8,i])*(1+r92[9,i]));
#For the scenario 3 at time 9
subject to S93_t3: sum {i in u}x3[i,3]=sum {i in u}(x0[i]*(1+r93[1,i])*(1+r93[2,i])*(1+r93[3,i]));
subject to S93_t6: sum {i in u}x6[i,3]=sum {i in u}(x3[i,3]*(1+r93[4,i])*(1+r93[5,i])*(1+r93[6,i]));
subject to S93_t9: sum {i in u}x9[i,3]=sum {i in u}(x6[i,3]*(1+r93[7,i])*(1+r93[8,i])*(1+r93[9,i]));
#For the scenario 4 at time 9
subject to S94_t3: sum {i in u}x3[i,4]=sum {i in u}(x0[i]*(1+r94[1,i])*(1+r94[2,i])*(1+r94[3,i]));
subject to S94_t6: sum {i in u}x6[i,4]=sum {i in u}(x3[i,4]*(1+r94[4,i])*(1+r94[5,i])*(1+r94[6,i]));
subject to S94_t9: sum {i in u}x9[i,4]=sum {i in u}(x6[i,4]*(1+r94[7,i])*(1+r94[8,i])*(1+r94[9,i]));

subject to FinalWealth{j in s9}: sum {i in u}x9[i,j] = w_T[j];
subject to goal{j in s9}: w_T[j]+B[j]>=G;