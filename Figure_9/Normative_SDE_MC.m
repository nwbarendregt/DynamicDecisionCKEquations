function acc = Normative_SDE_MC(m,h_o,h_e,t_0,t_f,dt,nsamp)

t = t_0:dt:t_f;
y = 0;
if rand < 0.5
    g = 1;
else
    g = -1;
end

acc = zeros(nsamp,1);
for n = 1:nsamp
    for i = 1:(length(t)-1)
        if rand < dt*h_e
            g = -g;
        end
        y = y+(m*g-2*h_o/h_e*sinh(y))*dt+sqrt(2*m*dt)*randn;
    end
    if sign(y) == g
        acc(n) = 1;
    end
end

acc = mean(acc);