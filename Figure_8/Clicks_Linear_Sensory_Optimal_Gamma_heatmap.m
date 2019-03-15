% Used to generate Fig. 7D from the manuscript.
clear

t_0 = 0; dt = 0.05; t_f = 1; t = t_0:dt:t_f;
b = 150; dy = 0.05; y = -b:dy:b;
kappa = 0.25:dy:0.85; lambda_m = 30; D = logspace(log10(0.05),log10(500),25); gamma = linspace(0.1,10,20);
h_o = 1; h_t = 1;

acc = NaN(length(kappa),length(D),length(gamma));
Opt_gamma = NaN(length(kappa),length(D));
SNR = (lambda_m*exp(kappa)-lambda_m)./sqrt(lambda_m*exp(kappa)+lambda_m);

for i = 1:length(kappa)
    for j = 1:length(D)
        for k = 1:length(gamma)
            [acc(i,j,k),~] = Clicks_Linear_Accuracy_Interrogation(kappa(i),lambda_m,gamma(k),D(j),h_o,h_t,t_0,dt,t_f,b,dy);
            if acc(i,j,k) > 1
                error('Numerical error occured. Terminating simulation.')
            end
        end
    end
    disp(i)
end

G = linspace(min(gamma),max(gamma),10^5);
for i = 1:length(kappa)
    for j = 1:length(D)
        s = spline(gamma,acc(i,j,:),G);
        [~,I] = max(s);
        Opt_gamma(i,j) = G(I);
    end
end

save('Clicks_Linear_Sensory_Optimal_Gamma_Data');

figure
imagesc([SNR(1) SNR(end)],[log10(D(1)) log10(D(end))],Opt_gamma')
colormap hot
colorbar
set(gca,'YDir','normal')