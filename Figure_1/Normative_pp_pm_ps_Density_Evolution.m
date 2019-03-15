% Used to generate Fig 1C in manuscript.
clear

b = 10; t_0 = 0; t_f = 1; m = 50;
h_o = 1; h_e = 1;
dy = 0.001; dt = 0.001;

t = t_0:dt:t_f;
y = -b:dy:b;
p_0 = NaN(1,2*length(y));
p_0(1,:) = 0; p_0(1,[(length(y)+1)/2,(length(y)+1)/2+length(y)]) = 0.5;
ymaxp = NaN(1,length(t)); ymaxm = NaN(1,length(t));

[pp,pm] = Normative_Accuracy_Interrogation_pp_pm(m,h_o,h_e,p_0,t_0,dt,t_f,b,dy);

pp_ss = pp(end,:); pm_ss = pm(end,:);

[i,j] = size(pp);
for ii = 1:i
    for jj = 1:j
        if pp(ii,jj) < 10^-10
            pp(ii,jj) = eps;
        end
        if pm(ii,jj) < 10^-10
            pm(ii,jj) = eps;
        end
    end
end
ps = pp+flip(pm,2);
pp = log10(abs(pp)); pm = log10(abs(pm)); ps = log10(abs(ps));

for i = 1:length(t)
    [~,Ip] = max(pp(i,:)); [~,Im] = max(pm(i,:));
    ymaxp(i) = y(Ip); ymaxm(i) = y(Im);
end

figure
imagesc(t,y,pp',[-6 max(max(pm(2:end,:)))])
hold on
plot(t,ymaxp,'k--')
colorbar
colormap hot
title('pp(y,t)');
xlabel('t'); ylabel('y');
set(gca,'YDir','normal')
figure
plot(pp_ss,y,'k')
hold on
fill([pp_ss(:,b/dy+1:end),zeros(1,b/dy+1)],[linspace(0,b,b/dy+1) linspace(b,0,b/dy+1)],'k')
title('pp_s(y)')

figure
imagesc(t,y,pm',[-6 max(max(pm(2:end,:)))])
hold on
plot(t,ymaxm,'k--')
colorbar
colormap hot
title('pm(y,t)');
xlabel('t'); ylabel('y');
set(gca,'YDir','normal')
figure
plot(pm_ss,y,'k')
hold on
fill([pm_ss(:,1:b/dy+1),zeros(1,b/dy+1)],[linspace(-b,0,b/dy+1) linspace(0,-b,b/dy+1)],'k')
title('pm_s(y)')

ps_ss = pp_ss+flip(pm_ss);
ymaxs = NaN(1,length(t));
for i = 1:length(t)
    [~,I] = max(ps(i,:));
    ymaxs(i) = y(I);
end

figure
imagesc(t,y,ps',[-6 max(max(ps(2:end,:)))])
colorbar
colormap hot
hold on
plot(t,ymaxs,'k--')
title('ps(y,t)')
xlabel('t'); ylabel('y');
set(gca,'YDir','normal')
figure
plot(ps_ss,y,'k')
hold on
fill([ps_ss(:,b/dy+1:end),zeros(1,b/dy+1)],[linspace(0,b,b/dy+1) linspace(b,0,b/dy+1)],'k')
title('ps_s(y)')