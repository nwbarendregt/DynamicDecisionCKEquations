% Used to generate Fig 2A,B in manuscript.
clear

b = 10; t_0 = 0; t_f = 1; m = [5 50];
h_o = 1; h_e = 1;
dy = 0.001; dt = 0.001;

t = t_0:dt:t_f;
p = NaN(length(t),length(-b:dy:b));
y = -b:dy:b;
p_0 = zeros(1,length(y)); p_0((length(y)+1)/2) = 1;

figure
[~,p] = Normative_Accuracy_Interrogation(m(1),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
plot3(y,p(end,:),ones(1,length(y)))
hold on
fill3([y(y>=0) flip(y(y>=0))],[p(end,y>=0),zeros(1,length(y(y>=0)))],ones(1,length([y(y>=0) flip(y(y>=0))])),'r')
[~,p] = Normative_Accuracy_Interrogation(m(2),h_o,h_e,p_0,t_0,dt,t_f,b,dy);
plot3(y,p(end,:),zeros(1,length(y)))
fill3([y(y>=0) flip(y(y>=0))],[p(end,y>=0),zeros(1,length(y(y>=0)))],zeros(1,length([y(y>=0) flip(y(y>=0))])),'r')

[i,j] = size(p);
for ii = 1:i
    for jj = 1:j
        if p(ii,jj) < 10^-10
            p(ii,jj) = eps;
        end
    end
end
p = log10(abs(p));
figure
imagesc(t,y,p',[-6 max(max(p(2:end,:)))])
colorbar
colormap hot
set(gca,'YDir','normal')