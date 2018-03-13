clear all
import brml.*
% Do Metropolis sampling:
L=200000; % number of samples
x(:,1)=rand(2,1); % intial sample
s=2; % width of Metropolis candidate distribution
for l=2:L
	x(:,l)=metropolis(x(:,l-1),s,'fgprob');
end

figure
dat = hist3(x');
dat = dat+1;
dat = dat/sum(sum(dat));
dat = rot90(dat,1);
heatmap(0:.1:.9,.9:-.1:0,dat)

F = mean(x(1,:));
G = mean(x(2,:));
expected = F*G