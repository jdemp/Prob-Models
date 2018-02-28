function weissPatterns
% This code generates 3 motion patterns, each consisting of two snapshots
% of an image at successive times.  It then computes the likelihood of
% all motions with x-velocities in {-2, -1, 0, 1, 2} and y-velocities in
% {-2, -1, 0, 1, 2}.

for pat = 1:3
   [image1, image2] = generate_example(pat);
   plot_example(image1,image2, pat);
   print_array(['example' 64+pat '1'],image1);
   print_array(['example' 64+pat '2'],image2);
end

function print_array(name, arr)
fprintf('%s = [\n',name);
for r = 1:size(arr,1)
   fprintf('    [');
   for c=1:size(arr,2)
      fprintf('%d',arr(r,c));
      if (c < size(arr,2))
         fprintf(',');
      end
   end
   fprintf('],\n');
end
fprintf('];\n');

function [image1, image2] = generate_example(ix)
% this function generates one of three examples (for ix = 1, 2, 3)
% each example is a pair of images:  image1 is the initial image,
% image2 is the image delta-t time steps later
image1 = ...
    [1 0 0 0 0 0 0 0 0 0
     1 0 0 0 0 0 0 0 0 0
     0 1 0 0 0 0 0 0 0 0 
     0 1 0 0 0 0 0 0 0 0
     0 0 1 0 0 0 0 0 0 0 
     0 0 1 0 0 0 0 0 0 0
     0 0 0 1 0 0 0 0 0 0
     0 0 0 1 0 0 0 0 0 0
     0 0 0 0 1 0 0 0 0 0
     0 0 0 0 1 0 0 0 0 0];
if (ix == 1)  
   image2 = [image1(:,10) image1(:,1:9)];
elseif (ix == 2)
   image2 = blkdiag([1 zeros(1,9); zeros(9,1 ) image1(1:9,1:9)]);
else
   image1 = ...
    [0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 
     1 1 1 1 1 1 0 0 0 0
     0 0 0 0 0 1 0 0 0 0 
     0 0 0 0 0 1 0 0 0 0
     0 0 0 0 0 1 0 0 0 0
     0 0 0 0 0 1 0 0 0 0
     0 0 0 0 0 1 0 0 0 0
     0 0 0 0 0 1 0 0 0 0];

   image2 = blkdiag([zeros(1,2) zeros(1,8); zeros(9,2) image1(1:9,1:8)]);
   image2(5,1:2)=[1 1];
end

function plot_example(image1,image2,ix)
figure(1)
subplot(1,3,ix)
colormap([0 0 0;1 0 0;0 1 0;1 1 0])
image(image1+2*image2+1)
%set(gca,'ydir','normal')
set(gca,'xtick',1:10);
set(gca,'ytick',1:10);
axis square
axis on

