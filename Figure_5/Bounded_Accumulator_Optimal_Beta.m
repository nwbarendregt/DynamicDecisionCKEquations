% Used to generate Fig 5D in manuscript.
clear

m = linspace(1,50); beta = linspace(0,5); dy = 0.01;

acc = NaN(length(m),length(beta));

for i = 1:length(m)
    for j = 1:length(beta)
        [acc(i,j),~] = Bounded_Accumulator_Accuracy_Interrogation(m(i),beta(j),dy);
    end
end

B = linspace(min(beta),max(beta),10^5);
Opt_beta = NaN(1,length(m));
for i = 1:length(m)
    s = spline(beta,acc(i,:),B);
    [~,I] = max(s);
    Opt_beta(i) = B(I);
end

figure
plot(m,Opt_beta)