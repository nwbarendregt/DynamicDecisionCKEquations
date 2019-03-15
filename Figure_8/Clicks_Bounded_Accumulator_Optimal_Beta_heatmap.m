% Used to generate Fig 8D in manuscript.

clear

beta = 1:10;
r_m = linspace(0.1,40,1000); r_p = linspace(0.1,40,1000);

acc = NaN(length(r_m),length(r_p),length(beta)); q = NaN(length(r_m),length(r_p));

for i = 1:length(r_p)
    for j = 1:length(r_m)
        if r_p(i)>r_m(j)
            for k = 1:length(beta)
                [acc(i,j,k),~] = Clicks_Bounded_Accumulator_Accuracy_Interrogation(r_p(i),r_m(j),beta(k));
            end
        end
    end
end

Opt_beta = NaN(length(r_p),length(r_m));
for i = 1:length(r_p)
    for j = 1:length(r_m)
        if r_p(i)>r_m(j)
            [~,I] = max(acc(i,j,:));
            Opt_beta(i,j) = beta(I);
        end
    end
end

save('Clicks_Bounded_Accumulator_Optimal_Beta_Data');

figure
imagesc([r_p(1) r_p(end)],[r_m(1) r_m(end)],Opt_beta','AlphaData',~isnan(Opt_beta'))
cmap = hot;
cmap = cmap(round(linspace(1,64,3)),:);
colormap(cmap);
colorbar
set(gca,'YDir','normal')
