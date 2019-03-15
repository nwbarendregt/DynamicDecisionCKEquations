% Used to generate Fig 5B in manuscript.
clear

m = 5; beta = [1 3 5]; dy = 0.001;

figure
for i = 1:length(beta)
    [~,p] = Bounded_Accumulator_Accuracy_Interrogation(m,beta(i),dy);
    plot(-beta(i):dy:beta(i),p)
    hold on
    plot([-beta(i) -beta(i)],[0 1.2],'--')
    plot([beta(i) beta(i)],[0 1.2],'--')
end