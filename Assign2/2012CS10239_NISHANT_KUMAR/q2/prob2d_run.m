clear;
clc;

% ThetaInit will then be in [-thInitRange/2,+thInitRange/2]
thInitRange = 0.20;
eps = 1.0e-3;

% Create the ThetaInit matrices
thi1 = thInitRange*rand(100,785)-thInitRange/2;
thi2 = thInitRange*rand(10,101)-thInitRange/2;

load('mnist_bin_shuffled');
% train0..9 is loaded in datanew

tic;
[th1, th2] = stoc_grd(thi1,thi2,eps,datanew);
timeTaken = toc;

fprintf('Time taken for training is : %.5f\n\n',timeTaken);

save('prob2d_output');