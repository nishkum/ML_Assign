function [thFinal,Jfinal,numIter,iterTheta,iterJtheta] = batchGD(thInit,lRate,eps,datax,datay)
% This function runs the Batch-Gradient Descent algorithm
% Input : thInit - the initial value of Theta , lRate : the learning Rate,
%       eps - epsilon, datax : Xdata, datay - Ydata
% Output - thFinal - the Final value of Theta obtained, Jfinal - the min
%       value of JTheta obtained, numIter - the number of iterations taken,
%       iterTheta - a (numIter*n) matrix to store all the intermediate
%       values of theta, iterJtheta - all the values of JTheta obtained
%       during the iterations

[m,n] = size(datax);

% Inititalize variables
numIter = 0;
thIter = thInit;

curJth = 0;
lastJth = -100;

% Create a matrix for iterTheta and iterJtheta .. with size =
%   maxIterAllowed .. and at the end shrink the matrix to apt size finally.
maxIterAllowed = 8000;
iterTheta = ones(maxIterAllowed,n);
iterJtheta = ones(maxIterAllowed);

while(abs(curJth - lastJth) >= eps)
    numIter = numIter + 1;
    
    % Assert that numIter is less than maxIterAllowed
    assert(numIter<=maxIterAllowed);
    
    temp = (datay - (datax*thIter));
    lastJth = curJth;
    curJth = (temp'*temp)/(2*m);
    
    % Add the current values of thIter and curJth to the vector
    iterTheta(numIter,:) = thIter';
    iterJtheta(numIter) = curJth;
    
    % Update the value of Theta 
    thIter = thIter + ((lRate/m) .* (datax' * temp));
end

% Shrink the matrix to remove unwanted entries.
iterTheta((numIter+1):1:maxIterAllowed , :) = [];
iterJtheta((numIter+1):1:maxIterAllowed) = [];

thFinal = thIter;
Jfinal = curJth;