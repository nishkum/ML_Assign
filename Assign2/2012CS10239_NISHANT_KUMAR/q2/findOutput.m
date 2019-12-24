function [o1, o2, o3] = findOutput(th1,th2,inp)
% Assume the neural network has 1 hidden layer .. and th1 and th2 are the
% theta matrices .. and inp is the input

o1 = inp;
o2 = [1; sigmoid(th1*o1)];
o3 = sigmoid(th2*o2);

end