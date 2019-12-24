function dispPFig(filename)

image = double(imread(filename));
image = reshape(image, [361,1]);
load('prinComp');

% Calculate the projection of image on all the columns of prin
comp = image'*prin;

fimage = prin*comp';
figure;
clf;
imagesc( reshape(fimage,19,19) );
colormap gray; 
axis equal tight off;

end