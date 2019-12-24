clear;
clc;

load('prinComp');

subprows = 2;
subpcols = 3;
figure(1); 
clf; 
set(gcf, 'Name', 'EigenFaces');
for i=1:subprows*subpcols
    subplot(subprows,subpcols,i);
    imagesc( reshape(prin(:,i),19,19) );
    colormap gray; 
    axis equal tight off;
    title([num2str(i) ') EigV=' num2str(S(i,i),'%1.2e')]);
end
