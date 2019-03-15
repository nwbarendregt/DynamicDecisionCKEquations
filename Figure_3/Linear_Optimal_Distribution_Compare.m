% Used to generate Fig 3E,F in manuscript.
clear

b = 10; t_0 = 0; t_f = 1; m = [5 50];
h_o = 1; h_e = 1;
dy = 0.001; dt = 0.001;

t = t_0:dt:t_f;
y = -b:dy:b;
p_0 = zeros(1,length(y)); p_0((length(y)+1)/2) = 1;

load('Linear_Accuracy_Optimal_Lambda_Data.mat','Opt_lambda')
lambda_acc = Opt_lambda([9 end]);
load('Normative_Linear_KL_Optimal_Lambda_Data.mat','Opt_lambda')
lambda_KL = Opt_lambda([9 end]);

for i = 1:length(m)
    [~,p_norm] = Normative_Accuracy_Interrogation(m(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy); p_norm = p_norm(end,:);
    [~,p_acc] = Linear_Accuracy_Interrogation(m(i),lambda_acc(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy); p_acc = p_acc(end,:);
    [~,p_KL] = Linear_Accuracy_Interrogation(m(i),lambda_KL(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy); p_KL = p_KL(end,:);
    
    figure
    plot(y,p_norm);
    hold on
    plot(y,p_acc);
    plot(y,p_KL);
    legend({'Normative','Max Accuracy','Min KL'})
    legend('boxoff')
    box off
end