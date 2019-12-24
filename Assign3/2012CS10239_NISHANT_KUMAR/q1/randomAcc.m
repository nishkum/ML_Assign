function acc = randomAcc(numclasses, testdata)

testSize = size(testdata,1);
testActualLabels = testdata(:,1);

predictMat = randi(numclasses, [testSize,1]);

acc = sum(predictMat == testActualLabels)/testSize;
end