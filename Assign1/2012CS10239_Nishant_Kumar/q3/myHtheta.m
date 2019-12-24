function hT = myHtheta(datax , theta)
% This function calculates HTheta for each of the training examples at
% theta.
% Input - the Xdata and the theta at which to evaluate
% Output - Htheta vector

m = size(datax,1);
hT = zeros(m,1);
for i=1:m
    hT(i) = sigmoid(theta , datax(i,:)');
end

end