% Used to generate Fig. 7B from the manuscript.
clear

t_0 = 0; dt = 0.05; t_f = 1; t = t_0:dt:t_f;
b = 50; dy = 0.01; y = -b:dy:b;
r_p = linspace(0.1,40,50); r_m = linspace(0.1,40,50);
D = 0.05; lambda = linspace(0.1,6,25);
h_o = 1; h_t = 1;

acc = NaN(length(r_p),length(r_m),length(lambda));

for i = 1:length(r_p)
    for j = 1:length(r_m)
        if r_p(i) > r_m(j)
            kappa = round(log(r_p(i)/r_m(j)),2);
            for k = 1:length(lambda)
                [acc(i,j,k),~] = Clicks_Linear_Accuracy_Interrogation(kappa,r_m(j),lambda(k),D,h_o,h_t,t_0,dt,t_f,b,dy);
            end
        end
    end
    disp(i)
end

Opt_lambda = NaN(length(r_p),length(r_m));
L = linspace(min(lambda),max(lambda),10^5);
for i = 1:length(r_p)
    for j = 1:length(r_m)
        if r_p(i) > r_m(j)
            s = spline(lambda,acc(i,j,:),L);
            [~,I] = max(s);
            Opt_lambda(i,j) = L(I);
        end
    end
end

save('Clicks_Linear_Accuracy_Statistics_Lambda_Data');

figure
imagesc([r_p(1) r_p(end)],[r_m(1) r_m(end)],Opt_lambda','AlphaData',~isnan(Opt_lambda'))
colormap hot
colorbar
set(gca,'YDir','normal')
