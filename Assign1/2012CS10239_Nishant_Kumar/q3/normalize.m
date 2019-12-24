function N = normalize(X)
% Normalize the input data - i.e. X changes to (X-mean(X))./std(X)
% New normalized data has mean = 0 and std deviation = 1

N = zscore(X);
end