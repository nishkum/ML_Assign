function N = normalize(X)
% This function just normalizes the input matrix X

N = zscore(X);

% Another way could have been to use the following
% av = mean(X)
% sd = std(X,1)
% N = (X - av)./sd
end