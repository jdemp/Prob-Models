%% A
posterior_est(120)
%% B
posterior_est(60)
%% C
posterior_est(20)


function posterior_est(S)
posterior = zeros(2,2);
for x=1:10000
    I = normrnd(100,15); % Normal(mean=100, sd=15)
    M = rand < 1/(1+exp(-(I-110)/5)); % = 1 if Major=compsci, 0 if Major=business
    U = rand < 1/(1+exp(-(I-100)/5)); % = 1 if University=cu, 0 if University=metro
    w=gampdf(S,.1 * I + M + 3 * U,5); 
    posterior(M+1,U+1) = posterior(M+1,U+1)+w;
end

total = sum(sum(posterior));
business_metro = posterior(1,1)/total;
business_cu = posterior(1,2)/total;
cs_metro = posterior(2,1)/total;
cs_cu = posterior(2,2)/total;
Probs = [business_metro,business_cu,cs_metro,cs_cu];
t=table({'P(B,M)','P(B,CU)','P(CS,M)','P(CS,CU)'}',Probs')
end
