clear;
clc;

load('mnist_all');

% 3 is represented by 0 and 8 by 1
s3 = 0*ones(size(train3,1),1);
s8 = 1*ones(size(train8,1),1);

data3 = [s3 train3];
data8 = [s8 train8];
data = [data3;data8];

% Randomly shuffle the data
datanew = double(data(randperm(size(data,1)),:));

save('mnist_bin38.mat','datanew');