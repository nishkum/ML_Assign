function lTh = Ltheta(datay , hTheata)
% This function returns the log-likelihood function for logistic regression
% Input - the Ydata and Htheta
% Output - Ltheta function = sum(Yi*log(Htheta)) + sum(Yi*(1-log(Htheta))

m = size(datay, 1);

logHTheta = log(hTheata);
logOneMHTheta = log(1 - hTheata);

lTh = datay'*logHTheta + (1-datay)'*logOneMHTheta;

end