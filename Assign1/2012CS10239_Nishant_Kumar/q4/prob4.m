% This is the script for question(4)

% Clear the command window and the workspace
clc;
clear;

% Load the data
X = importdata('./q4x.dat');
Y = importdata('./q4y.dat');

m = size(X,1);

% Normalize data
NX = normalize(X);
NY = zeros(m,1);

% NY = 1 for Alaska and 0 OW 
% Ylog = true for Alaska and false OW
Ylog = logical(zeros(m,1));
for i=1:m
    % Compare the current entry with "Alaska", if equal then put 1 in NY else
    % put 0 in NY
    if (strcmp(Y(i) , 'Alaska') == 1) 
        NY(i) = 1;
        Ylog(i) = true;
    else
        NY(i) = 0;
        Ylog(i) = false;
    end
end

% Prepare Xone and Xzero from X using Ylog
Xone = NX;
Xzero = NX;

Xone(~Ylog,:) = [];
Xzero(Ylog,:) = [];

% Plot the original data
figure(1);
hold on;
scatter(Xone(:,1),Xone(:,2),'r+');
scatter(Xzero(:,1),Xzero(:,2),'b*');

m0 = size(Xzero , 1);
m1 = size(Xone , 1);

% Find the values of Mu0 , Mu1 and SigmaEq using closed form equations
Mu0 = mean(Xzero)'
Mu1 = mean(Xone)'
[Sigma0, Sigma1, Sigma, Phi] = findSigma(Xzero,Xone,Ylog,Mu0,Mu1)


miniVal = min(NX);
maxiVal = max(NX);

syms x1 x2 x lin quad;
x = [x1;x2];

% Now plot the linear boundary
lin = 2.*(x'*inv(Sigma)*(Mu0-Mu1)) + Mu1'*inv(Sigma)*Mu1 - Mu0'*inv(Sigma)*Mu0;

linearPlot = ezplot(lin,[miniVal(1),maxiVal(1)]);
set(linearPlot,'Color','m','LineWidth',1.5);

% Now plot the quadratic boundary
quad = (x-Mu1)'*inv(Sigma1)*(x-Mu1) - (x-Mu0)'*inv(Sigma0)*(x-Mu0) - log(det(Sigma0)/det(Sigma1));

quadPlot = ezplot(quad,[miniVal(1),maxiVal(1)]);
set(quadPlot,'Color','k','LineWidth',1.5);

title('Gaussian Discriminant Analysis - Linear and Quadratic Separator','FontSize',13);
leg = legend('Salmons from Alaska (y = 1)','Salmons from Canada (y = 0)','Linear Boundary','Quadratic Boundary');
set(leg,'FontSize',13);
