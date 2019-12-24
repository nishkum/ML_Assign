% Script that loads the output of gaussian kernel for cvx on train-small
% and finds the supportVectors and the accuracy

clear;
clc;

eps = 1.0e-4;
load('cvx-train-small_gaussian.mat');

% First find the support vectors
supportVec = (A > eps);

AlphaY = A.*Y;
[m,n] = size(X);
gamma = 2.5e-4;

% Now find the test case accuracy
testX = load('test_train-small_features_cvx.txt');
testCorrectOut = load('test_Y.txt');
testNumCases = size(testX,1);

testY = zeros(testNumCases,1);
for i=1:testNumCases
    tempx = X - repmat(testX(i,:),m,1);
    kernelTemp = exp(-gamma*sum(tempx.*tempx,2));
    testY(i) = AlphaY'*kernelTemp;
end

% testY now has w'*x
% Now add b
temp = (A>2*eps & A<1-2*eps);
Ytemp = Y(temp);
Xtemp = X(temp,:);
YPosLog = (Ytemp==1);
Xpos = Xtemp(YPosLog,:);
Xneg = Xtemp(~YPosLog,:);
XtoConsider = (Xpos(1,:)+Xneg(1,:));

tempx = X - repmat(XtoConsider,m,1);
kernelTemp = exp(-gamma*sum(tempx.*tempx,2));
B = -0.5*(AlphaY'*kernelTemp);

testY = testY+B;

testPredict = ones(testNumCases,1);
testPredict(testY<0) = -1;

correctPredict = sum(testPredict==testCorrectOut);
accuracy = correctPredict/testNumCases;

fprintf('The number of support vectors for gaussian kernel for cvx on train-small is %d\n',sum(supportVec));
fprintf('Value of intercept term b = %.4f\n',B);
fprintf('The prediction accuracy after learning is %.4f\n',accuracy*100);