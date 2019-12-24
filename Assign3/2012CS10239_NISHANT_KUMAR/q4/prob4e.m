clear;
clc;

load('prinComp');
nfm = 4;
nfn = 361;
nfdata = zeros(nfm,nfn);
for i=1:nfm
    temp = imread(['./nonfaces/nf' num2str(i) '.jpg']);
    temp = imresize(temp,[19,19]);
    temp = rgb2gray(temp);
    temp = reshape(temp,[361 1]);
    nfdata(i,:) = temp';
end

% Each row of faceComp is the projection of that row's original image onto
% the 50 eigenvectors
faceComp = nfdata*prin;
% Each row of pfaces is the new projected face
pfaces = (prin*faceComp')';

nrows = nfm;
ncols = 2;

figure(1); 
clf;
set(gcf, 'Name', 'Projected Faces');
for i=1:2:nrows*ncols
    fn = (i+1)/2;
    subplot(nrows,ncols,i);
    imagesc( reshape(nfdata(fn,:),19,19) );
    colormap gray; 
    axis equal tight off;
    title(['Orig ' num2str(fn)]);
    
    subplot(nrows,ncols,i+1);
    imagesc( reshape(pfaces(fn,:),19,19) );
    colormap gray; 
    axis equal tight off;
    title(['Proj ' num2str(fn)]);
end
