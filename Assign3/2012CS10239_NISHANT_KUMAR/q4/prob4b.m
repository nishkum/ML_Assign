clear;
clc;

m = 2429;
n = 361;
X = zeros(m,n);

for i=1:m
    temp = double(imread(strcat('./q5_data/face',sprintf('%05d',i) ,'.pgm')));
    temp = reshape(temp, [361,1]);
    X(i,:) = temp';
end

meanX = mean(X);
NX = X - repmat(meanX, m, 1);

% NX has faces with average face subtracted out
[U,S,V] = svd(NX);

% Now columns of V are the principal components of NX
prin = V(:, 1:50);

save('prinComp');