% Generates Fig 3C,D in manuscript.
clear
load('Linear_Accuracy_Optimal_Lambda_Data.mat','Opt_lambda_spline_acc','M','curv_acc','m');
load('Normative_Linear_KL_Optimal_Lambda_Data.mat','Opt_lambda_spline_KL','curv_KL');

fig = figure;
left_color = [1 0 0];
right_color = [0 0 1];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
yyaxis left
plot(m,abs(curv_acc))
hold on
line(m(abs(curv_acc)==max(abs(curv_acc)))*ones(1,2),[1e-4 6*1e-3],'linestyle','--')

yyaxis right
plot(m,curv_KL)

figure
plot(M,Opt_lambda_spline_acc)
hold on
plot(M,Opt_lambda_spline_KL)