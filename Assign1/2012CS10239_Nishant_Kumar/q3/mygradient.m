function G = mygradient(dataX,dataY,Htheta)
% This function returns the gradient of the log-likelihood -L(theta)
% function. 
% Input - the Xdata, the Ydata and Htheta evaluated at each example
% Output - the gradient = sum over i(Yi - Htheta(Xi,Theta)*Xi)

G = dataX'*(dataY - Htheta);

end