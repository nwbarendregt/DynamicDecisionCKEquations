% Used to generate Fig. 6A in manuscript.
clear

y = -4:0.01:4;
lambda = 11.8304;
lambda_1 = 5.3535; lambda_2 = 0.4040;

norm = -2*sinh(y);
lin = -lambda_1*y;
cub = -lambda_1*y-lambda_2*y.^3;

figure
plot(y,norm)
hold on
plot(y,lin)
plot(y,cub)