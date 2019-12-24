% Script that loads the output of linear kernel for train-small for cvx and
% calculates the accuracy

clear;
clc;

% Cutoff for recognizing the support vectors
eps = 1.0e-4;
load('cvx-train-small_linear.mat');

% First find the support vectors
supportVec = (A > eps);

% Now find w and b
W = (A'*XY)';
temp = (A>2*eps & A<1-2*eps);
Ytemp = Y(temp);
Xtemp = X(temp,:);
YPosLog = (Ytemp==1);
Xpos = Xtemp(YPosLog,:);
Xneg = Xtemp(~YPosLog,:);
B = -0.5*(W'*(Xpos(1,:)+Xneg(1,:))');

% Now find the test case accuracy
testX = load('test_train-small_features_cvx.txt');
testCorrectOut = load('test_Y.txt');
testNumCases = size(testX,1);

testY = testX*W+B;
testPredict = ones(testNumCases,1);
testPredict(testY<0) = -1;

correctPredict = sum(testPredict==testCorrectOut);
accuracy = correctPredict/testNumCases;

fprintf('The number of support vectors for linear kernel for cvx on train-small is %d\n',sum(supportVec));
fprintf('Value of intercept term b = %.4f\n',B);
fprintf('The prediction accuracy after learning is %.4f\n',accuracy*100);