clear;
clc;

% N fold cross validation
N = 5;
tacc = 0;
randAcc = 0;

% First find the vocab size and classSize
temp = load('vocab.dat');
vocabSize = temp(1);
classSize = temp(2);
confusionMat = zeros(classSize, classSize);

for i=0:N-1
    % Use test_i.dat and train_i.dat
    testfile = strcat('test_',int2str(i),'.dat');
    trainfile = strcat('train_',int2str(i),'.dat');
    testdata = csvread(testfile);
    traindata = csvread(trainfile);
    [temp, temp1] = testAcc(traindata, testdata, vocabSize, classSize);
    % temp is the testAccuracy and temp1 is the confusionMatrix part
    confusionMat = confusionMat + temp1;
    tacc = tacc + temp;
    randAcc = randAcc + randomAcc(classSize, testdata);
end

tacc = tacc/N;
randAcc = randAcc/N;
confusionMatAvg = confusionMat/N;
fprintf('The test accuracy from Naive Bayes = %.5f\n',tacc);
fprintf('The test accuracy from random prediction = %.5f\n',randAcc);
fprintf('The summed confusion matrix: \n');
confusionMat
fprintf('The average confusion matrix: \n');
confusionMatAvg
save('Prob1Data');