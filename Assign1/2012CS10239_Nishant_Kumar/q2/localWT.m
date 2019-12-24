function lwt = localWT(X , Y , x , band)
% Input - X: the Xdata , Y: the Ydata , x : the point at which to calculate
%           and return y , band : the bandWidth parameter
% Output - The value of htheta(x) or y corresponding to this point with theta
%       evaluated using normal equation

% Note:
% -x here does not have x(0) ,i.e. in this question is just a scalar
% -Since the weights in the weighted linear regression depend on x, so this
%   function takes as input x also

m = size(X,1);
W = zeros(m);
ptx = [1;x];

% prepare W using the exp distribution
for i = 1:m
    W(i,i) = exp((-1*((x - X(i,2))^2))/(2*band*band));
end

% Use normal equation to get the theta corresponding to this point and
% return the value of hTheta(x)
theta = inv(X'*W*X)*X'*W*Y;
lwt = theta'*ptx;

end