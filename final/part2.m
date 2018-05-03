clear all
y0 = [0,0]';
Y(:,1)=y0;
sigma = .2;
a1 = 1.02;
a2 = -1.01;
Z(1) = Y(1,1) + normrnd(0,sigma);
for i=2:250
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
sigma_y1(1) = 10;
sigma_y2(1) = 10;
for i=2:250
    x_est = F*Y(:,i-1);
    P_est = F*P*F' + Q;
    K = P_est*H'*inv(H*P_est*H'+R);
 
    x = x_est + K*(Z(i)-H*x_est);
    [m,n]=size(P_est);
    P = (eye(m)-K*H)*P_est;
    
    sigma_y1(i) = sqrt(P(1,1));
    sigma_y2(i) = sqrt(P(2,2));
    X(:,i) = x;
end

figure()
hold on
title('Actual Position')
plot(Y(1,:),Y(2,:))
hold off

figure()
hold on
title('Measurements')
plot(1:250,Z)
hold off


figure() 
hold on
title('Recovered Position')
plot(X(1,:),X(2,:))
hold off


figure()
hold on
title('Y1 Estimate')
plot(1:250,Y(1,:))
plot(1:250,Y(1,:)+2*sigma_y1)
plot(1:250,Y(1,:)-2*sigma_y1)
legend('Y1','+2sigma','-2sigma')
hold off

figure()
hold on
title('Y2 Estimate')
plot(1:250,Y(2,:))
plot(1:250,Y(2,:)+2*sigma_y2)
plot(1:250,Y(2,:)-2*sigma_y2)
legend('Y2','+2sigma','-2sigma')
hold off




