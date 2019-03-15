% Used to generate Fig. 9 in manuscript
clear

b = 10; t_0 = 0; t_f = 1; m = 5;
h_o = linspace(0.5,1.5); h_e = 1;
dy = 0.01; dt = 0.01;
nsamp = [10^3 10^4 10^5 10^6];

y = -b:dy:b;
p_0 = zeros(1,length(y)); p_0((length(y)+1)/2) = 1;

acc_CK = NaN(1,length(h_o));
acc_MC = NaN(length(nsamp),length(h_o));
time_MC = NaN(1,length(nsamp));
max_MC = NaN(1,length(nsamp));
Err = NaN(1,length(nsamp));

tic
for i = 1:length(h_o)
    [acc_CK(i),~] = Normative_Accuracy_Interrogation(m,h_o(i),h_e,p_0,t_0,dt,t_f,b,dy);
end
time_CK = toc;
[~,I] = max(acc_CK); max_CK = h_o(I);

for i = 1:length(nsamp)
    tic
    for j = 1:length(h_o)
        acc_MC(i,j) = Normative_SDE_MC(m,h_o(j),h_e,t_0,t_f,dt,nsamp(i));
    end
    time_MC(i) = toc;
    [~,I] = max(acc_MC(i,:)); max_MC(i) = h_o(I);
    Err(i) = norm(acc_CK-acc_MC(i,:));
end

figure
plot(h_o,acc_CK)
hold on
plot(h_o,acc_MC)

figure
yyaxis left
loglog(nsamp,time_CK*ones(1,length(nsamp)))
hold on
loglog(nsamp,time_MC)
yyaxis right
semilogx(nsamp,Err)
