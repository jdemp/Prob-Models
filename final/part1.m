clear all
n=1000;
X = linspace(-10,10,n);
Y = linspace(-10,10,n);
for i=1:n
    for j=1:n
        F(i,j)=fun([X(i) Y(i)]);
    end
end



% surf(X,Y,F);
n = 1000;
X = -10 + 20*rand(n,2);
for i=1:n
    Y(i) = noisy_fun(X(i,:));
end

gprMd1 = fitrgp(X,Y');
ypred = resubPredict(gprMd1);
%contourf(X(:,1),X(:,2),Y)
%contourf(X(:,1),X(:,2),ypred)



function f=fun(var)
    x = var(1);
    y = var(2);
    mu = [1 1;5 -8;-4 3];
    sigma = cat(3,[1 1],[2 2],[3 3]);
    gm = gmdistribution(mu,sigma); 
    p = pdf(gm,[x,y]);
    f = (10*x + 5*y)*p;
end

function f=noisy_fun(var)
    f=fun(var);
    f = f + normrnd(0,.2);
end




