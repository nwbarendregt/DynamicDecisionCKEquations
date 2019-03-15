function [acc,ps] = Clicks_Linear_Accuracy_Interrogation(kappa,lambda_m,gamma,D,h_o,h_t,t_0,dt,t_f,b,dy)

t = t_0:dt:t_f; y = -b:dy:b;
if rem(kappa,dy) ~=0
    error('Choice of \kappa does not follow grid spacing.')
end
lambda_p = lambda_m*exp(kappa);

p = NaN(length(t),2*length(y));
p(1,:) = 0; p(1,[(length(y)+1)/2,(length(y)+1)/2+length(y)]) = 0.5;

lambda_p_v = -dt*lambda_p*ones(length(y),1);
lambda_m_v = -dt*lambda_m*ones(length(y),1);

Ap = spdiags([lambda_p_v lambda_m_v],[-floor(kappa/dy) floor(kappa/dy)]...
    ,length(y),length(y));
Am = Ap';
A = sparse(2*length(y),2*length(y));
A(1:length(y),1:length(y))= Ap;
A((length(y)+1):end,(length(y)+1):end) = Am;
A(1,:) = 0; A(length(y),:) = 0; A(length(y)+1,:) = 0; A(end,:) = 0;
A(1,[1 2 3]) = [3*D/(2*dy)-gamma*b -2*D/dy D/(2*dy)];
A(length(y),[length(y)-2 length(y)-1 length(y)]) = [-D/(2*dy) -2*D/dy -3*D/(2*dy)+gamma*b];
A(length(y)+1,[length(y)+1 length(y)+2 length(y)+3]) = [3*D/(2*dy)-gamma*b -2*D/dy D/(2*dy)];
A(end,[end-2 end-1 end]) = [-D/(2*dy) -2*D/dy -3*D/(2*dy)+gamma*b];
for i = 2:(length(y)-1)
    A(i,i-1) = A(i,i-1)+dt*(-D+dy*h_o*gamma*y(i))/dy^2;
    A(i,i) = A(i,i)+1+2*D*dt/dy^2+dt*(h_t+lambda_m+lambda_p)-2*dt*h_o*gamma;
    A(i,i+1) = A(i,i+1)-dt*(D+dy*h_o*gamma*y(i))/dy^2;
    A(i,i+length(y)) = A(i,i+length(y))-dt*h_t;
end
for i = (length(y)+2):(2*length(y)-1)
    A(i,i-1) = A(i,i-1)+dt*(-D+dy*h_o*gamma*y(i-length(y)))/dy^2;
    A(i,i) = A(i,i)+1+2*D*dt/dy^2+dt*(h_t+lambda_m+lambda_p)-2*dt*h_o*gamma;
    A(i,i+1) = A(i,i+1)-dt*(D+dy*h_o*gamma*y(i-length(y)))/dy^2;
    A(i,i-length(y)) = A(i,i-length(y))-dt*h_t;
end

B = speye(2*length(y));
B(1,1) = 0; B(length(y),length(y)) = 0; B(length(y)+1,length(y)+1) = 0;
B(end,end) = 0;

for n = 2:length(t)
    p(n,:) = A\(B*p(n-1,:)');
end
pp = p(:,1:length(y)); pm = p(:,(length(y)+1):end);
acc = sum(pp(end,y>=0),2)+sum(pm(end,y<0),2);
ps = pp+flip(pm,2);