close all
clear all

exampleA1 = [
    [1,0,0,0,0,0,0,0,0,0]
    [1,0,0,0,0,0,0,0,0,0]
    [0,1,0,0,0,0,0,0,0,0]
    [0,1,0,0,0,0,0,0,0,0]
    [0,0,1,0,0,0,0,0,0,0]
    [0,0,1,0,0,0,0,0,0,0]
    [0,0,0,1,0,0,0,0,0,0]
    [0,0,0,1,0,0,0,0,0,0]
    [0,0,0,0,1,0,0,0,0,0]
    [0,0,0,0,1,0,0,0,0,0]
];
exampleA2 = [
    [0,1,0,0,0,0,0,0,0,0]
    [0,1,0,0,0,0,0,0,0,0]
    [0,0,1,0,0,0,0,0,0,0]
    [0,0,1,0,0,0,0,0,0,0]
    [0,0,0,1,0,0,0,0,0,0]
    [0,0,0,1,0,0,0,0,0,0]
    [0,0,0,0,1,0,0,0,0,0]
    [0,0,0,0,1,0,0,0,0,0]
    [0,0,0,0,0,1,0,0,0,0]
    [0,0,0,0,0,1,0,0,0,0]
];
exampleB1 = [
    [1,0,0,0,0,0,0,0,0,0]
    [1,0,0,0,0,0,0,0,0,0]
    [0,1,0,0,0,0,0,0,0,0]
    [0,1,0,0,0,0,0,0,0,0]
    [0,0,1,0,0,0,0,0,0,0]
    [0,0,1,0,0,0,0,0,0,0]
    [0,0,0,1,0,0,0,0,0,0]
    [0,0,0,1,0,0,0,0,0,0]
    [0,0,0,0,1,0,0,0,0,0]
    [0,0,0,0,1,0,0,0,0,0]
];
exampleB2 = [
    [1,0,0,0,0,0,0,0,0,0]
    [0,1,0,0,0,0,0,0,0,0]
    [0,1,0,0,0,0,0,0,0,0]
    [0,0,1,0,0,0,0,0,0,0]
    [0,0,1,0,0,0,0,0,0,0]
    [0,0,0,1,0,0,0,0,0,0]
    [0,0,0,1,0,0,0,0,0,0]
    [0,0,0,0,1,0,0,0,0,0]
    [0,0,0,0,1,0,0,0,0,0]
    [0,0,0,0,0,1,0,0,0,0]
];
exampleC1 = [
    [0,0,0,0,0,0,0,0,0,0]
    [0,0,0,0,0,0,0,0,0,0]
    [0,0,0,0,0,0,0,0,0,0]
    [1,1,1,1,1,1,0,0,0,0]
    [0,0,0,0,0,1,0,0,0,0]
    [0,0,0,0,0,1,0,0,0,0]
    [0,0,0,0,0,1,0,0,0,0]
    [0,0,0,0,0,1,0,0,0,0]
    [0,0,0,0,0,1,0,0,0,0]
    [0,0,0,0,0,1,0,0,0,0]
];
exampleC2 = [
    [0,0,0,0,0,0,0,0,0,0]
    [0,0,0,0,0,0,0,0,0,0]
    [0,0,0,0,0,0,0,0,0,0]
    [0,0,0,0,0,0,0,0,0,0]
    [1,1,1,1,1,1,1,1,0,0]
    [0,0,0,0,0,0,0,1,0,0]
    [0,0,0,0,0,0,0,1,0,0]
    [0,0,0,0,0,0,0,1,0,0]
    [0,0,0,0,0,0,0,1,0,0]
    [0,0,0,0,0,0,0,1,0,0]
];

%% Task 1
pv = log_likelihood(exampleA1,exampleA2);
figure()
h= heatmap(-2:2,-2:2,pv);
h.Colormap=autumn;
h.CellLabelColor='none';

pv = log_likelihood(exampleB1,exampleB2);

figure()
h= heatmap(-2:2,-2:2,pv);
h.Colormap=autumn;
h.CellLabelColor='none';

pv = log_likelihood(exampleC1,exampleC2);
figure()
h= heatmap(-2:2,-2:2,pv)
h.Colormap=autumn;
h.CellLabelColor='none';


%% Task 2
pv = log_post(exampleA1,exampleA2);
figure()
h= heatmap(-2:2,-2:2,pv);
h.Colormap=autumn;
h.CellLabelColor='none';

pv = log_post(exampleB1,exampleB2);
figure()
h= heatmap(-2:2,-2:2,pv);
h.Colormap=autumn;
h.CellLabelColor='none';

pv = log_post(exampleC1,exampleC2);
figure()
h= heatmap(-2:2,-2:2,pv);
h.Colormap=autumn;
h.CellLabelColor='none';


%% Task 3
pv = log_post(exampleA1,exampleA2);
pv = exp(pv);
pv = (pv/sum(sum(pv)));
figure()
h= heatmap(-2:2,-2:2,pv);
h.Colormap=autumn;
h.CellLabelColor='none';

pv = log_post(exampleB1,exampleB2);
pv = exp(pv);
pv = (pv/sum(sum(pv)));
figure()
h= heatmap(-2:2,-2:2,pv);
h.Colormap=autumn;
h.CellLabelColor='none';

pv = log_post(exampleC1,exampleC2);
pv = exp(pv);
pv = (pv/sum(sum(pv)));
figure()
h= heatmap(-2:2,-2:2,pv)
h.Colormap=autumn;
h.CellLabelColor='none';

function log_like=log_likelihood(I1,I2)
log_like = zeros(5,5);
for vx=-2:2
    for vy=-2:2
        for px = 1:10
            for py= 1:10
                if px+vx<=10 && px+vx>=1 && py+vy>=1 && py+vy<=10
                    p = exp(-1*(I1(px,py)-I2(px+vx,py+vy))^2/(2*.5^2));
                    log_like(vx+3,vy+3) = log_like(vx+3,vy+3)+log(p);
                end     
            end 
        end 
        log_like(vx+3,vy+3) = log_like(vx+3,vy+3);
    end   
end
end

function log_like = log_post(I1,I2)
log_like = zeros(5,5);
for vx=-2:2
    for vy=-2:2
        for px = 1:10
            for py= 1:10
                if px+vx<=10 && px+vx>=1 && py+vy>=1 && py+vy<=10
                    p = exp(-1*(I1(px,py)-I2(px+vx,py+vy))^2/(2*.5^2));
                    log_like(vx+3,vy+3) = log_like(vx+3,vy+3)+log(p);
                end     
            end 
        end 
        log_like(vx+3,vy+3) = log_like(vx+3,vy+3) +log(exp(-1/(2*.5)*(vx^2+vy^2)));
    end   
end
end
