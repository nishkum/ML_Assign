clear;
clc;

load('mnist_all.mat');

% First find the accuracy for test3 and test8 - 2(b)
load('prob2b_output');

% For test3
[m,n] = size(test3); 
o2 = sigmoid(th1*[ones(m,1) double(test3)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 1
correctClass3 = sum(o3<0.5)/m;

% For test8
[m,n] = size(test8); 
o2 = sigmoid(th1*[ones(m,1) double(test8)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 1
correctClass8 = sum(o3>0.5)/m;
fprintf('Accuracy for test3 = %.5f and for test8 = %.5f\n',correctClass3*100,correctClass8*100);

