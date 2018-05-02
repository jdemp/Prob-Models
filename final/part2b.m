y0 = [0,0]';
Y(:,1)=y0;
sigma = .1;
modes=[1.02 -1.01;1.05 -1.03;.98 -.8];
Z(1) = Y(1,1) + normrnd(0,sigma);
mode = randi(3);
b = .1;
for i=2:500
    change = rand;
    if change<b
        mode = randi(3);
    end
    a1 = modes(mode,1);
    a2 = modes(mode,2);
    y2 = Y(1,i-1) + normrnd(0,sigma);
    y1 = a1*Y(1,i-1) + a2*Y(2,i-1) + normrnd(0,sigma);
    Y(:,i) = [y1,y2];
    Z(i) = y1 + normrnd(0,sigma);
end

figure()
plot(Y(1,:),Y(2,:))
figure()
plot(1:500,Z)