function jTheta = calJtheta(datax,datay,theta)
% This function calculates the value of JTheta with the input theta
% Input - Xdata, Ydata, Theta
% Output - The JTheta value calculated at each point of the Xdata.

% temp = Y - X*Theta
m = size(datax,1);
temp = datay - datax*theta;
jTheta = (temp'*temp)/(2*m);

end