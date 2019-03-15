function [acc,p] = Normative_Sensory_Accuracy_Interrogation(m,D,h_o,h_e,p_0,t_0,dt,t_f,b,dy)

t = t_0:dt:t_f;
y = -b:dy:b;
p = NaN(length(t),length(y)); p(1,:) = p_0;

A = sparse(length(y),length(y));
A(1,[1 2 3]) = [m-3*(D+m)/(2*dy)+2*h_o*sinh(b)/h_e 2*(D+m)/dy -(D+m)/(2*dy)];
A(end,[end-2 end-1 end]) = [(D+m)/(2*dy) -2*(D+m)/dy m+3*(D+m)/(2*dy)-2*h_o*sinh(b)/h_e];
for i = 2:(length(y)-1)
    A(i,i-1) = -dt*(h_e*(2*D+(2+dy)*m)-2*dy*h_o*sinh(y(i)))/(2*dy^2*h_e);
    A(i,i) = 1+dt*(2*D+dy^2+2*m)/dy^2-2*dt*h_o*cosh(y(i))/h_e;
    A(i,i+1) = dt*(h_e*(-2*D+(-2+dy)*m)-2*dy*h_o*sinh(y(i)))/(2*dy^2*h_e);
    A(i,length(y)-i+1) = A(i,length(y)-i+1)-dt;
end

B = speye(length(y));
B(1,1) = 0; B(end,end) = 0;

for n = 2:length(t)
    p(n,:) = A\(B*p(n-1,:)');
end

acc = sum(p(end,y>=0));