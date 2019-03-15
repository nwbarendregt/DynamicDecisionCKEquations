% Used to generate Fig 1A in manuscript.
clear

b = 10; t_0 = 0; t_f = 1; m = 50;
h_o = 1; h_e = 1;
dy = 0.001; dt = 0.001;

t = t_0:dt:t_f;
y = NaN(1,length(t)); y(1) = 0;
g = NaN(1,length(t)); 
p_0 = NaN(1,length(-b:dy:b));
p_0(1,:) = 0; p_0(1,(length(y)+1)/2) = 1;

g(1:floor((2*length(t)/16))) = 1; 
g(floor(2*length(t)/16+1):floor(3*length(t)/16)) = -1;
g(floor(3*length(t)/16+1):floor(5*length(t)/16)) = 1;
g(floor(5*length(t)/16+1):floor(9*length(t)/16)) = -1;
g(floor(9*length(t)/16+1):floor(12*length(t)/16)) = 1;
g(floor(12*length(t)/16+1):floor(14*length(t)/16)) = -1;
g(floor(14*length(t)/16+1):floor(15*length(t)/16)) = 1;
g(floor(15*length(t)/16+1):end) = -1;
for i = 2:length(t)
    y(i) = y(i-1)+(m*g(i)-2*sinh(y(i-1)))*dt+sqrt(2*m*dt)*randn;
end

[~,p] = Normative_Accuracy_Interrogation_Fixed_g(m,g,h_o,h_e,p_0,t_0,dt,t_f,b,dy);

[i,j] = size(p);
for ii = 1:i
    for jj = 1:j
        if p(ii,jj) <= 10^-10
            p(ii,jj) = eps;
        end
    end
end
p = log10(abs(p));
imagesc(t,-b:dy:b,p',[-12 0])
colorbar
colormap hot
hold on
plot(t,g*3.9124,'k--')
plot(t,y,'k')
plot(t,zeros(1,length(t)),'k:')
title('p(y,t)');
xlabel('t'); ylabel('y');
set(gca,'YDir','normal')