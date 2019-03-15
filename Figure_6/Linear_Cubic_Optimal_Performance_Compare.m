% Used to generate Fig 6C in manuscript.
clear
b = 25; t_0 = 0; t_f = 1; m = linspace(1,50,10); lambda_1 = linspace(0,10,10); lambda_2 = linspace(0,10,10);
h_o = 1; h_e = 1;
dy = 0.005; dt = 0.05;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

acc = NaN(length(m),length(lambda_1),length(lambda_2));

for i = 1:length(m)
    for j = 1:length(lambda_1)
        for k = 1:length(lambda_2)
            [acc(i,j,k),~] = Cubic_Accuracy_Interrogation(m(i),lambda_1(j),lambda_2(k),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
        end
    end
end

Opt_lin = NaN(1,length(m)); Opt_cub = NaN(1,length(m));

for i = 1:length(m)
    Opt_lin(i) = max(acc(i,:,1));
    Opt_cub(i) = max(max(acc(i,:,:)));
end

save('Linear_Cubic_Optimal_Performance_Compare_data');

figure
plot(m,Opt_lin-Opt_cub)