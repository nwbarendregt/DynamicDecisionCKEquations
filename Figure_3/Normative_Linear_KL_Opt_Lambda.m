% Used to generate data for Fig 3C,D in manuscript.
clear

b = 15; t_0 = 0; t_f = 1; m = linspace(1,50); lambda = linspace(0.005,20,50);
h_o = 1; h_e = 1;
dy = 0.005; dt = 0.005;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

KL = NaN(length(m),length(lambda));
Opt_lambda = NaN(1,length(m));

for i = 1:length(m)
    [~,p_n] = Normative_Accuracy_Interrogation(m(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    p_n = abs(p_n(end,:)); p_n(p_n==0) = eps;
    for j = 1:length(lambda)
        [~,p_l] = Linear_Accuracy_Interrogation(m(i),lambda(j),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
        p_l = abs(p_l(end,:)); p_l(p_l==0) = eps;
        KL(i,j) = sum(p_n.*log(p_n./p_l));
    end
end

L = linspace(min(lambda),max(lambda),10^5);
curv_KL = NaN(1,length(m));
for i = 1:length(m)
    s = spline(lambda,KL(i,:),L);
    [~,I] = min(s);
    Opt_lambda(i) = L(I);
    curv_KL(i) = abs(-s(I+2)+16*s(I+1)-30*s(I)+16*s(I-1)-s(I-2))/(12*((max(lambda)-min(lambda))/10^5)^2);
end

M = linspace(min(m),max(m),10^5);
Opt_lambda_spline_KL = spline(m,Opt_lambda,M);

save('Normative_Linear_KL_Optimal_Lambda_Data')