% Used to generate Fig. 7C,D in manuscript.
clear

b = 15; t_0 = 0; t_f = 1; dy = 0.05; dt = 0.05;
m = linspace(1,50); lambda_1 = linspace(0,20,50); lambda_2 = linspace(0,20,50); beta = dy:dy:b;
h_o = 1; h_e = 1;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

KL_bound = NaN(length(m),length(beta));
KL_cub = NaN(length(m),length(lambda_1),length(lambda_2));

for i = 1:length(m)
    [~,p_n] = Normative_Accuracy_Interrogation(m(i),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    p_n = abs(p_n(end,:));
    for j = 1:length(lambda_1)
        for k = 1:length(lambda_2)
            [~,p_c] = Cubic_Accuracy_Interrogation(m(i),lambda_1(j),lambda_2(k),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
            p_c = abs(p_c(end,:)); p_c(p_c==0) = eps;
            KL_cub(i,j,k) = sum(p_n.*log(p_n./p_l));
        end
    end
    for j = 1:length(beta)
        [~,p_b] = Bounded_Accumulator_Accuracy_Interrogation(m(i),beta(j),dy);
        p_b = [eps*ones(1,(length(-b:dy:b)-length(p_b))/2) p_b eps*ones(1,(length(-b:dy:b)-length(p_b))/2)];
        KL_bound(i,j) = sum(p_n.*log(p_n./p_l));
    end
    disp(i)
end

Min_KL_bound = NaN(1,length(m));
Beta_opt = NaN(1,length(m));
Min_KL_lin = NaN(1,length(m));
Lin_opt = NaN(1,length(m));
Min_KL_cub = NaN(1,length(m));
Cub_opt = NaN(2,length(m));

B = linspace(min(beta),max(beta),10^5);
L = linspace(min(lambda_1),max(lambda_1),10^5);
[L1,L2] = meshgrid(linspace(min(lambda_1),max(lambda_1),10^3),linspace(min(lambda_2),max(lambda_2),10^3));
[l1,l2] = meshgrid(lambda_1,lambda_2); l1 = l1(:); l2 = l2(:);

for i = 1:length(m)
    s = spline(beta,KL_bound(i,:),B);
    [Min_KL_bound(i),I] = min(s);
    Beta_opt(i) = B(I);
    s = spline(lambda_1,KL_cub(i,:,1),L);
    [Min_KL_lin(i),I] = min(s);
    Lin_opt(i) = L(I);
    KL_cub_i = squeeze(KL_cub(i,:,:));
    g = griddata(l1,l2,KL_cub_i(:),L1,L2);
    [Min_KL_cub(i),I] = min(g(:));
    [Cub_opt(1,i),Cub_opt(2,i)] = ind2sub(size(g),I);
    Cub_opt(:,i) = [L1(Cub_opt(1,i)) L2(Cub_opt(2,i))];
end

save('KL_Opt_Tuning_Data');

figure
plot(m,Min_KL_bound)
hold on
plot(m,Min_KL_lin)

figure
plot(m,Min_KL_lin-Min_KL_cub)
