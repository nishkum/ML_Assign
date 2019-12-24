clear;
clc;

load('prinComp');
% faceNo = [305 456 758 2000];
faceNo = randi(m,1,4);

nfaces = size(faceNo, 2);

% Each row of faces is the original image
faces = X(faceNo,:);
% Each row of faceComp is the projection of that row's original image onto
% the 50 eigenvectors
faceComp = faces*prin;
% Each row of pfaces is the new projected face
pfaces = (prin*faceComp')';

nrows = size(faceNo,2);
ncols = 2;

figure(1); 
clf;
set(gcf, 'Name', 'Projected Faces');
for i=1:2:nrows*ncols
    fn = (i+1)/2;
    subplot(nrows,ncols,i);
    imagesc( reshape(faces(fn,:),19,19) );
    colormap gray; 
    axis equal tight off;
    title(['Orig ' num2str(faceNo(fn))]);
    
    subplot(nrows,ncols,i+1);
    imagesc( reshape(pfaces(fn,:),19,19) );
    colormap gray; 
    axis equal tight off;
    title(['Proj ' num2str(faceNo(fn))]);
end
