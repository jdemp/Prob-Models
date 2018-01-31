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
figure
bar(1:10,P_sig12)

%% Task 2
X=[1.5,0.5];
p_HX=[];

for h=1:10
    if X>[-h,-h] & X<[h,h] %#ok<*BDSCA,BDSCI,*AND2>
        p_xh(h) = 1/(2*h^2);
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

%% Task 3
sigma=10;
X=[1.5,0.5];
for h=1:10
    p = exp(-2*(2*h/sigma));
    if X>[-h,-h] & X<[h,h] %#ok<*BDSCA,BDSCI,*AND2>
        p_xh = 1/(2*h^2);
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
            if [I(i),J(j)]>[-h,-h] & [I(i),J(j)]<[h,h]    
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
contourf(log(P_ij))

%% Task 4
sigma=10;
X=[4.5,2.5];
for h=1:10
    p = exp(-2*(2*h/sigma));
    if X>[-h,-h] & X<[h,h] %#ok<*BDSCA,BDSCI,*AND2>
        p_xh = 1/(2*h^2);
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
            if [I(i),J(j)]>[-h,-h] & [I(i),J(j)]<[h,h]    
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
contourf(log(P_ij))