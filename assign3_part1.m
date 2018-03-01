clear all
close all
X = 0:0.01:1;
h = 0; t = 0;
V_h = 1;
V_t = 1;
ct = 1;
label = 'priors';
for outcome = [1 0 0 1 0 0 0 1 ]
   subplot(2,4,ct)
   p = betapdf(X,V_h+h,V_t+t);
   hold on
   plot(X, p);
   title(label);
   xlabel('model');
   h = h + outcome;
   t = t + (1-outcome);
   
   label = 'T';
   if (outcome)
      label = 'H';
   end
   label = sprintf('trial %d: %s',ct,label);
   ct = ct + 1;
   hold off
end