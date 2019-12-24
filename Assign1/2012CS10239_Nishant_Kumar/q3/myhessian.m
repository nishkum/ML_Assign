function H = myhessian(dataX , Htheta)
% This function evaluates the hessian of the log-likelihood function for
% logistic regression.
% Input - the Xdata and Htheta calcuated at each training example
% Output - The hessian 
% Note - hessian takes as input the htheta and so it is implicitly
% evaluation the hessian at the theta at which the hTheta is evaluated

m = size(dataX,1);
S = zeros(size(m));
for i=1:m
    S(i,i) = Htheta(i)*(1-Htheta(i));
end

H = -1*dataX'*S*dataX;
end