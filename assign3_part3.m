measurement = [.75,-.6,1.4,-.2];

task1 = posterior(measurement,1);
task2 = posterior(measurement,5);
task3 = weighted_posterior(measurement,1);
task4 = weighted_posterior(measurement,5);

function p=posterior(meas,sig)
up = [0,1,0,1];
down = [0,-1,0,-1];
left = [-1,0,-1,0];
right = [1,0,1,0];
dir = [up;down;left;right];
p = zeros(4,1);
rx = meas(1);
ry = meas(2);
bx = meas(3);
by = meas(4);
for d=1:4
    D = dir(d,:);
    prx_d = normpdf(rx,D(1),sig);
    pry_d = normpdf(ry,D(2),sig);
    pbx_d = normpdf(bx,D(3),sig);
    pby_d = normpdf(by,D(4),sig);
    p(d) = prx_d*pry_d*pbx_d*pby_d;
end
p = p/sum(p);
end


function p=weighted_posterior(meas,sig)
up = [0,1,0,1];
down = [0,-1,0,-1];
left = [-1,0,-1,0];
right = [1,0,1,0];
dir = [up;down;left;right];
p = zeros(4,1);
rx = meas(1);
ry = meas(2);
bx = meas(3);
by = meas(4);
weights = [.125,.6250,.125,.125];
for d=1:4
    D = dir(d,:);
    prx_d = normpdf(rx,D(1),sig);
    pry_d = normpdf(ry,D(2),sig);
    pbx_d = normpdf(bx,D(3),sig);
    pby_d = normpdf(by,D(4),sig);
    p(d) = prx_d*pry_d*pbx_d*pby_d*weights(d);
end
p = p/sum(p);
end