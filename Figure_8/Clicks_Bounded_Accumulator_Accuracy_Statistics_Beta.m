% Used to generate Fig 8C in manuscript.
clear

r_m = 30; beta = 1:10;
kappa = [0.24 0.46 0.66 0.85]; r_p = r_m*exp(kappa);

acc = NaN(length(kappa),length(beta));

for i = 1:length(kappa)
    for j = 1:length(beta)
        [acc(i,j),~] = Clicks_Bounded_Accumulator_Accuracy_Interrogation(r_p(i),r_m,beta(j));
    end
end

figure
plot(beta,acc)
