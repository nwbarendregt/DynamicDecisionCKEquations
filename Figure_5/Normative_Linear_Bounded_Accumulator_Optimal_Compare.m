% Used to generate Fig 5F in manuscript.
clear

m = linspace(1,50); beta = linspace(0,5);

b = 25; t_0 = 0; t_f = 1;
h_o = 1; h_e = 1;
dy = 0.005; dt = 0.05;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

load('Linear_Accuracy_Optimal_Lambda_Data.mat','Opt_lambda');

acc_b = NaN(length(m),length(beta));
acc_n = NaN(1,length(m));
acc_l = NaN(1,length(m));

for i = 1:length(m)
    [acc_n(i),~] = Normative_Accuracy_Interrogation(m(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    [acc_l(i),~] = Linear_Accuracy_Interrogation(m(i),Opt_lambda(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    for j = 1:length(beta)
        [acc_b(i,j),~] = Bounded_Accumulator_Accuracy_Interrogation(m(i),beta(j),dy);
    end
end

B = linspace(min(beta),max(beta),10^5);
Max_acc_b = NaN(1,length(m));
for i = 1:length(m)
    s = spline(beta,acc_b(i,:),B);
    Max_acc_b(i) = max(s);
end

figure
plot(m,Max_acc_b-acc_n)
hold on
plot(m,acc_l-acc_n)