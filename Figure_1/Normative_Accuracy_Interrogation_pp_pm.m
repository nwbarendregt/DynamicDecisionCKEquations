% Used to generate Fig 1C in manuscript.
function [pp,pm] = Normative_Accuracy_Interrogation_pp_pm(m,h_o,h_e,p_0,t_0,dt,t_f,b,dy)

t = t_0:dt:t_f;
y = -b:dy:b;
p = NaN(length(t),2*length(y)); p(1,:) = p_0;

A = sparse(2*length(y),2*length(y));
A(1,[1 2 3]) = [-3*m/dy/2+m+2*h_o*sinh(y(end))/h_e 2*m/dy -m/dy/2];
A(length(y),[length(y)-2 length(y)-1 length(y)]) = [m/dy/2 -2*m/dy 3*m/dy/2+m-2*h_o*sinh(y(end))/h_e];
A(length(y)+1,[length(y)+1 length(y)+2 length(y)+3]) = [-3*m/dy/2-m+2*h_o*sinh(y(end))/h_e 2*m/dy -m/dy/2];
A(end,[end-2 end-1 end]) = [m/dy/2 -2*m/dy 3*m/dy/2-m-2*h_o*sinh(y(end))/h_e];
for i = 2:(length(y)-1)
    A(i,i-1) = -dt*((2+dy)*m-2*dy*sinh(y(i)))/(2*dy^2);
    A(i,i) = 1+dt*(1+2*m/dy^2-2*cosh(y(i)));
    A(i,i+1) = dt*((dy-2)*m-2*dy*sinh(y(i)))/(2*dy^2);
    A(i,i+length(y)) = -dt*h_e;
end
for i = (length(y)+1):(2*length(y)-1)
    A(i,i-1) = dt*((-2+dy)*m+2*dy*sinh(y(i-length(y))))/(2*dy^2);
    A(i,i) = 1+dt*(1+2*m/dy^2-2*cosh(y(i-length(y))));
    A(i,i+1) = -dt*((dy+2)*m+2*dy*sinh(y(i-length(y))))/(2*dy^2);
    A(i,i-length(y)) = -dt*h_e;
end

B = speye(2*length(y));
B(1,1) = 0; B(length(y),length(y)) = 0; B(length(y)+1,length(y)+1) = 0;
B(end,end) = 0;

for n = 2:length(t)
    p(n,:) = A\(B*p(n-1,:)');
end

pp = p(:,1:length(y)); pm = p(:,(length(y)+1):end);