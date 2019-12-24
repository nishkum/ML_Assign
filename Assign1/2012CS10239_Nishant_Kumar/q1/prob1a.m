% This script is for Question - 1(a), 1(b)

% First clear the command window and the workspace
clc;
clear;

% Set the desired configuration values
learningRate = 1.0;
thetaInit = [0;0];
eps = 1.0e-06;

% Next, load the data
X = load('q1x.dat');
Y = load('q1y.dat');

NX = normalize(X);
NY = Y;

m = size(X,1);

datax = [ones(m,1) NX];
datay = Y;


% Call the batch Gradient Descent algorithm that returns the final value of
% theta.
[thFinal,Jfinal,numIter,iterTheta,iterJtheta] = batchGD(thetaInit,learningRate,eps,datax,datay);
fprintf('Final Value of Theta : [Theta0 = %f , Theta1 = %f]\n',thFinal);
fprintf('Total number of iterations taken :%d\n',numIter);
fprintf('Final value of JTheta : %f\n\n',Jfinal);

% The scatter plot of x vs y and the hypothesis function
hold on;
scatter(NX,NY,'*');
plot(NX,datax*thFinal,'-r');

xlabel('x1');
ylabel('x2');
title('Scatter Plot and hypothesis function learnt with learning Rate = 1.0,eps = 1.0e-6','FontSize',12.5,'Color','k');
leg = legend('Data points','Hypothesis Function learned','Location','East');
set(leg,'FontSize',12.5);