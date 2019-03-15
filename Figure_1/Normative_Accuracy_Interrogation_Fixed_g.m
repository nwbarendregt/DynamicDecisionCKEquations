% Used to generate Fig 1A in manuscript.
function [acc,p] = Normative_Accuracy_Interrogation_Fixed_g(m,g,h_o,h_e,p_0,t_0,dt,t_f,b,dy)

t = t_0:dt:t_f;
y = -b:dy:b;
acc = NaN(length(t),1); acc(1) = 0.5;
p = NaN(length(t),length(y)); p(1,:) = p_0;
A = sparse(length(y),length(y));
B = speye(length(y));
B(1,1) = 0; B(end,end) = 0;

for n = 2:length(t)
    A(1,[1 2 3]) = [-3*m/dy/2+m*g(n)+2*h_o*sinh(y(end))/h_e 2*m/dy -m/dy/2];
    A(end,[end-2 end-1 end]) = [m/dy/2 -2*m/dy 3*m/dy/2+m*g(n)-2*h_o*sinh(y(end))/h_e];
    for i = 2:(length(y)-1)
        A(i,i-1) = -dt*(2*m+dy*m*g(n)-2*dy*h_o/h_e*sinh(y(i)))/(2*dy^2);
        A(i,i) = 1+2*dt*m/dy^2-2*dt*h_o/h_e*cosh(y(i));
        A(i,i+1) = dt*(dy*m*g(n)-2*(m+dy*h_o/h_e*sinh(y(i))))/(2*dy^2);
    end
    p(n,:) = A\(B*p(n-1,:)');
    acc(n) = sum(p(n,sign(y)==g(n)));
end
