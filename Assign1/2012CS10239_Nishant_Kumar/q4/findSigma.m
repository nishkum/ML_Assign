function [Sigma0,Sigma1,Sigma,Phi] = findSigma(Xzero,Xone,Ylog,Mu0,Mu1)
% Finds the various parameters of GDA
% Input - Xzero : the set of DataPoints with y=0, Xone : the set of data
%   points with y=1 , Ylog = a logical vector with Ylog(i) = true iff y=1,
%   Mu0 and Mu1 : the 2 classes' means
% Output - Sigma0 : covariance matrix of class y=0 , Sigma1 : covar matrix
%   of class y=1 , Sigma : covar matrix assuming Sigma0 = Sigma1 , Phi =
%   Pr[y=1]

m0 = size(Xzero,1);
m1 = size(Xone,1);

temp0 = Xzero;
temp1 = Xone;

for i=1:m0
    temp0(i,:) = Xzero(i,:) - Mu0';
end

for i=1:m1
    temp1(i,:) = Xone(i,:) - Mu1';
end

Sigma0 = (temp0'*temp0)./m0;
Sigma1 = (temp1'*temp1)./m1;
Phi = m1/(m0+m1);
Sigma = Phi.*Sigma1 + (1-Phi).*Sigma0;
end