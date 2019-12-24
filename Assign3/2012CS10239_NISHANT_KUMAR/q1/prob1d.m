% This script plots the graph of prob1d
clear;
% clc;

% 5 fold cross validation
N = 5;

% First find the vocab size and classSize
temp = load('vocab.dat');
vocabSize = temp(1);
classSize = temp(2);

test0 = csvread('test_0.dat');
test1 = csvread('test_1.dat');
test2 = csvread('test_2.dat');
test3 = csvread('test_3.dat');
test4 = csvread('test_4.dat');
test = {test0, test1, test2, test3, test4};

train0 = csvread('train_0.dat');
train1 = csvread('train_1.dat');
train2 = csvread('train_2.dat');
train3 = csvread('train_3.dat');
train4 = csvread('train_4.dat');
train = {train0, train1, train2, train3, train4};


trainDataSize = 1000;
xArr = zeros(1,6);
yArr = zeros(1,6);
trainArr = zeros(1,6);
ct = 1;
while(trainDataSize <= 6000)
    if trainDataSize==6000
        trainDataSize = 5784;
    end
    tacc = 0;
    trainacc = 0;
    for i=1:N
        % Use test_i.dat and train_i.dat
        testdata = test{i};
        traindata = train{i};
        traindata = traindata(1:trainDataSize,:);
        [traina, testa] = traintestAcc1d(traindata, testdata, vocabSize, classSize);
        tacc = tacc + testa;
        trainacc = trainacc + traina;
    end
    
    tacc = tacc/N;
    trainacc = trainacc/N;
    xArr(ct) = trainDataSize;
    yArr(ct) = tacc;
    trainArr(ct) = trainacc;
    trainDataSize = trainDataSize + 1000;
    ct = ct+1;
end

hold on;
plot(xArr, yArr,'r','Linewidth',1.5);
plot(xArr, trainArr,'b','Linewidth',1.5);
title('Learning curve for train and test data','FontSize',13);
leg = legend('Test Accuracy','Train Accuracy','Location','SouthEast');
set(leg,'FontSize',13);
