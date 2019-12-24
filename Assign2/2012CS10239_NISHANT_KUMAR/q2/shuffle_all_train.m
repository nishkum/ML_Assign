clear;
clc;

load('mnist_all.mat');
toApp = eye(10);

data = [[repmat(toApp(1,:),size(train0,1),1) train0];
        [repmat(toApp(2,:),size(train1,1),1) train1];
        [repmat(toApp(3,:),size(train2,1),1) train2];
        [repmat(toApp(4,:),size(train3,1),1) train3];
        [repmat(toApp(5,:),size(train4,1),1) train4];
        [repmat(toApp(6,:),size(train5,1),1) train5];
        [repmat(toApp(7,:),size(train6,1),1) train6];
        [repmat(toApp(8,:),size(train7,1),1) train7];
        [repmat(toApp(9,:),size(train8,1),1) train8];
        [repmat(toApp(10,:),size(train9,1),1) train9];
        ];
    
datanew = double(data(randperm(size(data,1)),:));
save('mnist_bin_shuffled.mat','datanew');

