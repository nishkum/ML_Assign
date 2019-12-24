% Script to run libSVM solver for both linear and guassian kernel

clear;
clc;

[label, inst] = libsvmread('train-small_libsvm.txt');
[testlabel, testinst] = libsvmread('test_train-small_features_libsvm.txt');

% Linear Kernel
linModel = svmtrain(label, inst, '-s 0 -t 0');
[linPredicLabel, linPredicAcc, linPredicDec] = svmpredict(testlabel, testinst, linModel);

% Gaussian kernel
gauModel = svmtrain(label, inst, '-s 0 -t 2 -g 2.5e-4');
[gauPredicLabel, gauPredicAcc, gauPredicDec] = svmpredict(testlabel, testinst, gauModel);