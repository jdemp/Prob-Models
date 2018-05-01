function [x_est_k1, P_est_k1] = kf_step(F,Q,H,R,x,P,y)
  x_k1 = F*x;
  P_k1 = F*P*F' + Q;
  K = P_k1*H'*inv(H*P_k1*H'+R);
  
  x_est_k1 = x_k1 + K*(y-H*x_k1);
  [m,n]=size(P_k1);
  P_est_k1 = (eye(m)-K*H)*P_k1;
end