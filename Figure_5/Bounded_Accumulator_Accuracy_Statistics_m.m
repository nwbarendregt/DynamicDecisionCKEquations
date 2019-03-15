% Used to generate Fig 5C in manuscript.
clear

m = [1 5 10 50]; beta = linspace(0,5); dy = 0.01;

b = 15; t_0 = 0; t_f = 1; h_o = 1; h_e = 1;
dt = 0.01;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

acc_beta = NaN(length(m),length(beta));
acc_norm = NaN(length(m),length(beta));

for i = 1:length(m)
    [acc_norm(i,:),~] = Normative_Accuracy_Interrogation(m(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    for j = 1:length(beta)
        [acc_beta(i,j),~] = Bounded_Accumulator_Accuracy_Interrogation(m(i),beta(j),dy);
    end
end

figure
plot(beta,acc_beta)
hold on
plot(beta,acc_norm,'--')