steps = 100;
X = linspace(-10,10,steps);
Y = linspace(-10,10,steps);
for i=1:steps
    for j=1:steps
        F(i,j)=noisy_fun(X(i),Y(j));
    end
end
surf(X,Y,F)

function f=fun(x,y)
    mu = [1 1;5 -8;-4 3];
    sigma = cat(3,[1 1],[2 2],[3 3]);
    gm = gmdistribution(mu,sigma); 
    p = pdf(gm,[x,y]);
    f = (10*x + 5*y)*p;
end

function f=noisy_fun(x,y)
    f=fun(x,y);
    f = f + normrnd(0,.05);
end




