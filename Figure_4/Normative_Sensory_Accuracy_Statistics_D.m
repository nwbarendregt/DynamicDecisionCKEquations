% Used to generate Fig 4B in manuscript.
clear

b = 15; t_0 = 0; t_f = 1; m = [1 5 10 50]; D = logspace(-2,3);
h_o = 1; h_e = 1;
dy = 0.005; dt = 0.005;
p_0 = zeros(1,length(-b:dy:b)); p_0((length(-b:dy:b)+1)/2) = 1;


acc = NaN(length(m),length(D));

for i = 1:length(m)
    for j = 1:length(D)
        [acc(i,j),~] = Normative_Sensory_Accuracy_Interrogation(m(i),D(j),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
    end
end

figure
semilogx(D,acc(1,:))
hold on
semilogx(D,acc(2,:))
semilogx(D,acc(3,:))
semilogx(D,acc(4,:))
line([1 1],[0.5 1],'linestyle','--')
line([5 5],[0.5 1],'linestyle','--')
line([10 10],[0.5 1],'linestyle','--')
line([50 50],[0.5 1],'linestyle','--')