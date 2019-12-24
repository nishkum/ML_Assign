function sig = sigmoid(theta , xi)
% This function just returns the sigmoid function evaluated at theta'*xi

z = theta'*xi;
sig = 1/(1+exp(-1*z));

end