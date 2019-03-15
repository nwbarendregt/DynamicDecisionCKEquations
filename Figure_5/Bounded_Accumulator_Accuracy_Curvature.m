% Used to generate Fig 5E in manuscript.
clear

m = linspace(1,50); beta = linspace(0,5); dy = 0.01;

acc = NaN(length(m),length(beta));

for i = 1:length(m)
    for j = 1:length(beta)
        [acc(i,j),~] = Bounded_Accumulator_Accuracy_Interrogation(m(i),beta(j),dy);
    end
end

B = linspace(min(beta),max(beta),10^5);
curv = NaN(1,length(m));
for i = 1:length(m)
    s = spline(beta,acc(i,:),B);
    [~,I] = max(s);
    curv(i) = abs(-s(I+2)+16*s(I+1)-30*s(I)+16*s(I-1)-s(I-2))/(12*((min(beta)-max(beta))/10^5)^2);
end

figure
plot(m,curv)