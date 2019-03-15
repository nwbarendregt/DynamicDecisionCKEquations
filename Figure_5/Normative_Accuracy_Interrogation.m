% Used to generate Fig 2A,B,D,E in manuscript.
function [acc,p] = Normative_Accuracy_Interrogation(m,h_o,h_e,p_0,t_0,dt,t_f,b,dy)

t = t_0:dt:t_f;
y = -b:dy:b;
p = NaN(length(t),length(y)); p(1,:) = p_0;

A = sparse(length(y),length(y));
A(1,[1 2 3]) = [m-3*m/dy/2+2*h_o/h_e*sinh(y(end)) 2*m/dy -m/dy/2];
A(end,[end-2 end-1 end]) = [m/dy/2 -2*m/dy m+3*m/dy/2-2*h_o/h_e*sinh(y(end))];
for i = 2:(length(y)-1)
    A(i,i-1) = -dt*((2+dy)*m-2*dy*h_o/h_e*sinh(y(i)))/(2*dy^2);
    A(i,i) = 1+dt*(1+2*m/dy^2-2*h_o/h_e*cosh(y(i)));
    A(i,i+1) = dt*((dy-2)*m-2*dy*h_o/h_e*sinh(y(i)))/(2*dy^2);
    A(i,length(y)-i+1) = A(i,length(y)-i+1)-dt;
end

B = speye(length(y));
B(1,1) = 0; B(end,end) = 0;

for n = 2:length(t)
    p(n,:) = A\(B*p(n-1,:)');
end

acc = sum(p(end,y>=0));