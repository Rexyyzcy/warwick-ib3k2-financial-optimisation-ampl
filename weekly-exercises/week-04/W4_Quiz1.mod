
#part 0 Declariation of parameters:
param n;
set N := 1..n; #Nth project


param b{N}; #benefit from Nth project
param c{N}; #cost from Nth project

param B; #budget 




#Part 1 declaration of variables:
var x{N} binary; #whether Nth project is selected 



#Part 2 objective function:
maximize benefit: sum{i in N} b[i]*x[i];





#Part 3 Constraints:
subject to budget: sum{i in N} c[i]*x[i] <= B;

#Q2: Either project 1 or 2 or none
#subject to Q2: x[1]+x[2] <= 1;

#Q3:
subject to Q3: sum {i in N} x[i] <=7

