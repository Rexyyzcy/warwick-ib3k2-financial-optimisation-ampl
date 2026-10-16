
#part 0 Declariation of parameters:
param n; 
set N := 1..n;

param p{N};
param q{N};

param C; 




#Part 1 declaration of variables:
var x{N} >=0, integer;
var b >= 0;



#Part 2 objective function:
#maximize yield: p_1*x_1+p_2*x_2;
maximize return: (sum{j in N} (q[j]-p[j])*x[j])/C;





#Part 3 Constraints:
subject to budget: sum{j in N} p[j]*x[j] +b = C;
subject to capacity{j in N}: p[j]*x[j]  <= 0.2*C;