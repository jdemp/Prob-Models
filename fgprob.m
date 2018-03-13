function p = fgprob(X)
zf = 1;
zg = 1;
if X(1)>1 || X(1)<0
    pf = 0;
else   
    pf = X(1)^3/zf;
end
if X(2)>1 || X(2)<0
    pgfc = 0;
else
    pgfc = (1-abs(X(2)-X(1)))/zg;
end

p = pf*pgfc;
p = log(p);
end
