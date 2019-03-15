% Used to generate data for Fig 3C,D in manuscript.
clear

b = 15; t_0 = 0; t_f = 1; m = linspace(1,50); lambda = linspace(0.005,20,50);
h_o = 1; h_e = 1;
dy = 0.005; dt = 0.005;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;
acc = NaN(length(m),length(lambda));
Opt_lambda = NaN(1,length(m));

for i = 1:length(m)
    for j = 1:length(lambda)
        [acc(i,j),~] = Linear_Accuracy_Interrogation(m(i),lambda(j),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    end
end

L = linspace(min(lambda),max(lambda),10^5);
curv_acc = NaN(1,length(m));
for i = 1:length(m)
    s = spline(lambda,acc(i,:),L);
    [~,I] = max(s);
    Opt_lambda(i) = L(I);
    curv_acc(i) = abs(-s(I+2)+16*s(I+1)-30*s(I)+16*s(I-1)-s(I-2))/(12*((max(lambda)-min(lambda))/10^5)^2);
end

M = linspace(min(m),max(m),10^5);
Opt_lambda_spline_acc = spline(m,Opt_lambda,M);

save('Linear_Accuracy_Optimal_Lambda_Data')