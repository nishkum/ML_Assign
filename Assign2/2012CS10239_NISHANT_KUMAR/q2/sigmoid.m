function gx = sigmoid(xv)
% x can be a matrix/vector

gx = 1./(1+exp(-1*xv));

end