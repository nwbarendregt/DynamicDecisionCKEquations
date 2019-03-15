% Used to generate Fig 6B in manuscript.
clear
b = 25; t_0 = 0; t_f = 1; m = 1; lambda_1 = linspace(0,10,10); lambda_2 = linspace(0,10,10);
h_o = 1; h_e = 1;
dy = 0.005; dt = 0.05;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

acc = NaN(length(lambda_1),length(lambda_2));

for i = 1:length(lambda_1)
    for j = 1:length(lambda_2)
        [acc(i,j),~] = Cubic_Accuracy_Interrogation(m,lambda_1(i),lambda_2(j),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    end
end

save('Cubic_Accuracy_Statistics_Lambda_Data');
 
figure
imagesc([lambda_1(1) lambda_1(end)],[lambda_2(1) lambda_2(end)],acc')
colormap hot
colorbar
hold on
[r,c] = find(acc==max(max(acc)));
scatter(lambda_1(r),lambda_2(c))
set(gca,'YDir','normal')
