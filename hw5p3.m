clear all
import brml.*
% Do Metropolis sampling:
L=200000; % number of samples
x(:,1)=randn(2,1); % intial sample
s=2; % width of Metropolis candidate distribution
for l=2:L
	x(:,l)=metropolis(x(:,l-1),s,'fgprob');
end

figure
plot(x(1,:),x(2,:),'.');

figure
hist3(x');

F = mean(x(1,:));
G = mean(x(2,:));
F*G