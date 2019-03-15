% Used to generate Fig 2E in manuscript.
clear

b = 15; t_0 = 0; t_f = 1; m = [1 5 10 50]; h_o = 0.005:0.005:5; h_e = 1;
dy = 0.01; dt = 0.01;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

acc = NaN(length(m),length(h_o));

for i = 1:length(m)
    for j = 1:length(h_o)
        [acc(i,j),~] = Normative_Accuracy_Interrogation(m(i),h_o(j),h_e,p_0,t_0,dt,t_f,b,dy);
    end
    disp(m(i))
end

save('Normative_Misestimate_Accuracy_Statistics_m_Data');

figure
plot(h_o,acc(1,:))
hold on
plot(h_o,acc(2,:))
plot(h_o,acc(3,:))
plot(h_o,acc(4,:))
line([1 1],[0.5 1],'color','black','linestyle','--')