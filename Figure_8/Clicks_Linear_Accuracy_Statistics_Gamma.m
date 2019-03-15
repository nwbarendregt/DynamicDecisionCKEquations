% Used to generate Fig. 8A from the manuscript.
clear

t_0 = 0; dt = 0.01; t_f = 1; t = t_0:dt:t_f;
b = 50; dy = 0.01; y = -b:dy:b;
kappa = [0.24 0.46 0.66 0.85]; r_m = 30; D = 0.05; lambda = linspace(0.1,8);
h_o = 1; h_t = 1;

acc = NaN(length(kappa),length(lambda));

for i = 1:length(kappa)
    for j = 1:length(lambda)
        [acc(i,j),~] = Clicks_Linear_Accuracy_Interrogation(kappa(i),r_m,lambda(j),D,h_o,h_t,t_0,dt,t_f,b,dy);
    end
    disp(i)
end
save('Clicks_Linear_Accuracy_Statistics_Lambda_Data');

plot(lambda,acc,'linewidth',5)
