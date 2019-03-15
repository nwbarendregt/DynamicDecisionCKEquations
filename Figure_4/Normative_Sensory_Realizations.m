% Used to generate Fig 4A in manuscript.
clear

b = 10; t_0 = 0; t_f = 1; m = 10; D = [0 1 10 100];
h_o = 1; h_e = 1;
dt = 0.001;

t = t_0:dt:t_f;
y = NaN(length(D),length(t)); y(:,1) = 0;
g = NaN(1,length(t));

g(1:floor((2*length(t)/16))) = 1;
g(floor(2*length(t)/16+1):floor(3*length(t)/16)) = -1;
g(floor(3*length(t)/16+1):floor(5*length(t)/16)) = 1;
g(floor(5*length(t)/16+1):floor(9*length(t)/16)) = -1;
g(floor(9*length(t)/16+1):floor(12*length(t)/16)) = 1;
g(floor(12*length(t)/16+1):floor(14*length(t)/16)) = -1;
g(floor(14*length(t)/16+1):floor(15*length(t)/16)) = 1;
g(floor(15*length(t)/16+1):end) = -1;

dW_m = randn(1,length(t));
dW_D = randn(1,length(t));

for i = 1:length(D)
    for j = 2:length(t)
        y(i,j) = y(i,j-1)+(m*g(j)-2*h_o/h_e*sinh(y(i,j-1)))*dt+sqrt(2*m*dt)*dW_m(j)+sqrt(2*D(i)*dt)*dW_D(j);
    end
end
p1 = plot(t,y(1,:));
hold on
p2 = plot(t,y(2,:));
p3 = plot(t,y(3,:));
p4 = plot(t,y(4,:));
plot(t,zeros(1,length(t)),'k:')
legend([p1 p2 p3 p4],{'D = 0','D = 1','D = 10','D = 100'})
legend('boxoff')
set(gca,'YDir','normal')