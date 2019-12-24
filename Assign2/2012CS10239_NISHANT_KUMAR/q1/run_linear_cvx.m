% Script to run linear kernel using cvx on train-small

clear;
clc;

data = load('train-small_cvx.txt');
Y = data(:,1);
X = data(:,2:size(data,2));

[m,n] = size(X);

XY = zeros(size(X));
for i = 1:m
    XY(i,:) = Y(i).*X(i,:);
end

% Now the objective function will be A'*Q*A + b'*A
Q = -0.5.*(XY*XY');
b = ones(m,1);

cvx_begin
    variable A(m)
    maximize( A'*Q*A + b'*A )
    subject to
        0 <= A <= 1; % C is given to be 1
        Y'*A == 0;
cvx_end

save('cvx-train-small_linear.mat');