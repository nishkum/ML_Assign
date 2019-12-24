function [acc, cMat] = testAcc(traindata, testdata, vocabSize, numclasses)
   
   cMat = zeros(numclasses, numclasses);
   classlabels = traindata(:,1);
   m = size(classlabels, 1);
   
   trainDim = size(traindata);
   testDim = size(testdata);
   
   % Remember this has log of apt paras
   phiClass = zeros(numclasses,1);
   for i=1:numclasses
       % Since using -log()
       phiClass(i) = -(log(sum(classlabels==i))-log(m));
   end
   
   % Remember this has log of apt paras
   phiMult = zeros(numclasses, vocabSize);
   
   for i=1:m
       for j=2:trainDim(2)
           if (traindata(i,j)==0)
               break
           end
           phiMult(traindata(i,1), traindata(i,j)) = phiMult(traindata(i,1), traindata(i,j)) + 1;
       end
   end
   
   for i=1:numclasses
       curData = traindata(classlabels==i,2:trainDim(2));
       totWords = sum(sum(curData>0));
       % Since using -log()
       phiMult(i,:) = -log(phiMult(i,:)+1) + log(totWords + vocabSize);
   end
   
   % Now predict on testdata
   testSize = size(testdata,1);
   testActualLabels = testdata(:,1);
   toTestData = testdata(:,2:testDim(2));
   
   predictMatrix = zeros(testSize,1);
   for i=1:testSize
       curTestData = toTestData(i,:);
       tillNowMaxInd = -1;
       tillNowMaxValue = Inf; % Since using -log()
       for j=1:numclasses
            % Find log(p(y==j|i))
            curEstimate = 0;
            for k=1:testDim(2)-1
                if curTestData(k)==0
                    break
                end
                % add log(P(x_j|y==j))
                curEstimate = curEstimate + phiMult(j, curTestData(k));
            end
            curEstimate = curEstimate + phiClass(j);
            % Since using -log()
            if (curEstimate < tillNowMaxValue)
                tillNowMaxValue = curEstimate;
                tillNowMaxInd = j;
            end
       end
       predictMatrix(i) = tillNowMaxInd;
       cMat(testActualLabels(i), tillNowMaxInd) = cMat(testActualLabels(i), tillNowMaxInd) + 1;
   end
   
   acc = sum(predictMatrix == testActualLabels)/testSize;
end