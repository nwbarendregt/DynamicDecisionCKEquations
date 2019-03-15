% Used to generate Fig 2F in manuscript.
b = 15; t_0 = 0; t_f = 1; m = linspace(1,50); h_o = 0.8:0.005:1.2; h_e = 1;
dy = 0.01; dt = 0.01;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;

acc = NaN(length(m),length(h_o));

for i = 1:length(m)
    for j = 1:length(h_o)
        [acc(i,j),~] = Normative_Accuracy_Interrogation(m(i),h_o(j),h_e,p_0,t_0,dt,t_f,b,dy);
    end
end

H = linspace(min(h_o),max(h_o),10^5);
curv = NaN(1,length(m));
for i = 1:length(m)
    s = spline(h_o,acc(i,:),H);
    [~,I] = max(s);
    curv(i) = abs(-s(I+2)+16*s(I+1)-30*s(I)+16*s(I-1)-s(I-2))/(12*((min(h_o)-max(h_o))/10^5)^2);
end
[~,I] = max(curv);

save('Normative_Misestimate_Accuracy_Curvature_Data');

figure
plot(m,curv)
hold on
line([m(I) m(I)],[0.012 0.032],'color','black','linestyle','--')