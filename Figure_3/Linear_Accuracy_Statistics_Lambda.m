% Used to generate Fig 3A in manuscript.
clear

b = 15; t_0 = 0; t_f = 1; m = [1 5 10 50]; lambda = linspace(0.005,20);
h_o = 1; h_e = 1;
dy = 0.005; dt = 0.005;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

acc_norm = NaN(length(m),length(lambda));
acc_lin = NaN(length(m),length(lambda));

for i = 1:length(m)
    [acc_norm(i,:),~] = Normative_Accuracy_Interrogation(m(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    for j = 1:length(lambda)
        [acc_lin(i,j),~] = Linear_Accuracy_Interrogation(m(i),lambda(j),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    end
end

save('Linear_Accuracy_Statistics_Lambda_Data');

figure
plot(lambda,acc_lin(1,:))
hold on
plot(lambda,acc_lin(2,:))
plot(lambda,acc_lin(3,:))
plot(lambda,acc_lin(4,:))
plot(lambda,acc_norm,'--')