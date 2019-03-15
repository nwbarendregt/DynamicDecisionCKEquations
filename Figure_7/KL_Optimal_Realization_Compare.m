% Used to generate Fig. 7A in manuscript.

clear

b = 15; t_0 = 0; t_f = 1; m = 50;
h_o = 1; h_e = 1;
dy = 0.001; dt = 0.001;

t = t_0:dt:t_f;
y = NaN(4,length(t)); y(:,1) = 0;
g = NaN(1,length(t));

g(1:floor((2*length(t)/16))) = 1;
g(floor(2*length(t)/16+1):floor(3*length(t)/16)) = -1;
g(floor(3*length(t)/16+1):floor(5*length(t)/16)) = 1;
g(floor(5*length(t)/16+1):floor(9*length(t)/16)) = -1;
g(floor(9*length(t)/16+1):floor(12*length(t)/16)) = 1;
g(floor(12*length(t)/16+1):floor(14*length(t)/16)) = -1;
g(floor(14*length(t)/16+1):floor(15*length(t)/16)) = 1;
g(floor(15*length(t)/16+1):end) = -1;

beta = 5.57348223482235; lambda = 15.9183673469388; lambda_1 = 2.04081632653061; lambda_2 = 0.816326530612245;
dW = randn(1,length(t));

for i = 1:(length(t)-1)
    y(1,i+1) = y(1,i)+(m*g(i+1)-2*h_o/h_e*sinh(y(1,i)))*dt+sqrt(2*m*dt)*dW(i);
    y(2,i+1) = y(2,i)+(m*g(i+1)-lambda*y(2,i))*dt+sqrt(2*m*dt)*dW(i);
    y(3,i+1) = y(3,i)+(m*g(i+1)-lambda_1*y(3,i)-lambda_2*y(3,i)^3)*dt+sqrt(2*m*dt)*dW(i);
    y(4,i+1) = y(4,i)+(m*g(i+1))*dt+sqrt(2*m*dt)*dW(i);
    if y(4,i+1) > beta
        y(4,i+1) = beta;
    elseif y(4,i+1) < -beta
        y(4,i+1) = -beta;
    end
end

plot(t,y,'linewidth',10)
legend('Norm','Lin','Cub','Bound')
boxoff
