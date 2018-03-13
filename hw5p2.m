sig_x = 1;
sig_xy = -.5;
sig_y = 3;
mu_x = 1;
mu_y = 0;

X = 1;
Y = 0;

for n=1:100000
    mu = mu_x + sig_xy*inv(sig_y)*(Y(1)-mu_y);
    sig = sig_x-sig_xy*inv(sig_y)*sig_xy;
    X(n+1) = normrnd(mu,sig);
    
    mu = mu_y + sig_xy*inv(sig_x)*(X(n+1)-mu_x);
    sig = sig_y-sig_xy*inv(sig_x)*sig_xy;
    Y(n+1) = normrnd(mu,sig);
end

figure
histogram(X(1000:100000),200)
figure
histogram(Y(1000:100000),200)

