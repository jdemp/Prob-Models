y0 = [0,0]';
Y(:,1)=y0;
sigma = .2;
a1 = 1.02;
a2 = -1.01;
Z(1) = Y(1,1) + normrnd(0,sigma);
for i=2:500
    y2 = Y(1,i-1) + normrnd(0,sigma);
    y1 = a1*Y(1,i-1) + a2*Y(2,i-1) + normrnd(0,sigma);
    Y(:,i) = [y1,y2];
    Z(i) = y1 + normrnd(0,sigma);
end

F = [a1 a2; 1 0];
H = [1 0];
P = diag([10,10]);
Q = diag([1,1]);
R = 1;

for i=2:500
    x_est = F*Y(:,i-1);
    P_est = F*P*F' + Q;
    K = P_est*H'*inv(H*P_est*H'+R);
    x = x_est + K*(Z(i)-H*x_est);
    [m,n]=size(P_est);
    P = (eye(m)-K*H)*P_est;
    
    P_hist(i,:,:) = P;
    X(:,i) = x;
end

figure()
plot(Y(1,:),Y(2,:))
figure()
plot(1:500,Z)