function [acc,p] = Cubic_Accuracy_Interrogation(m,lambda_1,lambda_2,h_o,h_e,p_0,t_0,dt,t_f,b,dy)

t = t_0:dt:t_f;
y = -b:dy:b;
p = NaN(length(t),length(y)); p(1,:) = p_0;

A = sparse(length(y),length(y));
A(1,[1 2 3]) = [b*h_o*(lambda_1+b^2*lambda_2)/h_e+m*(3/(2*dy)+1) -2*m/dy m/(2*dy)];
A(end,[end-2 end-1 end]) = [-m/(2*dy) 2*m/dy -b*h_o*(lambda_1+b^2*lambda_2)/h_e-m*(3/(2*dy)-1)];
for i = 2:(length(y)-1)
    A(i,i-1) = dt*(-(2+dy)*h_e*m+dy*h_o*y(i)*(lambda_1+lambda_2*y(i)^2))/(2*dy^2*h_e);
    A(i,i) = 1+dt*(h_e+2*m/dy^2-h_o*(lambda_1+3*lambda_2*y(i)^2)/h_e);
    A(i,i+1) = dt*((-2+dy)*h_e*m-dy*h_o*y(i)*(lambda_1+lambda_2*y(i)^2))/(2*dy^2*h_e);
    A(i,length(y)-i+1) = A(i,length(y)-i+1)-dt*h_e;
end

B = speye(length(y));
B(1,1) = 0; B(end,end) = 0;

for n = 2:length(t)
    p(n,:) = A\(B*p(n-1,:)');
end

p = p(end,:);
acc = sum(p(end,y>=0));