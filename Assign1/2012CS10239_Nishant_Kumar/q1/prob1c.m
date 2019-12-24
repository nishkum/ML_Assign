% This script is for question - 1(d)

% First clear the command window and the workspace
clc;
clear;

% Set the desired configuration values
useTimePause = true;    % Set to false to use keypress
timePause = 0.2;        % If using timeGap, then the value of timePause

learningRate = 0.1;     % The learning Rate
thetaInit = [0;0];      % The initial Theta
eps = 1.0e-06;          % Epsilon

numOfDP = 20;           % The number of data points to plot

% Next, load the data
X = load('q1x.dat');
Y = load('q1y.dat');

m = size(X,1);
NX = normalize(X);
NY = Y;
datax = [ones(m,1) NX];
datay = Y;

[th0,th1] = meshgrid(linspace(-7,17,numOfDP),linspace(-7,17,numOfDP));
jth = zeros(numOfDP,numOfDP);
for i=1:numOfDP
    for j=1:numOfDP
        jth(i,j) = calJtheta(datax,datay,[th0(i,j);th1(i,j)]);
    end
end


conPlot = contour(th0,th1,jth);
title('Scatter Plot and hypothesis function learnt with learning Rate = 0.1,eps = 1.0e-6','FontSize',12.5,'Color','k');


xlabel('Theta0');
ylabel('Theta1');
hold on;
[thFinal,Jfinal,numIter,iterTheta,iterJtheta] = batchGD(thetaInit,learningRate,eps,datax,datay);

if not(useTimePause)
    % Use buttonPress for viewing
    for i=1:numIter
        key = waitforbuttonpress;
        if key==0
            scatter(iterTheta(i,1),iterTheta(i,2),'filled','d');
        end
    end
else
    % Use pause instead of buttonPress for viewing
    for i=1:numIter
        pause(timePause);
        scatter(iterTheta(i,1),iterTheta(i,2),'filled','d');
    end
end


