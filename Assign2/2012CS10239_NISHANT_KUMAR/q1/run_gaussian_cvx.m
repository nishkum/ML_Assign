% Script to run gaussian kernel cvx on train-small

clear;
clc;

gamma = 2.5e-4;
data = load('train-small_cvx.txt');
Y = data(:,1);
X = data(:,2:size(data,2));
[m,n] = size(X);

% Prepare the value of Q
Q = zeros(m);
for i=1:m
    for j=1:m
        temp = (X(i,:)-X(j,:))';
        Q(i,j) = -0.5*Y(i)*Y(j)*exp(-gamma*(temp'*temp));
    end
end

b = ones(m,1);
% Now the objective function will be A'*Q*A + b'*A

cvx_begin
    variable A(m)
    maximize( A'*Q*A + b'*A )
    subject to
        0 <= A <= 1; % C is given to be 1
        Y'*A == 0;
cvx_end

save('cvx-train-small_gaussian.mat');