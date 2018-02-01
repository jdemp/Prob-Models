
clear all
close all
%% Task 1
sigma = 6;
p = [];
for h=1:10
    p(h) = exp(-2*(2*h/sigma));
end
P_sig6 = p/sum(p);

sigma=12;
for h=1:10
    p12(h) = exp(-2*(2*h/sigma));
end
P_sig12 = p12/sum(p12);

figure
bar(1:10,P_sig6)
title('Task 1 sigma=6')
xlabel('Hypothesis')
ylabel('Probability')

figure
bar(1:10,P_sig12)
title('Task 1 sigma=12')
xlabel('Hypothesis')
ylabel('Probability')

%% Task 2
X=[1.5,0.5];
p_HX=[];

for h=1:10
    if X>[-h,-h] & X<[h,h] %#ok<*BDSCA,BDSCI,*AND2>
        p_xh(h) = 1/((2*h)^2);
    else
        p_xh(h)=0;
    end   
end
P_xh = p_xh/sum(p_xh);

for h=1:10
   p_HX(h)= p_xh(h)*p12(h);
end

P_XH=p_HX/sum(p_HX);
figure
bar(1:10,P_XH)
title('Task 2 Observation')
xlabel('Hypothesis')
ylabel('Probability')

%% Task 3
sigma=10;
X=[1.5,0.5];
for h=1:10
    p = exp(-2*(2*h/sigma));
    if X>=[-h,-h] & X<=[h,h] %#ok<*BDSCA,BDSCI,*AND2>
        p_xh = 1/((2*h)^2);
    else
        p_xh=0;
    end
    phx(h) = p*p_xh;
end

I=-10:.1:10;
J=-10:.1:10;

for i=1:length(I)
    for j=1:length(J)
        p=0;
        for h=1:10
            if [I(i),J(j)]>=[-h,-h] & [I(i),J(j)]<=[h,h]    
                p=p+phx(h);
            else
                p=p+0;
            end
        end
        p_ij(i,j)=p;
    end
end

P_ij = p_ij/sum(sum(p_ij));
figure
contourf(-10:.1:10,-10:.1:10,log(P_ij))
colormap(hot)
title('Task 3 X={[1.5,0.5]}')
c=colorbar;
c.Label.String = 'log(P(Q|X))';

%% Task 4
clear all
sigma=10;
X=[4.5,2.5];
for h=1:10
    p = exp(-2*(2*h/sigma));
    if X>=[-h,-h] & X<=[h,h] %#ok<*BDSCA,BDSCI,*AND2>
        p_xh = 1/((2*h)^2);
    else
        p_xh=0;
    end
    phx(h) = p*p_xh;
end

I=-10:.1:10;
J=-10:.1:10;

for i=1:length(I)
    for j=1:length(J)
        p=0;
        for h=1:10
            if [I(i),J(j)]>=[-h,-h] & [I(i),J(j)]<=[h,h]    
                p=p+phx(h);
            else
                p=p+0;
            end
        end
        p_ij(i,j)=p;
    end
end

P_ij = p_ij/sum(sum(p_ij));
figure
contourf(-10:.1:10,-10:.1:10,log(P_ij))
colormap(hot)
title('Task 4 X={[4.5,2.5]}')
c=colorbar;
c.Label.String = 'log(P(Q|X))';

%% Task 5
clear all
sigma=30;
X=[2.2,-.2];
for h=1:10
    p = exp(-2*(2*h/sigma));
    if X>=[-h,-h] & X<=[h,h] %#ok<*BDSCA,BDSCI,*AND2>
        p_xh = 1/((2*h)^2);
    else
        p_xh=0;
    end
    phx(h) = p*p_xh;
end

I=-10:.1:10;
J=-10:.1:10;

for i=1:length(I)
    for j=1:length(J)
        p=0;
        for h=1:10
            if [I(i),J(j)]>=[-h,-h] & [I(i),J(j)]<=[h,h]    
                p=p+phx(h);
            else
                p=p+0;
            end
        end
        p_ij(i,j)=p;
    end
end

P_ij = p_ij/sum(sum(p_ij));
max(max(P_ij))
figure
contourf(-10:.1:10,-10:.1:10,log(P_ij))
colormap(hot)
title('Task 5.1 X={[2.2,-.2]}')
c=colorbar;
c.Label.String = 'log(P(Q|X))';

clear all
sigma=30;
X1=[2.2,-.2];
X2=[.5,.5];
for h=1:10
    p = exp(-2*(2*h/sigma));
    if X1>=[-h,-h] & X1<=[h,h] & X2>=[-h,-h] & X2<=[h,h] %#ok<*BDSCA,BDSCI,*AND2>
        p_xh = 1/((2*h)^2)^2;
    else
        p_xh=0;
    end
    phx(h) = p*p_xh;
end

I=-10:.1:10;
J=-10:.1:10;

for i=1:length(I)
    for j=1:length(J)
        p=0;
        for h=1:10
            if [I(i),J(j)]>=[-h,-h] & [I(i),J(j)]<=[h,h]    
                p=p+phx(h);
            else
                p=p+0;
            end
        end
        p_ij(i,j)=p;
    end
end

P_ij = p_ij/sum(sum(p_ij));
max(max(P_ij))
figure
contourf(-10:.1:10,-10:.1:10,log(P_ij))
colormap(hot)
title('Task 5.2 X={[2.2,-.2],[.5,.5]}')
c=colorbar;
c.Label.String = 'log(P(Q|X))';

clear all
sigma=30;
X1=[2.2,-.2];
X2=[.5,.5];
X3=[1.5,1];
for h=1:10
    p = exp(-2*(2*h/sigma));
    if X1>=[-h,-h] & X1<=[h,h] & X2>=[-h,-h] & X2<=[h,h] & X3>=[-h,-h] & X3<=[h,h] %#ok<*BDSCA,BDSCI,*AND2>
        p_xh = 1/((2*h)^2)^3;
    else
        p_xh=0;
    end
    phx(h) = p*p_xh;
end

I=-10:.1:10;
J=-10:.1:10;

for i=1:length(I)
    for j=1:length(J)
        p=0;
        for h=1:10
            if [I(i),J(j)]>=[-h,-h] & [I(i),J(j)]<=[h,h]    
                p=p+phx(h);
            else
                p=p+0;
            end
        end
        p_ij(i,j)=p;
    end
end

P_ij = p_ij/sum(sum(p_ij));
max(max(P_ij))
figure
contourf(-10:.1:10,-10:.1:10,log(P_ij))
colormap(hot)
title('Task 5.3 X={[2.2,-.2],[.5,.5],[1.5,1]}')
c=colorbar;
c.Label.String = 'log(P(Q|X))';

%%
% *%As new example the posterior becomes 0 for some hypothesis if it does not
%include all of the examples. For hypothesis that do include all of the
%examples it really begins the favor the smaller hypotheses since as the
%number of examples increases the denominator of the likelihood function
%increases exponentially. So with bigger hypotheses the denominator will be
%very large in comparison to the smaller ones. This causes the posterior
%probability for smaller hypotheses that contain all points to get larger
%as more examples are added.* 
