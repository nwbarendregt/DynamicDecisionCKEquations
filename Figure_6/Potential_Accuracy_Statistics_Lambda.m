% Used to generate Fig 6D in manuscript.
clear
b = 15; t_0 = 0; t_f = 1; m = [1 5 10 50]; lambda_1 = linspace(-20,0); lambda_2 = 1;
h_o = 1; h_e = 1;
dy = 0.05; dt = 0.05;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

acc = NaN(length(m),length(lambda_2));

for i = 1:length(m)
    for j = 1:length(lambda_1)
        [acc(i,j),~] = Cubic_Accuracy_Interrogation(m(i),lambda_1(j),lambda_2,h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    end
end

save('Potential_Accuracy_Statistics_Lambda_Data');

figure
plot(lambda_1,acc)