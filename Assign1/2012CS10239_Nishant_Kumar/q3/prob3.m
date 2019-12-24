% This is a script for the 3rd question

% Clear the command window and workspace
clc;
clear;

% Load the data from the files
X = importdata('./q2x.dat');
Y = importdata('./q2y.dat');

% The number of training examples
m = size(X,1);

% Normalize data
NX = normalize(X);
NY = Y;

% Add a ones column to Normalized data
datax = [ones(m,1) NX];
datay = Y;

% Ylog is a logical vector corresponding to the outputs
Ylog = logical(NY);

% Xone and Xzero are vectors corresponding to the 2 classes - y=1 and y=0
Xone = NX;
Xzero = NX;

Xone(~Ylog,:) = [];
Xzero(Ylog,:) = [];

hold on;
% Plot the input normalized data
scatter(Xone(:,1),Xone(:,2),'r+');
scatter(Xzero(:,1),Xzero(:,2),'b*');

% Call Newton's method to get the apt final values
[FinalTheta,numIter] = newton([0;0;0] , datax , datay , 1.0e-06);

% Print the resultant values onto screen
fprintf('The final value of theta obtained is :\n Theta0 = %f,\n Theta1 = %f,\n Theta2 = %f\n\n',FinalTheta);
fprintf('Also the number of iterations is = %d\n\n' , numIter);


% Plot the decision boundary obtained on the same graph
plx = -2.5:0.01:2.5;
ply = (-FinalTheta(2)/FinalTheta(3)).*plx - (FinalTheta(1)/FinalTheta(3));
plot(plx , ply , 'm','LineWidth',2);
xlabel('x1');
ylabel('x2');
title('Logistic Regression and corresponding decision boundary','FontSize',13);
leg = legend('Positive Pts','Negative Pts','Decision Boundary');
set(leg,'FontSize',13);