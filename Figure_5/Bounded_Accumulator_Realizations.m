% Used to generate Fig 5A in manuscript.
clear

beta = [1 3 5]; t_0 = 0; t_f = 1; m = 50;
dt = 0.01;

t = t_0:dt:t_f;
y = NaN(length(beta),length(t)); y(:,1) = 0;
g = NaN(1,length(t));

g(1:floor((2*length(t)/16))) = 1;
g(floor(2*length(t)/16+1):floor(3*length(t)/16)) = -1;
g(floor(3*length(t)/16+1):floor(5*length(t)/16)) = 1;
g(floor(5*length(t)/16+1):floor(9*length(t)/16)) = -1;
g(floor(9*length(t)/16+1):floor(12*length(t)/16)) = 1;
g(floor(12*length(t)/16+1):floor(14*length(t)/16)) = -1;
g(floor(14*length(t)/16+1):floor(15*length(t)/16)) = 1;
g(floor(15*length(t)/16+1):end) = -1;

dW = randn(1,length(t));

for i = 1:length(beta)
    for j = 2:length(t)
        y(i,j) = y(i,j-1)+m*g(j)*dt+sqrt(2*m*dt)*dW(j);
        if y(i,j) > beta(i)
            y(i,j) = beta(i);
        elseif y(i,j) < -beta(i)
            y(i,j) = -beta(i);
        end
    end
end
p1 = plot(t,y(1,:));
hold on
p2 = plot(t,y(2,:));
p3 = plot(t,y(3,:));
plot(t,ones(1,length(t))*beta(1),'--')
plot(t,-ones(1,length(t))*beta(1),'--')
plot(t,ones(1,length(t))*beta(2),'--')
plot(t,-ones(1,length(t))*beta(2),'--')
plot(t,ones(1,length(t))*beta(3),'--')
plot(t,-ones(1,length(t))*beta(3),'--')
set(gca,'YDir','normal')