% Used to generate Fig 4D in manuscript.
clear

b = 200; t_0 = 0; t_f = 1; m = linspace(1,50); D = logspace(-3,3); lambda = linspace(1,15,15);
dy = 0.05; dt = 0.05;
h_o = 1; h_e = 1;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

acc = NaN(length(m),length(D),length(lambda));
Opt_lambda = NaN(length(m),length(D));

for i = 1:length(m)
    for j = 1:length(D)
        for k = 1:length(lambda)
            [acc(i,j,k),~] = Linear_Sensory_Accuracy_Interrogation(m(i),lambda(k),D(j),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
        end
    end
    disp(i)
end

L = linspace(min(lambda),max(lambda),10^5);
for i = 1:length(m)
    for j = 1:length(D)
        s = spline(lambda,acc(i,j,:),L);
        [~,I] = max(s);
        Opt_lambda(i,j) = L(I);
    end
end

figure
imagesc([m(1) m(end)],[log10(D(1)) log10(D(end))],Opt_lambda')
colormap hot
colorbar
set(gca,'YDir','normal')

save('Linear_Sensory_Accuracy_Statistics_Optimal_Lambda_Data');