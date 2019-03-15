% Used to generate Fig. 7B in manuscript.
clear

b = 15; t_0 = 0; t_f = 1; m = 50;
h_o = 1; h_e = 1;
dy = 0.001; dt = 0.001;

t = t_0:dt:t_f;
y = -b:dy:b;
p_0 = zeros(1,length(y)); p_0((length(y)+1)/2) = 1;

beta = 5.57348223482235; lambda = 15.9183673469388; lambda_1 = 2.04081632653061; lambda_2 = 0.816326530612245;

[~,p_norm] = Normative_Accuracy_Interrogation(m,h_o,h_e,p_0,t_0,dt,t_f,b,dy); p_norm = p_norm(end,:);
[~,p_lin] = Cubic_Accuracy_Interrogation(m,lambda,0,h_o,h_e,p_0,t_0,dt,t_f,b,dy); p_lin = p_lin(end,:);
[~,p_cub] = Cubic_Accuracy_Interrogation(m,lambda_1,lambda_2,h_o,h_e,p_0,t_0,dt,t_f,b,dy); p_cub = p_cub(end,:);
[~,p_bound] = Bounded_Accumulator_Accuracy_Interrogation(m,beta,dy); 
p_bound = [zeros(1,(length(-b:dy:b)-length(p_bound))/2) p_bound zeros(1,(length(-b:dy:b)-length(p_bound))/2)];

figure
yyaxis left
plot(y,p_norm);
hold on
plot(y,p_lin);
plot(y,p_cub);
yyaxis right
plot(y,p_bound);
