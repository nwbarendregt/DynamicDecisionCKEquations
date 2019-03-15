% Used to generate Fig 2C in manuscript.
clear

b = 10; t_0 = 0; t_f = 1; m = 50; h_o = [0.1 1 10]; h_e = 1;
dt = 0.001;

t = t_0:dt:t_f;
y = NaN(length(h_o),length(t)); y(:,1) = 0;
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

for i = 1:length(h_o)
    for j = 2:length(t)
        y(i,j) = y(i,j-1)+(m*g(j)-2*h_o(i)/h_e*sinh(y(i,j-1)))*dt+sqrt(2*m*dt)*dW(j);
    end
end
p1 = plot(t,y(1,:));
hold on
p2 = plot(t,y(2,:));
p3 = plot(t,y(3,:));
plot(t,zeros(1,length(t)),'k:')
xlabel('t'); ylabel('y');
legend([p1 p2 p3],{'h_o = 0.1','h_o = 1','h_o = 10'})
legend('boxoff')
set(gca,'YDir','normal')