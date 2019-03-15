% Used to generate Fig. 7B from the manuscript.
clear

t_0 = 0; dt = 0.01; t_f = 1; t = t_0:dt:t_f;
b = 50; dy = 0.01; y = -b:dy:b;
kappa = [0.24 0.46 0.66 0.85]; lambda_m = 30; D = 0.05; gamma = linspace(0.1,8);
h_o = 1; h_t = 1;

acc = NaN(length(kappa),length(gamma));

for i = 1:length(kappa)
    for j = 1:length(gamma)
        [acc(i,j),~] = Clicks_Linear_Accuracy_Interrogation(kappa(i),lambda_m,gamma(j),D,h_o,h_t,t_0,dt,t_f,b,dy);
    end
    disp(i)
end
save('Clicks_Linear_Accuracy_Statistics_Gamma_Data');

plot(gamma,acc,'linewidth',5)