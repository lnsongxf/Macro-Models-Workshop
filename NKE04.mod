%--------------------------------------------------------------------------
% Modelo presentado en Clarida, Gali y Gertler (1999).
% Politica monetaria optima con compromiso, comando ramsey_policy.
% Codigo elaborado por: Carlos Rojas Quiroz
%--------------------------------------------------------------------------

var ygap inom pic g u;
varexo ghat uhat;
parameters alpha phi sigma psi beta lambda gamma_pic Psi rho mu q;

phi         =0.60;
alpha       =0.50;
sigma       =1.00;
psi         =0.75; 
beta        =0.99;
rho         =0.75;
mu          =0.75;
lambda      =phi*psi*(1-(1-psi)*beta)/(1-psi);
Psi         =1/sigma;
gamma_pic   =1+(1-rho)*lambda/(rho*Psi*alpha); 
q           =1/(lambda^2+alpha*(1-beta*rho));

model(linear);
ygap    =ygap(+1)-Psi*(inom-pic(+1))+g;
pic     =beta*pic(+1)+lambda*ygap+u;
g       =mu*g(-1)+ghat;
u       =rho*u(-1)+uhat;
end;

shocks;
var ghat; stderr 0.01;
var uhat; stderr 0.01;
end;


planner_objective pic^2 + alpha*ygap^2;

ramsey_policy(planner_discount=0.99,instruments=(inom), nograph, irf=40);
