function [fTheta,numIter] = newton(thInit , datax ,datay , eps)
% This function runs the newton's method to optimize log-likelihood
% function for logistic regression.
% Input - the initial theta, Xdata , Ydata , epsilon
% Output - the final Theta and the number of iterations

thIter = thInit;
prevLTheta = 100;
curLTheta = 0;
numIter = 0;

while(abs(curLTheta - prevLTheta) >= eps)
    
    % The iteration body
    numIter = numIter + 1;
    hTheta = myHtheta(datax , thIter);
    grd = mygradient(datax , datay , hTheta);
    hess = myhessian(datax , hTheta);
    
    thIter = thIter - inv(hess)*grd;
    
    % Now update the LTheta and OneMinusLTheta
    prevLTheta = curLTheta;
    curLTheta = Ltheta(datay , hTheta);
end

fTheta = thIter;

end