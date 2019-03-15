% Used to generate Fig 4C in manuscript.
clear

b = 15; t_0 = 0; t_f = 1; m = 10; D = logspace(-1,2); h_o = 0.01:0.01:2; h_e = 1;
dy = 0.005; dt = 0.005;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

acc = NaN(length(D),length(h_o));

for i = 1:length(D)
    for j = 1:length(h_o)
        [acc(i,j),~] = Normative_Sensory_Accuracy_Interrogation(m,D(i),h_o(j),h_e,p_0,t_0,dt,t_f,b,dy);
    end
    disp(i)
end

max_h_o = NaN(1,length(D));
for i = 1:length(D)
    [~,I] = max(acc(i,:));
    max_h_o(i) = h_o(I);
end

figure
imagesc([h_o(1) h_o(end)],[log10(D(1)) log10(D(end))],acc)
colormap hot
colorbar
hold on
plot(max_h_o,log10(D),'--')
set(gca,'YDir','normal')

save('Normative_Sensory_Misestimate_Accuracy_Statistics_Data');