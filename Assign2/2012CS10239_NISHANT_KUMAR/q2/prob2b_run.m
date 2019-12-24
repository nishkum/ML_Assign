clear;
clc;

% ThetaInit will then be in [-thInitRange/2,thInitRange/2]
thInitRange = 0.20;
eps = 1.0e-4;

% Create the ThetaInit matrices
thi1 = thInitRange*rand(100,785)-thInitRange/2;
thi2 = thInitRange*rand(1,101)-thInitRange/2;

load('mnist_bin38.mat');
% Datanew has been made double in create_mnist_bin38 now


tic;
[th1, th2] = stoc_grd(thi1,thi2,eps,datanew);
timeTaken = toc;

fprintf('Time taken for training is : %.5f\n\n',timeTaken);

save('prob2b_output');