function [acc,p] = Bounded_Accumulator_Accuracy_Interrogation(m,beta,dy)
y = -beta:dy:beta;
q = sqrt(1+2/m);
C_2 = (2*beta*((q-1)*(exp(q*beta)+m*sinh(q*beta)/(q*beta))...
    -(q+1)*(m*q-(m+1))*exp(-q*beta)))^-1;
p = 1/(2*beta)-C_2*(m*(q-1)*sinh(q*beta))/(q*beta)+...
    C_2*(exp(q*y)+(m*q-(m+1))*exp(-q*y));
acc = 1/2-C_2*(m*(q-1)*sinh(q*beta))/q+...
    C_2/q*(exp(q*beta)-1+(m*q-(m+1))*(1-exp(-q*beta)));

