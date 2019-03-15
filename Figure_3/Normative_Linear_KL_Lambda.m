% Used to generate Fig 3B in manuscript.
clear

b = 15; t_0 = 0; t_f = 1; m = [1 5 10 50]; lambda = linspace(0.005,20);
h_o = 1; h_e = 1;
dy = 0.005; dt = 0.005;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

KL = NaN(length(m),length(lambda));

for i = 1:length(m)
    [~,p_n] = Normative_Accuracy_Interrogation(m(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    p_n = abs(p_n(end,:)); p_n(p_n==0) = eps;
    for j = 1:length(lambda)
        [~,p_l] = Linear_Accuracy_Interrogation(m(i),lambda(j),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
        p_l = abs(p_l(end,:)); p_l(p_l==0) = eps;
        KL(i,j) = sum(p_n.*log(p_n./p_l));
    end
end

save('Normative_Linear_KL_Lambda_Data');

figure
plot(lambda,KL(1,:))
hold on
plot(lambda,KL(2,:))
plot(lambda,KL(3,:))
plot(lambda,KL(4,:))