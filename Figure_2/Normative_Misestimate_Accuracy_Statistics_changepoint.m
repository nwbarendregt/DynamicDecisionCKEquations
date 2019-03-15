clear

t_0 = 0; t_f = 1.5; dt = 0.01; t = t_0:dt:t_f;
b = 15; dy = 0.01; y = -b:dy:b;
m = 1; h_o = [0.1 1 10]; h_e = 1;

p_0 = zeros(1,length(y)); p_0((length(y)+1)/2) = 1;

Acc_i = NaN(length(h_o),length(t(141:(end-1))));
Acc = NaN(length(h_o),length(t));

for i = 1:length(h_o)
    [~,p_1] = Normative_Accuracy_Interrogation(m,h_o(i),h_e,p_0,t_0,dt,t_f,b,dy);
    for j = 141:(length(t)-1)
        Acc_i(i,j-140) = sum(p_1(j,y>=0));
    end
    [~,P] = Normative_Accuracy_Interrogation(m,h_o(i),h_e,flip(p_1(end,:)),t_0,dt,t_f,b,dy);
    for j = 1:length(t)
        Acc(i,j) = sum(P(j,y>=0));
    end
end

figure
p1 = plot([-0.1:dt:(0-dt) t],[Acc_i(1,:) Acc(1,:)]);
hold on
p2 = plot([-0.1:dt:(0-dt) t],[Acc_i(2,:) Acc(2,:)]);
p3 = plot([-0.1:dt:(0-dt) t],[Acc_i(3,:) Acc(3,:)]);
title('Post-Changepoint Accuracy'); xlabel('t'); ylabel('Accuracy');
legend([p1 p2 p3],{'h_o = 0.1','h_o = 1','h_o = 10'}); legend('boxoff');