% Used to generate Fig. 6E in manuscript.

y = -7:0.01:7;
m = 10; lambda = 5; lambda_1 = -15;

figure
plot(y,-(m*y-lambda/2*y.^2))
figure
plot(y,-(-m*y-lambda/2*y.^2))
figure
plot(y,-(m*y-lambda_1/2*y.^2-y.^4/4))
figure
plot(y,-(-m*y-lambda_1/2*y.^2-y.^4/4))
